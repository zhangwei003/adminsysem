<?php
/**
 * @className: OrdersStat
 * @author: Calm
 * @date: 2022/10/21 16:15
 **/

namespace app\common\service\command;

use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\Db;
use think\Log;

class OrdersStat extends Command
{
    protected function configure()
    {
        $this->setName('OrdersStat')->setDescription("订单统计定时入库 at 01:00:00");
    }

    protected function execute(Input $input, Output $output)
    {
        $output->writeln('Date Crontab job start...');
        $this->handle();            // 调用方法
        $output->writeln('Date Crontab job end...');
    }

    private function handle()
    {
        // 逻辑
        $date = date("Y-m-d", strtotime("-1 day"));
        $yesterdayStart = strtotime(date("Y-m-d 00:00:00", strtotime("-1 day")));
        $yesterdayEnd = strtotime(date("Y-m-d 23:59:59", strtotime("-1 day")));
        try {
            $websiteList = Db::table('cm_website')->select();
            $websiteIds = array_column($websiteList, 'id');
            $data = [];
            //删除
            Db::table('cm_orders_stat')->whereIn('website_id', $websiteIds)->where('date', $date)->delete();

            foreach ($websiteList as $website) {
                $host = $website['host'] ?? '';
                $url = $host . 'api/orders/orderState?start=' . $yesterdayStart . '&end=' . $yesterdayEnd;
                $res = curl_get($url);
                $res = json_decode($res, true);
                $amount = $res['data']['amount'] ?? 0;
                $data[] = [
                    'website_id' => $website['id'] ?? 0,
                    'date' => $date,
                    'amount' => $amount,
                    'create_time' => time(),
                    'update_time' => time(),
                ];
            }
            db("orders_stat")->insertAll($data);
        } catch (\Exception $e) {
            Log::error("handle OrdersStat Fail:[" . $e->getMessage() . "]");
        }
    }
}
