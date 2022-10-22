<?php

namespace app\admin\enum;

class WebsiteEnum
{
    const ERROR_STR = '未知';
    /**
     * 网站类型
     */
    const TYPE_1 = 1; // 三方
    const TYPE_2 = 2; // 四方
    const TYPE_3 = 3; // 代付

    /**
     * @param null $key
     * @return array|mixed|string
     */
    public static function types($key = null)
    {
        $list = [
            self::TYPE_1 => '三方',
            self::TYPE_2 => '四方',
            self::TYPE_3 => '代付',
        ];
        return is_null($key) ? $list : ($list[$key] ?? self::ERROR_STR);
    }


}
