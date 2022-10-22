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

namespace app\common\logic;

use app\common\library\enum\CodeEnum;
use think\Db;
use think\Exception;
use think\Log;

class Website extends BaseLogic
{

    /**
     * 获取网站列表
     * @param array $where
     * @param string $field
     * @param string $order
     * @param int $paginate
     * @return mixed
     */
    public function getWebsiteList($where = [], $field = '*', $order = '', $paginate = 20)
    {
        $this->modelWebsite->limit = !$paginate;
        return $this->modelWebsite->getWebsiteList($where, $field, $order, $paginate);
    }

    /**
     * 获取网站总数
     * @param array $where
     * @return mixed
     */
    public function getWebsiteCount($where = [])
    {
        return $this->modelWebsite->getCount($where);
    }
}
