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

namespace app\admin\validate;

class PayChannel extends BaseAdmin
{
    // 验证规则
    protected $rule = [
//        'name'  => 'require|length:3,10',
        'pay_secret' => 'require',
        'pay_merchant' => 'require',
        'pay_address' => 'require',
        'remarks'    => 'require'
    ];

    // 验证提示
    protected $message = [
//        'name.require'    => '渠道名不能为空',
//        'name.length'     => '渠道名长度为6-30个字符之间',
        'pay_secret.require' => '支付密钥不能为空',
        'pay_merchant.require' => '支付商户号不能为空',
        'pay_address.require' => '下单支付地址不能为空',
        'remarks.require'     => '渠道备注不能为空'
    ];
}