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


class OrdersStat extends BaseModel
{
    public function getAmount($websiteId = 0, $date = null)
    {
        $where = [];

        if ($websiteId) {
            $where['website_id'] = $websiteId;
        }
        if ($date) {
            $where['date'] = $date;
        }

        return self::where($where)->value('amount');
    }
}