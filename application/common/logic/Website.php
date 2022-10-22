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

    /**
     * @param $data
     * @return array
     */
    public function editWebsite($data)
    {

        Db::startTrans();
        try {
            $this->modelWebsite->setInfo($data);

            action_log('修改', '修改网站信息。ID:' . $data['id']);

            Db::commit();
            return ['code' => CodeEnum::SUCCESS, 'msg' => '编辑成功'];
        } catch (\Exception $ex) {
            Db::rollback();
            Log::error($ex->getMessage());
            return ['code' => CodeEnum::ERROR, config('app_debug') ? $ex->getMessage() : '未知错误'];
        }
    }

    public function getWebsiteInfo($where = [], $field = true)
    {
        return $this->modelWebsite->getInfo($where, $field);
    }
}
