<?php

namespace app\common\logic;

use app\admin\model\UserModel;
use app\agent\model\AgentLogModel;
use app\api\model\BankStatementModel;
use app\common\library\enum\CodeEnum;
use app\common\model\EwmPayCode;
use app\common\model\GemapayCodeModel;
use app\ms\Logic\SecurityLogic;
use app\pay\controller\PayController;
use think\Db;

class CodeLogic extends BaseLogic
{

    public function getQueenPostion($codeId, $type, $admin_id)
    {
        $Queue = new Queuev1Logic();
        //获取队列
        $code_queue = $Queue->get($type, $admin_id);
        //如果不在队列中 返回0

        if (!$code_queue || !in_array($codeId, $code_queue)) {
            return '2147483647';
        }
        //在队列中 返回键+1
        return $Queue->kget($codeId, $type, $admin_id) + 1;

    }


    /**
     * 添加二维码现在只要银行卡
     * @param $data
     * @return array
     */
    public function addQRcode($insertData)
    {
        //验证安全码
        $UserModel = $this->modelMs;
        $userId    = session('agent_id');
        $userInfo  = $UserModel->find($userId);
        //是否设置费率
//        if (empty($userInfo['bank_rate'])) {
  //          return ['code' => CodeEnum::ERROR, 'msg' => '未找到银行卡费率'];
    //    }

        $SecurityLogic = new SecurityLogic();
        $res           = $SecurityLogic->checkSecurityByUserId($userId, $insertData['security']);
        if ($res['code'] == CodeEnum::ERROR) {
            return $res;
        }

        $data['ms_id']          = $userId;
        $data['bank_name']      = $insertData['bank_name'];
        $data['account_name']   = $insertData['account_name'];
        $data['account_number'] = $insertData['account_number'];
        $data['bonus_points']   = $userInfo['bank_rate'];
        $data['user_name']      = $userInfo['username'];
        $data['create_time']    = time();
        $data['updated_at']     = time();
        $data['status']         = $insertData['is_active'];
        $result                 = $this->modelEwmPayCode->insertGetId($data);
        if (!$result) {
            return ['code' => CodeEnum::ERROR, 'msg' => '保存失败,请一会儿再试'];
        }
        $is_active = $insertData['is_active'];
        //如果激活 添加到队列
        if ($is_active && $userInfo['work_status'] == 1) {
            $QueueLogic               = new Queuev1Logic();
            $userInfo['add_admin_id'] = 1;//写死
            $QueueLogic->radd($result, 3, $userInfo['add_admin_id']);

        }
        return ['code' => CodeEnum::SUCCESS, 'msg' => '添加成功'];
    }


    /**
     * 激活二维码
     * @param $userId
     * @param $codeId
     * @return array
     */
    public function activeCode($userId, $codeId)
    {
        $UserModel                = $this->modelMs;
        $userinfo                 = $UserModel->where(['userid' => $userId])->find();
        $GemapayCodeModel         = $this->modelEwmPayCode;
        $where['id']              = $codeId;
        $where['ms_id']           = $userId;
        $data['status']           = $GemapayCodeModel::STATUS_YES;
        $data['forbidden_reason'] = '';
        $data['updated_at']       = time();
        $codeInfo                 = $GemapayCodeModel->where($where)->find();
        $ret                      = $GemapayCodeModel->where($where)->update($data);
        if ($ret !== false) {
            //判断用户是否在开工
            $user = $UserModel->where(['userid' => $userId])->find();
            if ($user['work_status'] == CodeEnum::SUCCESS) {
                $QueueLogic       = new Queuev1Logic();
                $codeInfo['type'] = 3;
                $QueueLogic->radd($codeId, $codeInfo['type'], 1);
            }
            return ['code' => CodeEnum::SUCCESS, 'msg' => '激活成功！'];
        } else {
            return ['code' => CodeEnum::ERROR, 'msg' => '已经激活成功！'];
        }
    }


    /**
     * 冻结二维码
     * @param $userId
     * @param $codeId
     * @return array
     */
    public function disactiveCode($userId, $codeId)
    {
        $UserModel          = $this->modelMs;
        $userinfo           = $UserModel->where(['userid' => $userId])->find();
        $GemapayCodeModel   = $this->modelEwmPayCode;
        $codeInfo           = $GemapayCodeModel->find($codeId);
        $where['id']        = $codeId;
        $where['ms_id']     = $userId;
        $data['status']     = $GemapayCodeModel::STATUS_NO;
        $data['updated_at'] = time();
        $ret                = $GemapayCodeModel->where($where)->update($data);
        if ($ret !== false) {
            $QueueLogic = new Queuev1Logic();
            $QueueLogic->delete($codeId, 3, 1);
            return ['code' => CodeEnum::SUCCESS, 'msg' => '冻结成功！'];
        } else {
            return ['code' => CodeEnum::ERROR, 'msg' => '已经冻结成功！'];
        }
    }


    public function getBalanceInfo($codeId)
    {
        $GemapayCodeModel = $this->modelEwmPayCode;
        $codeInfo         = $GemapayCodeModel->find($codeId);
        return $codeInfo['balance'] ? $codeInfo['balance'] : '0.00';
    }


