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


namespace app\common\model;


class PayAccount extends BaseModel
{

    public function payCode()
    {
        return $this->belongsTo(PayCode::class, 'co_id', 'id')->bind(['channel_code' => 'code'])->setEagerlyType(0);
    }
}