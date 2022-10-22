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


class Website extends BaseModel
{
    public function getWebsitesByGroupId($groupId)
    {
        return $this->where('group_id', $groupId)->select();
    }

    public function getWebsiteList($where = [], $field = true, $order = '', $paginate = 0)
    {
        if (empty($this->join)) {

            $query = $this;

        } else {

            $query = $this->join($this->join);
        }

        $query = $query->where($where)->order($order)->field($field);

        if (false === $paginate) {
            !empty($this->limit) && $query->limit((input('page') - 1) * input('limit'),input('limit'));

            $list = $query->select();


        } else {
            $list_rows = empty($paginate) || !$paginate ? 15 : $paginate;

            $list = $query->paginate(input('list_rows', $list_rows), false, ['query' => request()->param()]);
        }
        $this->join = []; $this->limit = []; $this->group = [];

        return $list;
    }



}