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

use app\admin\enum\WebsiteEnum;
use app\common\library\enum\CodeEnum;
use app\common\model\UserPayCodeAppoint;

class Website extends BaseAdmin
{

    /**
     * 网站
     */
    public function index()
    {

        return $this->fetch();
    }

    /**
     * 网站列表
     */
    public function getList()
    {
        $where = [];

        //组合搜索
        !empty($this->request->param('type')) && $where['type']
            = ['eq', $this->request->param('type')];
        //获取角色权限的网站
        $admin = session('admin_info');
        $adminId = $admin->id ?? 0;
        if ($adminId != 1) {
            $group = $this->logicAuthGroupAccess->getAuthGroupAccessInfoByUid($adminId);
            $groupId = $group['group_id'] ?? 0;
            $where['group_id'] = $groupId;
        }
        $data = $this->logicWebsite->getWebsiteList($where, true, 'create_time desc', false);
        foreach ($data as $website) {
            $website->typeTitle = WebsiteEnum::types($website->type) ?? '';
            $group = $this->logicAuthGroup->getGroupInfo(['id' => $website->group_id]);
            $website->groupName = $group->name ?? '';

        }
        $count = $this->logicWebsite->getWebsiteCount($where);

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
            ]
        );
    }


    /**
     * 添加网站
     *
     */
    public function add()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicUser->addUser($this->request->post()));


        //所有代理商
        $where['is_agent'] = $where['status'] = 1;
        $agents = $this->logicUser->getUserList($where, 'uid,puid,username', 'create_time desc', false);
        $this->assign('agents', $agents);
        return $this->fetch();
    }

    /**
     * 编辑网站基本信息
     *
     */
    public function edit()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicUser->editUser($this->request->post()));
        //获取商户详细信息
        $this->assign('user', $this->logicUser->getUserInfo(['uid' => $this->request->param('id')]));
        //所有代理商
        $where['is_agent'] = $where['status'] = 1;
        $agents = $this->logicUser->getUserList($where, 'uid,puid,username', 'create_time desc', false);
        $this->assign('agents', $agents);
        return $this->fetch();
    }


    /**
     * 删除网站
     *
     *
     */
    public function del()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicUser->delUser(
                [
                    'uid' => $this->request->param('uid')
                ])
        );
        // get 直接报错
        $this->error([CodeEnum::ERROR, '未知错误']);
    }



    /*
    *用户支付渠道pay_code
    *
    */
    public function codes()
    {
        $uid = $this->request->param('id');
        if ($this->request->isPost()) {
            $data = $this->request->post('r/a');
            $this->result($this->logicUser->doUserPayCodes($uid, $data));
        }
        $data = $this->logicPay->getCodeList([], true, 'create_time desc', false);
        foreach ($data as $k => $v) {
            $userCode = $this->logicUser->userPayCode(['uid' => $uid, 'co_id' => $v['id']]);
            $data[$k]['status'] = $userCode ? $userCode['status'] : -1;
        }
        $this->assign('list', $data);;
        return $this->fetch();
    }


    /**
     * 商户指定渠道列表
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function appoint_get_list()
    {
        $where = [];
        //组合搜索
        !empty($this->request->param('uid')) && $where['a.uid']
            = ['eq', $this->request->param('uid')];
        $model = new UserPayCodeAppoint();
        $data = $model->order('a.createtime desc')
            ->field('a.*,u.username,pc.name,pc.code,ch.name as ch_name,ch.action as ch_action')
            ->alias('a')
            ->join('cm_user u', 'u.uid = a.uid')
            ->join('cm_pay_code pc', 'pc.id = a.pay_code_id')
            ->join('cm_pay_channel ch', 'ch.id = a.cnl_id')
            ->where($where)
            ->select();
        $count = $model
            ->field('a.*,u.username,pc.name,pc.code,ch.name as ch_name,ch.action as ch_action')
            ->alias('a')
            ->join('cm_user u', 'u.uid = a.uid')
            ->join('cm_pay_code pc', 'pc.id = a.pay_code_id')
            ->join('cm_pay_channel ch', 'ch.id = a.cnl_id')
            ->where($where)
            ->count();
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
            ]
        );
    }


    public function appoint_add()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicUser->addAppoint($this->request->post()));


        //所有商户
        $users = $this->logicUser->getUserList([], 'uid,puid,username', 'create_time desc', false);
        $this->assign('users', $users);

        //所有支付产品
        $pay_code = $this->logicPay->getCodeList([], 'id,name,code', 'create_time desc', false);
        $this->assign('pay_code', $pay_code);

        return $this->fetch();
    }

    /**
     * 获取渠道列表
     */
    public function get_channel_list()
    {

        $id = $this->request->param('id');

        $codeInfo = $this->logicPay->getCodeInfo(['id' => $id]);
        $ids = [];
        if ($codeInfo) {
            $ids = $codeInfo['cnl_id'];
        }

        $list = $this->logicPay->getChannelList(['id' => ['in', $ids]], 'id,name,action', 'create_time desc', false);
        $this->result([
            'code' => CodeEnum::SUCCESS,
            'msg' => '',
            'count' => count($list),
            'data' => $list
        ]);
    }

    /**
     * 编辑商户基本信息
     *
     * @return mixed
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function appoint_edit()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result($this->logicUser->editAppoint($this->request->post()));


        $appoint = $this->modelUserPayCodeAppoint->where(['appoint_id' => $this->request->param('appoint_id')])->find();

        $this->assign('appoint', $appoint);
        //所有商户
        $users = $this->logicUser->getUserList([], 'uid,puid,username', 'create_time desc', false);
        $this->assign('users', $users);

        //所有支付产品
        $pay_code = $this->logicPay->getCodeList([], 'id,name,code', 'create_time desc', false);
        $this->assign('pay_code', $pay_code);

        return $this->fetch();
    }


    /**
     * 删除
     *
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function appoint_del()
    {
        // post 是提交数据
        $this->request->isPost() && $this->result(
            $this->logicUser->delAppoint(
                [
                    'appoint_id' => $this->request->param('appoint_id')
                ])
        );
        // get 直接报错
        $this->error([CodeEnum::ERROR, '未知错误']);
    }

}
