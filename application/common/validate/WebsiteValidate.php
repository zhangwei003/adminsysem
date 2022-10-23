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

namespace app\common\validate;

class WebsiteValidate extends BaseValidate
{
    // 验证规则
    protected $rule = [
        'name'  => 'require|length:3,30',
        'ip'  => 'require|length:3,32',
        'host'  => 'require|length:3,100',
    ];

    // 验证提示
    protected $message = [
        'name.require'    => '网站名不能为空',
        'name.length'     => '网站名长度为3-30个字符之间',
        'name.unique'     => '网站名已存在',
        'ip.require'    => 'ip不能为空',
        'ip.length'     => 'ip长度为3-32个字符之间',
        'host.require'    => '域名不能为空',
        'host.length'     => '域名长度为3-100个字符之间',
    ];

    // 应用场景
    protected $scene = [
        'add'  =>  ['name','ip','host'],
        'edit'      =>  ['name','ip','host']
    ];
}