    /**
     * @param $bank_id  银行卡ID
     * @param int $chang_type 1：充值 2：代付扣减
     * @param $type '1：增加 2：减少'
     * @param $remarks  描述
     */
    public function addLogs($bank_id, $amount, $chang_type = 1, $type = 1, $remarks, $createTime = 0)
    {
        $GemapayCodeModel = $this->modelEwmPayCode;
        $bank             = $GemapayCodeModel->where(['id' => $bank_id])->find();
        if ($bank) {
            $bank['create_time'] = $createTime ? $createTime : time();
            $bank['balance']     = $bank['balance'] ? $bank['balance'] : '0.00';
            $data['bank_id']     = $bank_id;
            $data['chang_type']  = $chang_type;
            $data['type']        = $type;
            $data['amount']      = $amount;
            $data['preinc']      = $bank['balance'];
            $data['suffixred']   = $type == 2 ? bcsub($bank['balance'], $amount, 3)
                : bcadd($data['preinc'], $amount, 3);
            $data['remarks']     = $remarks; //改变备注
            //添加日志记录
            $this->modelDepositeCardLog->setInfo($data);
            //增减金额
            $GemapayCodeModel->setIncOrDec(['id' => $bank_id], $type == 2 ? 'setDec' : 'setInc', 'balance', $amount);
            return true;
        } else {
            throw new Exception('当前银行卡状态异常');
        }
    }

    public function getCodeList()
    {
        $GemapayCodeModel = $this->modelEwmPayCode;
        $bank             = $GemapayCodeModel->order('balance desc')->join('cm_ms u', "u.userid=ms_id", "LEFT")->select();
        return $bank;
    }


    public function delTrans($transId)
    {
        $map['id'] = $transId;
        $trans     = $this->modelTixianTranslist->where($map)->find();
        if (empty($trans)) {
            return ['code' => CodeEnum::ERROR, 'msg' => '当前记录不存在！'];
        }
        if ($trans['status'] == 2) {
            return ['code' => CodeEnum::ERROR, 'msg' => '当前记录已完成,不可删除！'];
        }

        $res = $this->modelTixianTranslist->where($map)->delete();
        if ($res == false) {
            return ['code' => CodeEnum::ERROR, 'msg' => '删除失败！'];
        }
        return ['code' => CodeEnum::SUCCESS, 'msg' => '删除成功！'];
    }

    public function saveTransInfo($data)
    {
        //得到提现的信息
        $where['id']   = $data['trans_id'];
        $tixianInfo    = $this->modelBalanceCash->getInfo($where, '*');
        $bank_name     = $tixianInfo['bank_name'];
        $bank_realname = $tixianInfo['bank_realname'];
        $bank_number   = $tixianInfo['bank_number'];
        $amount        = $tixianInfo['amount'];

        //判断已经存入的提现信息 去除驳回的信息
        $where           = 'status!=2 & trans_id=' . $data['trans_id'];
        $map['status']   = ['in', [1, 2]];
        $map['trans_id'] = $data['trans_id'];
        $alreadyAmount   = $this->modelTixianTranslist->where($map)->sum('amount');
        if ($alreadyAmount + $data['money'] > $amount) {
            return ['code' => CodeEnum::ERROR, 'msg' => '转发金额大于提现金额！'];
        }
        if (empty($data['money'])) {
            return ['code' => CodeEnum::ERROR, 'msg' => '转发金额不能为0！'];
        }
        $insertdata['trans_id']    = $data['trans_id'];
        $insertdata['amount']      = $data['money'];
        $insertdata['bank_number'] = $bank_number;
        $insertdata['bank_owner']  = $bank_realname;
        $insertdata['status']      = 1;
        $insertdata['create_time'] = time();
        $insertdata['update_time'] = time();
        $insertdata['bank_name']   = $bank_name;
        $insertdata['card_id']     = $data['cnl_id'];
        $codeinfo                  = $this->modelEwmPayCode->where('id=' . $insertdata['card_id'])->find();
        //var_dump($codeinfo );die();
        $insertdata['user_id'] = $codeinfo['ms_id'];
        //var_dump(1);die();
        $this->modelTixianTranslist->insert($insertdata);

        //转发提现信息给上游渠道
        //申请人提现的账户信息
        $fields  = ['a.*', 'b.name as banker_name'];
    //    $account = $this->logicUserAccount->getAccountList(['a.id' => $tixianInfo['account']], $fields, '', false);
    //    $account = $account[0];
        //码商转卡信息
        $trans = $this->modelEwmPayCode->where(['id' => $data['cnl_id']])->find();

        $message = "{$amount}
{$insertdata['bank_name']}
{$insertdata['bank_owner']}
{$insertdata['bank_number']}
通过下面这张卡转
{$trans['bank_name']}
{$trans['account_name']}
{$trans['account_number']}
";
        //找到对应渠道推送消息
        try {
            $channel = $this->modelPayChannel->where(['remarks' => $codeinfo['ms_id']])->find();
            if (empty($channel)) {
                throw  new \Exception("当前码商未绑定相应渠道,推送消息到渠道失败！！");
            }
            if (empty($channel['tg_group_id'])) {
                throw  new \Exception("渠道未绑定tg群组,请先绑定！！");
            }
            $this->logicTgLogic->sendMessageTogroup($message, $channel['tg_group_id']);
        } catch (\Exception $exception) {
            \think\Log::error($exception->getMessage());
        } finally {
            return ['code' => CodeEnum::SUCCESS, 'msg' => '转发成功！'];
        }
    }
}
