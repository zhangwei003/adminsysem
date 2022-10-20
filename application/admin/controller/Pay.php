<?php
/**
 *  +----------------------------------------------------------------------
 *  | 中通支付系统 [ WE CAN DO IT JUST THINK ]
 *  +----------------------------------------------------------------------
 *  | Copyright (c) 2018 http://www.iredcap.cn All rights reserved.
 *  +----------------------------------------------------------------------
 *  | Licensed ( https://www.apache.org/licenses/LICENSE-2.0 )
 *  +----------------------------------------------------------------------
 *  | Author: Brian Waring <BrianWaring98@gmail.com>
 *  +----------------------------------------------------------------------
 */

namespace app\admin\controller;


use app\common\library\enum\CodeEnum;
use think\Db;

class Pay extends BaseAdmin
{
    /**
     * 支付方式
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 支付渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function channel()
    {
        return $this->fetch();
    }


    /**
     * 渠道回收站
     * @return mixed
     */
    public function channelHs()
    {
        return $this->fetch();
    }


    /**
     * 支付渠道账户
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function account()
    {
        $this->assign('cnl_id', $this->request->param('cnl_id'));
        return $this->fetch();
    }

    /**
     * 银行
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function bank()
    {
        return $this->fetch();
    }

    /**
     * 支付渠道列表
     * @url getChannelList?page=1&limit=10
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getCodeList()
    {

        $where = [];
        //code
        !empty($this->request->param('code')) && $where['code']
            = ['eq', $this->request->param('code')];
        //name
        !empty($this->request->param('name')) && $where['name']
            = ['like', '%' . $this->request->param('name') . '%'];

        $data = $this->logicPay->getCodeList($where, true, 'create_time desc', false);

        $count = $this->logicPay->getCodeCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }


    /*
   *用户支付渠道pay_code
   *
   */
    public function codes()
    {
        $co_id = $this->request->param('id');
        if ($this->request->isPost()) {
            $data = $this->request->post('r/a');
//            echo json_encode($data);die();
            $this->result($this->logicUser->doPayCodesUser($co_id, $data));
        }
        $data = $this->logicUser->getUserList([], true, 'create_time desc', false);
        foreach ($data as $k => $v) {
            $userCode = $this->logicUser->userPayCode(['uid' => $v['uid'], 'co_id' => $co_id]);
            $data[$k]['status'] = $userCode ? $userCode['status'] : -1;
        }
        $this->assign('list', $data);;
        return $this->fetch();
    }

    /**
     * 开启全部商户code
     */
    public function openUserCode()
    {
        $co_id = $this->request->param('id');
        $this->result($this->logicUser->setUserCodeStatus($co_id, '1'));
    }

    /**
     * 关闭全部商户code
     */
    public function closeUserCode()
    {
        $co_id = $this->request->param('id');
        $this->result($this->logicUser->setUserCodeStatus($co_id, '0'));
    }


