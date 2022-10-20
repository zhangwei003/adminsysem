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
return [
    'template'  =>  [
        [
            'name'  =>  '模板1',
            'request_url'   =>  'gateway/dopay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' => 'app_id out_trade_no notify_url pay_ip',
            'pay_controller'    =>  'XingguangPay'
        ],
        [
            'name'  =>  '模板2',
            'request_url'   =>  'api/pay/startOrder',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'mchId mchOrderNo productId notifyUrl',
            'pay_controller'    =>  'MaimaitongPay'
        ],
        [
            'name'  =>  '模板3',
            'request_url'   =>  'Handler/sdk.ashx?type=create_neworder',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'app_id order_id paytype notify_url price',
            'pay_controller'    =>  'HuanQiuPay'
        ],
        [
            'name'  =>  '模板4',
            'request_url'   =>  'api/pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'merId orderId channel orderAmt notifyUrl',
            'pay_controller'    =>  'WanshiPay'
        ],
        [
            'name'  =>  '模板5',
            'request_url'   =>  'api/v1/getway',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'banktype callbackurl partner banktype Binary file',
            'pay_controller'    =>  'HengPay'
        ],
        [
            'name'  =>  '模板6',
            'request_url'   =>  'api/gateway/create',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'mch_id out_trade_no pay_type notify_url',
            'pay_controller'    =>  'TingfengPay'
        ],
        [
            'name'  =>  '模板7',
            'request_url'   =>  'api/unifiedorder',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'pass_code out_trade_no notify_url mch_id',
            'pay_controller'    =>  'GuangyuanPay'
        ],
        [
            'name'  =>  '模板8',
            'request_url'   =>  'pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'partnerid payType out_trade_no returnUrl',
            'pay_controller'    =>  'JuhemubanPay'
        ],
        [
            'name'  =>  '模板8',
            'request_url'   =>  'Pay_Index.html',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'pay_amount pay_memberid pay_notifyurlpay_bankcode',
            'pay_controller'    =>  'YuenanPay'
        ],
        [
            'name'  =>  '模板8-1',
            'request_url'   =>  'Pay_Index.html',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  '区别8 接口返回的 data 值为请求链接，状态码也不一样',
            'pay_controller'    =>  'YuenanPay'
        ],
        [
            'name'  =>  '模板9',
            'request_url'   =>  'trade/pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'partnerid notifyurl orderid paytype payamount',
            'pay_controller'    =>  'KaidaPay'
        ],
        [
            'name'  =>  '模板11',
            'request_url'   =>  'api/mch/send-pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'trade_no pay_code notify_url money',
            'pay_controller'    =>  'TaokePay'
        ],
        [
            'name'  =>  '模板12',
            'request_url'   =>  'submit.php',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'pid,type,out_trade_no,notify_url',
            'pay_controller'    =>  'HiPay'
        ],
        [
            'name'  =>  '模板13',
            'request_url'   =>  'v1/htpay/ht-create-order',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'merchant_no，attach，order_amount',
            'pay_controller'    =>  'HuanZhongPay.php'
        ],[
            'name'  =>  '模板14',
            'request_url'   =>  'index/api/order',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'type,money,user_order_no,notify_url,user_id,timestamp',
            'pay_controller'    =>  'FanqiesuningPay'
        ],
        [
            'name'  =>  '模板15',
            'request_url'   =>  'api/pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'merchant_no,out_order_no,amount,pay_type,notify_url',
            'pay_controller'    =>  'ChengfengPay'
        ],
        [
            'name'  =>  '模板16',
            'request_url'   =>  'Pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'pay_memberid,pay_orderid,pay_bankcode,pay_amount',
            'pay_controller'    =>  'FeifanPay'
        ],
        [
            'name'  =>  '模板17',
            'request_url'   =>  '?c=pay',
            'query_url' =>  '',
            'url'   =>  '',
            'param' =>  'mch_id,ptype,order_sn,goods_desc,pay_backurl,from_name',
            'pay_controller'    =>  'TuxingPay'
        ],
        [
            'name' => '模板18',
            'request_url' => '',
            'query_url' => '',
            'url' => '',
            'param' => 'mno,orderno,amount,code,async_notify_url,sign 密钥和aes 密钥通过 |(英文) 隔开',
            'pay_controller'  => 'LianhePay'
	],
        [
            'name' => '模板19',
            'request_url' => 'v1/order/create',
            'query_url' => '',
            'url' => '',
            'param' => 'merchant_no，pay_code，order_no，order_amount，callback_url',
            'pay_controller'  => 'MugebanPay'
        ],
    [
        'name' => '模板20',
        'request_url' => '',
        'query_url' => '',
        'url' => '',
        'param' => 'order_time，amount，payment_type_code，merchant_order_no，product_name,merchant_no,notify_url,sign',
        'pay_controller'  => 'MugebanPay'
    ]


    ],
    
    
    //中转地址设置
      'transfer_add'=>[
        [
            'name'=>'baidu',
            'url'=>'www.baidu.com'
        ],
        [
            'name'=>'aliyun',
            'url'=>'www.aliyun.com'
        ]

    ]
];
