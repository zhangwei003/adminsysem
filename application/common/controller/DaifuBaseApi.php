<?php
/**
 * Created by PhpStorm.
 * User: zhangxiaohei
 * Date: 2020/2/10
 * Time: 20:42
 */

namespace app\common\controller;


use app\api\service\ApiRequest;
use app\common\logic\DaifuOrders;
use think\Controller;
use think\Validate;

class DaifuBaseApi extends Controller
{
    protected $verification = [];

    protected $rule = [];

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $action = $this->request->action();
        $this->validateParams($action);
        $this->rule();
        //验证方法

        if (in_array($action, $this->verification)) {
            //sign验证
            $params = $this->request->post();
            $DaifuOrders = new DaifuOrders();
            $agent = $DaifuOrders->checkAgent($params['mchid']);
            if (!$agent) {
                $this->error('商户不存在');
            }
            $signs = $params['sign'];
            unset($params['sign']);
            $sign = $DaifuOrders->getSign($params, $agent->key);

            if ($signs != $sign) {
                $this->error('sign错误');
            }
            //验证ip白名单
            $auth_ips = explode(',', $agent->auth_ips);
            $auth_ips = $auth_ips ? $auth_ips : [];
//            if (!in_array(get_userip(), $auth_ips)) {
//                $this->error('非法操作');
//            }


        }
    }

    protected function addRule($field, $rule)
    {
        $this->rule[$field] = $rule;
    }

    private function rule()
    {
        $validate = new Validate($this->rule);
        if (!$validate->check($this->request->post())) {
            $this->error($validate->getError());
        }
    }

    protected function validateParams($action)
    {
    }

}