    /**
     * 支付渠道列表
     * @url getChannelList?page=1&limit=10
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getChannelList()
    {

        $where = [];
        //组合搜索
        !empty($this->request->param('id')) && $where['id']
            = ['eq', $this->request->param('id')];
        //name
        !empty($this->request->param('name')) && $where['name']
            = ['like', '%' . $this->request->param('name') . '%'];


        $data = $this->logicPay->getChannelList($where, true, 'create_time desc', false);
        $where['status'] = 1;
        $count = $this->logicPay->getChannelCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }

    public function getChannelHsList()
    {

        $where = [];
        //组合搜索
        !empty($this->request->param('id')) && $where['id']
            = ['eq', $this->request->param('id')];
        //name
        !empty($this->request->param('name')) && $where['name']
            = ['like', '%' . $this->request->param('name') . '%'];

        $where['status'] = -1;

        $data = $this->logicPay->getChannelList($where, true, 'create_time desc', false);
        $count = $this->logicPay->getChannelCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }

    /**
     * 支付渠道账户列表
     * @url getChannelList?page=1&limit=10
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getAccountList()
    {
        $where = [];
        $cnl_id = $this->request->param('cnl_id', 0, 'intval');
        if ($cnl_id) {
            $where = [
                'cnl_id' => $cnl_id,
            ];
        }

        //组合搜索
        !empty($this->request->param('id')) && $where['id']
            = ['eq', $this->request->param('id')];
        //name
        !empty($this->request->param('name')) && $where['name']
            = ['like', '%' . $this->request->param('name') . '%'];


        $data = $this->logicPay->getAccountList($where, true, 'create_time desc', false);
	foreach ($data as $k => $v){
		$accout  = $this->logicPay->getChannelList(['id'=>$v['cnl_id']], 'name','create_time desc',false);
		if(empty($accout))
		{
		   unset($data[$k]);
		   continue;
		}
		 
	    $data[$k]['rate'] = sprintf('%.2f',(1-$data[$k]['rate'])*100);
            $data[$k]['name'] = $accout[0]['name'] . '-' . $v['name'];
        }
//        dump($data[0]['channels']);
        $count = $this->logicPay->getAccountCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }

    /**
     * 支付渠道列表
     * @url getChannelList?page=1&limit=10
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function getBankList()
    {

        $where = [];
        //组合搜索
        !empty($this->request->param('keywords')) && $where['id|name']
            = ['like', '%' . $this->request->param('keywords') . '%'];

        $data = $this->logicBanker->getBankerList($where, true, 'create_time desc', false);

        $count = $this->logicBanker->getBankerCount($where);

        $this->result($data || !empty($data) ?
            [
                'code' => CodeEnum::SUCCESS,
                'msg' => '',
                'count' => $count,
                'data' => $data
            ] : [
                'code' => CodeEnum::ERROR,
                'msg' => '暂无数据',
                'count' => $count,
                'data' => $data
            ]);
    }

    /**
     * 新增支付渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function addChannel()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->saveChannelInfo($this->request->post()));
        return $this->fetch();
    }
    
    /**
     * 快速新增支付渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function fastadd()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->savefastadd($this->request->post()));
        return $this->fetch();
    }

    /**
     * 新增渠道账户
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function addAccount()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->saveAccountInfo($this->request->post()));

        //获取渠道列表
        $channel = $this->logicPay->getChannelList([], true, 'create_time desc', false);
        //获取方式列表
        $codes = $this->logicPay->getCodeList([], true, 'create_time desc', false);

        $this->assign('cnl_id', $this->request->param('cnl_id'));

        $this->assign('channel', $channel);
        $this->assign('codes', $codes);

        return $this->fetch();
    }

    /**
     * 新增支付方式
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function addCode()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->saveCodeInfo($this->request->post()));
        //支持渠道列表
        $this->assign('channel', $this->logicPay->getChannelList([], 'id,name', 'id asc'));

        return $this->fetch();
    }

    /**
     * 新增支付银行
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function addBank()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicBanker->saveBankerInfo($this->request->post()));

        return $this->fetch();
    }

    /**
     * 编辑支付渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function editChannel()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->saveChannelInfo($this->request->post()));
        //获取渠道详细信息
        $channel = $this->logicPay->getChannelInfo(['id' => $this->request->param('id')]);
        //时间转换
        $channel['timeslot'] = json_decode($channel['timeslot'], true);
        //ip装换
        $channel['notify_ips'] = explode(',', $channel['notify_ips']);
        $this->assign('channel', $channel);
        return $this->fetch();
    }


    public function adminSysChannel(){
        
        $this->request->isPost() && $this->result($this->logicPay->AdminSysChannel($this->request->post()));

        $channel = $this->logicPay->getChannelInfo(['id' => $this->request->param('id')],'timeout,transfer_add,transfer_status,id');
        
        $zfConfigArr = require_once('./data/conf/zfconfig.php');
        
        $transfer_add = $zfConfigArr['transfer_add'];
        
        $this->assign('data',$transfer_add );

        $this->assign('channel', $channel);

        return $this->fetch();
    }

    /**
     * 编辑支付渠道
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function editAccount()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicPay->saveAccountInfo($this->request->post()));
        //获取账户详细信息
	$account = $this->logicPay->getAccountInfo(['id' => $this->request->param('id')]);
	$account['rate'] =(1-$account['rate'])*100;
        //时间转换
        $account['timeslot'] = json_decode($account['timeslot'], true);
        //获取方式列表
        $codes = $this->logicPay->getCodeList([], true, 'create_time desc', false);
        //获取渠道列表
        $channels = $this->logicPay->getChannelList([], true, 'create_time desc', false);

        $this->assign('codes', $codes);
        $this->assign('channels', $channels);
        $this->assign('account', $account);

        return $this->fetch();
    }

    /**
     * 编辑支付方式
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function editCode()
    {
        // post 是提交数据

        $this->request->isPost() && $this->result($this->logicPay->saveCodeInfo($this->request->post()));

        $accountCnl = $this->modelPayAccount
            ->where("find_in_set({$this->request->param('id')}, co_id)")
            ->where('status', 1)
            ->column('cnl_id');
        //支持渠道列表
        $this->assign('channel', $this->logicPay->getChannelList(['id' => ['in', $accountCnl]], 'id,name', 'id asc', false));

        //获取支付方式详细信息
        $this->assign('code', $this->logicPay->getCodeInfo(['id' => $this->request->param('id')]));
        return $this->fetch();
    }

    /**
     * 编辑支付银行
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function editBank()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicBanker->saveBankerInfo($this->request->post()));
        //获取支付方式详细信息
        $this->assign('bank', $this->logicBanker->getBankerInfo(['id' => $this->request->param('id')]));

        return $this->fetch();
    }

    public function delBank()
    {
        $this->request->isPost() && $this->result($this->logicBanker->delBankerInfo(['id' => $this->request->param('id')]));
    }

    /**
     * 删除支付方式
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function delCode()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicPay->delCode(
                [
                    'id' => $this->request->param('id')
                ])
        )->delete( [
            'id' => $this->request->param('id')
        ]);

        // get 直接报错
        $this->error('未知错误');
    }

    /**
     * 删除渠道
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function delChannel()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicPay->delChannel(
                [
                    'id' => $this->request->param('id')
                ])
        );

        // get 直接报错
        $this->error('未知错误');
    }


    public function deleteChannel()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicPay->deleteChannel(
                [
                    'id' => $this->request->param('id')
                ])
        );

        // get 直接报错
        $this->error('未知错误');
    }


    /*
     *还原channel
     *
     */
    public function hyChannel()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicPay->hyChannel(
                [
                    'id' => $this->request->param('id')
                ])
        );

        // get 直接报错
        $this->error('未知错误');
    }


    /**
     * 删除渠道账户
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function delAccount()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicPay->delAccount(
                [
                    'id' => $this->request->param('id')
                ])
        );

        // get 直接报错
        $this->error('未知错误');
    }


    /*
     *批量设置用户对应某个渠道账户的分润会覆盖掉以前的
     *
     */
    public function profitByAccount()
    {

        $urate = $this->request->param('urate');
        $where = [
            'id' => $this->request->param('id')
        ];
        $account = $this->logicPay->getAccountInfo($where);
        //所有商户
        $users = $this->logicUser->getUserList([], '*', $order = 'uid desc', $paginate = false);
        foreach ($users as $user) {
            $profit = $this->logicUser->getUserProfitInfo(['uid' => $user['uid'], 'cnl_id' => $where['id']]);
            if ($profit) {
                $data_update[] = [
                    'id' => $profit['id'],
                    'uid' => $user['uid'],
                    'cnl_id' => $where['id'],
                    'urate' => 1-$urate/100,
                    'grate' => $account['grate']
                ];
            } else {
                $data_update[] = [
                    'uid' => $user['uid'],
                    'cnl_id' => $where['id'],
                    'urate' => 1-$urate/100,
                    'grate' => $account['grate']
                ];
            }
        }

        $this->result($this->logicUser->saveUserProfit($data_update));
    }


    /*
     *为每个pay_code赋值渠道权重
     * @return mixed
     */
    public function editCodeChannelWeight()
    {

        if ($this->request->isPost()) {
            $weight = $this->request->param('cnl_weight/a');
            $weight = json_encode($weight);
            $ret = $this->modelPayCode->where(['id' => $this->request->param('id')])->setField('cnl_weight', $weight);
            if ($ret !== false) {
                $this->result(['code' => CodeEnum::SUCCESS, 'msg' => '执行成功']);
            }
            $this->result(['code' => CodeEnum::ERROR, 'msg' => '执行失败']);

        }
        //当前pay_code 渠道权重信息
        $codeInfo = $this->logicPay->getCodeInfo(['id' => $this->request->param('id')]);
        //channel
        $channels = $this->logicPay->getChannelList(['id' => ['in', $codeInfo['cnl_id'], 'status' => ['eq', '1']]], 'id,name', ['id' => 'asc'], false);
        if ($channels) {
            $codeWeight = json_decode($codeInfo['cnl_weight'], true);
            foreach ($channels as $k => $channel) {
                $channels[$k]['weight'] = (empty($codeWeight) || !isset($codeWeight[$channel['id']])) ? 0 : $codeWeight[$channel['id']];
            }
        }
        $this->assign('list', $channels);;
        return $this->fetch('code_weight');
    }


    public function editCodeChannelPriceWeight()
    {

        if ($this->request->isPost()) {
            $cnlPriceWeights = $this->request->param('cnl_price_weight/a');
            $payCodeId = $this->request->param('id');
            //删除当前支付产品下面的渠道对应的所有金额的权重值 重新赋值
            Db::startTrans();
            try {
                Db::name('pay_channel_price_weight')->where(['pay_code_id' => $payCodeId])->delete();
                //重新添加
                $insert = [];
                foreach ($cnlPriceWeights as $k => $cnlPriceWeight) {
                    $channelPrice = explode('_', $k);
                    $row['pay_code_id'] = $payCodeId;
                    $row['cnl_id'] = $channelPrice[0];
                    $row['price'] = $channelPrice[1];
                    $row['cnl_weight'] = $cnlPriceWeight;
                    $row['create_time'] = time();
                    $row['update_time'] = time();
                    $insert[] = $row;
                }
                Db::name('pay_channel_price_weight')->insertAll($insert);
                Db::commit();
                exit(json_encode(['code' => CodeEnum::SUCCESS, 'msg' => '执行成功']));
            } catch (\Exception $exception) {
                Db::rollback();
                exit(['code' => CodeEnum::ERROR, 'msg' => $exception->getMessage()]);
            }
            exit(['code' => CodeEnum::ERROR, 'msg' => '执行失败']);
        }
        //当前pay_code 渠道权重信息
        $codeInfo = $this->logicPay->getCodeInfo(['id' => $this->request->param('id')]);
        //channel
        $channels = $this->logicPay->getChannelList(['id' => ['in', $codeInfo['cnl_id'], 'status' => ['eq', '1']]], 'id,name', ['id' => 'asc'], false);
        //当前通道支付产品的面额权重信息
        $channelPriceWeights = [];
        if ($channels) {
            foreach ($channels as $k => $channel) {
                $channelPriceWeightsItem['cnl_id'] = $channel['id'];
                $channelPriceWeightsItem['cnl_name'] = $channel['name'];
                $map['cnl_id'] = $channel['id'];
                $map['pay_code_id'] = $this->request->param('id');
                $channelPriceWeightsItem['price_30'] = Db::name('pay_channel_price_weight')->where(array_merge($map, ['price' => 30]))->value('cnl_weight', 0);
                $channelPriceWeightsItem['price_50'] = Db::name('pay_channel_price_weight')->where(array_merge($map, ['price' => 50]))->value('cnl_weight', 0);
                $channelPriceWeightsItem['price_100'] = Db::name('pay_channel_price_weight')->where(array_merge($map, ['price' => 100]))->value('cnl_weight', 0);
                $channelPriceWeightsItem['price_200'] = Db::name('pay_channel_price_weight')->where(array_merge($map, ['price' => 200]))->value('cnl_weight', 0);
                $channelPriceWeightsItem['price_9999'] = Db::name('pay_channel_price_weight')->where(array_merge($map, ['price' => 9999]))->value('cnl_weight', 0);
                $channelPriceWeights[$k] = $channelPriceWeightsItem;
            }
        }
        $this->assign('list', $channelPriceWeights);;
        return $this->fetch('code_price_weight');
    }

    /**
     *解绑此商户的TG群
     */
    public function unblindTgGroup()
    {
        $userId = $this->request->param('id');
        if (!$userId) {
            $this->error('非法操作');
        }
        $result = \app\common\model\PayChannel::where(['id' => $userId])->update(['tg_group_id' => '']);
        if ($result !== false) {
            $this->success('操作成功');
        }
        $this->error('错误请重试');

    }
    
    /*
        搜索支付配置文件
    */
    public function searchConfig(){
	    $pay_address = $this->request->param('pay_address');
	  //  $pay_address = 'http://www.baidu.com/gateway/dopay';
	    $p =  parse_url($pay_address);;
	    $query ="";
	    if(!empty($p['query']))
	    {
	      $query = "?".$p['query'];
	    }
	    $pay_address = $p['path'].$query;;
	    $data = [];
        $zfConfigArr = require_once('./data/conf/zfconfig.php');
	    if(is_array($zfConfigArr['template'])){

            foreach ($zfConfigArr['template'] as $k=>$v){
		    //$find = stripos($pay_address, $v);
	//	    var_dump($v['request_url'],$pay_address);
                    if($pay_address == '/'.$v['request_url']){
                        $data[] = $v;
                    }
            }
	}
	$html = '<select lay-filter="template" style="display:block" name="template" id="template" lay-verify="required">';
	if(!empty($data))
	{
            foreach($data as $d)
	    {

	     $html.= '<option value="'.$d['pay_controller'].'" >'.$d['name'].',参数:'.$d['param'].'</option>';
	    
	    }
	
	}
	 $html.= '</select>';//<div class="layui-form-mid layui-word-aux">注：请选择模板</div>';
//	$html ='<input type=""';
	
	
	echo $html;
    }
}
