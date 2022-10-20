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

namespace app\common\service\worker;


use app\common\library\Activation;
use app\common\library\Mail;
use app\common\logic\TgLogic;
use think\Log;
use think\queue\Job;


/**
 * @todo  本队列需要优化
 * 自动删除tg消息
 * Class AutoDeleteTgMsgWork
 * @package app\common\service\worker
 */
class AutoDeleteTgMsgWork

{
    /**
     * fire方法是消息队列默认调用的方法
     *
     * @param Job $job
     * @param array $data
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    public function fire(Job $job, $data)
    {
        Log::notice('Queue Data: [ ' . $data . '].');
        $data = json_decode($data, true);
        // 如有必要,可以根据业务需求和数据库中的最新数据,判断该任务是否仍有必要执行.
        $isJobStillNeedToBeDone = $this->checkDatabaseToSeeIfJobNeedToBeDone($data);
        if (!$isJobStillNeedToBeDone) {
            $job->delete();
            return;
        }


        $job->delete();
        $delaySeconed = 600;
        if ($data['create_time'] + $delaySeconed > time()) {
            //消息失效了执行job
            $isJobDone = $this->doJob($data);
            if ($isJobDone) {
                //如果任务执行成功， 记得删除任务
                $job->delete();
                print("<info>The AutoDeleteTgMessage Job has been done and deleted" . "</info>\n");
            } else {
                //通过这个方法可以检查这个任务已经重试了几次了
                if ($job->attempts() >= 3) {
                    print("<warn>The AutoDeleteTgMessage Job has been deleted and retried more than {$job->attempts()} times!" . "</warn>\n");
                    $job->delete();
                } else {
                    // 也可以重新发布这个任务
                    print("<info>The AutoDeleteTgMessage Job will be availabe again after 1 min." . "</info>\n");
                    $job->release(60); //$delay为延迟时间，表示该任务延迟1分钟后再执行

                }
            }
        } else {
            //还未到执行时间
            //$delay为延迟时间
            $job->release(time()-$data['create_time'] + $delaySeconed);
        }
    }

    /**
     * 有些消息在到达消费者时,可能已经不再需要执行了
     *
     * @param $data array
     * @return bool
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    private function checkDatabaseToSeeIfJobNeedToBeDone($data)
    {
        if ($data['create_time'] > time()) {
            return false;
        }
        return true;
    }

    /**
     * 根据消息中的数据进行实际的业务处理
     *
     * @param array $data
     * @return bool
     * @author 勇敢的小笨羊 <brianwaring98@gmail.com>
     *
     */
    private
    function doJob($data)
    {
        $tgLogic = new TgLogic();
        $ret = $tgLogic->deleteMessage($data['message_id'], $data['chat_id']);
        echo $ret;
        return true;
    }
}