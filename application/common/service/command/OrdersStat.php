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
        $this->setName('OrderStat')->setDescription("订单统计定时入库 at 01:00:00");
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
        $date = date('Y-m-d');
        $yesterdayStart = date("Y-m-d 00:00:00", strtotime("-1 day"));
        $yesterdayEnd = date("Y-m-d 23:59:59", strtotime("-1 day"));
        try {
            $resArr = Db::table('cm_orders')
                ->whereTime('create_time', [$yesterdayStart, $yesterdayEnd])
                ->select();
            Log::notice('查询订单列表');

            $websiteId = ''; //todo 网站id
            $amount = 0; // todo 跑量
            $data['website_id'] = $websiteId;
            $data['date'] = $date;
            $data['amount'] = $amount;

            $res = $this->modelOrdersStat->setInfo($data);
            if ($res) {
                Log::notice('入库跑量成功');
            }
        } catch (\Exception $e) {
            Log::error("handle OrdersStat Fail:[" . $e->getMessage() . "]");
        }
    }
}
