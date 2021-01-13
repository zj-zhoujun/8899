<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\index\controller;

use app\common\controller\IndexBase;
use think\Controller;
use think\Db;
use My\DataReturn;


class Active extends IndexBase
{

    /**
     * 签到
     * @return \think\response\View
     */
    public function index()
    {
        return $this->fetch();
    }
    public function sign()
    {
        //查询今天是否已签到
        $map = [];
        $user = $this->user;
        $map['user_id'] = $user['id'];
        $map['day'] = date('Ymd');
        $is_sign = Db::name('sign_log')->where($map)->find();
        if($is_sign){
            $this->error('您今日已签到，请明天再来！');
        }
        //签到处理
        $config = unserialize(Db::name('system')->where('name','base_config')->value('value'));
        $data = [];
        $data['user_id'] = $user['id'];
        $data['username'] = $user['username'];
        $data['day'] = date('Ymd');
        $data['bonus'] = $config['sign_reward'];
        $data['w_time'] = time();
        $sign_id = Db::name('sign_log')->insertGetId($data);
        moneyLog($user['id'],$sign_id,'pay_points',$config['sign_reward'],3,'签到奖励');
        $this->success('签到成功');
    }


    public function get_gift(){
        //拼装奖项数组
        // 奖项id，奖品，概率
        $prize_arr = Db::name('dazhuanpan')->field('id,level,name,bonus_type,bonus_num,pv')->select();
        foreach ($prize_arr as $key => $val) {
            $arr[$val['id']] = $val['pv'];//概率数组
        }
        $rid = $this->get_rand($arr); //根据概率获取奖项id
        $bonus_info = $prize_arr[$rid-1];
        $bonus_type = $bonus_info['bonus_type']; //中奖项
        unset($prize_arr[$rid-1]); //将中奖项从数组中剔除，剩下未中奖项
        shuffle($prize_arr); //打乱数组顺序
        for($i=0;$i<count($prize_arr);$i++){
            $pr[] = $prize_arr[$i]['prize'];  //未中奖项数组
        }
        $res['no'] = $pr;
        // var_dump($res);


        if($bonus_type!='empty'){
            Db::startTrans();
            //插入大转盘记录
            $data = [];
            $data['user_id'] = $this->user_id;
            $data['bonus_type'] = $bonus_info['bonus_type'];
            $data['bonus_num'] = $bonus_info['bonus_num'];
            $data['name'] = $bonus_info['name'];
            $data['bonus_id'] = $bonus_info['id'];
            $data['w_time'] = time();
            $log_id = Db::name('dazhuanpan_log')->insertGetId($data);
            //赠送限时收益狗狗
            $bonus_res = ['status'=>true,'msg'=>''];
            if($bonus_type=='dog'){
                $bonus_res = $this->reward_dog();
            }
            //赠送道具
            if(in_array($bonus_type,['yao'])){
                $bonus_res = daojuLog($this->user_id,$log_id,$bonus_type,$bonus_info['bonus_num'],3,'大转盘抽奖');
            }
            if($bonus_res['status']!=true){
                dump($res);exit;
                $this->error('发放奖励失败');
            }
            Db::commit();
            //赠送钱包数据
            if(in_array($bonus_type,['doge','pay_points'])){
                moneyLog($this->user_id,$log_id,$bonus_type,$bonus_info['bonus_num'],3,'大转盘抽奖');
            }

            $result['status'] = 1;
            $result['name'] = $bonus_info['name'];
        }else{
            $result['status'] = -1;
            $result['msg'] = $bonus_info['name'];
        }
        //return $result;
        var_dump($result);
    }

    //计算中奖概率
    public function get_rand($proArr) {
        $result = '';
        //概率数组的总概率精度
        $proSum = array_sum($proArr);
        // var_dump($proSum);
        //概率数组循环
        foreach ($proArr as $key => $proCur) {
            $randNum = mt_rand(1, $proSum);  //返回随机整数

            if ($randNum <= $proCur) {
                $result = $key;
                break;
            } else {
                $proSum -= $proCur;
            }
        }
        unset ($proArr);
        return $result;
    }

    public function reward_dog(){
        //赠送宠物
        $pigInfo = Db::name('task_config')->where(['is_reward'=>1])->find();
        $price = 0;
        $saveDate = [];
        $saveDate['uid'] = $this->user_id;
        $saveDate['pig_id'] = $pigInfo['id'];
        $saveDate['pig_name'] = $pigInfo['name'];
        $saveDate['price'] = $price;
        $saveDate['contract_revenue'] = $pigInfo['contract_revenue'];
        $saveDate['cycle'] = $pigInfo['cycle'];
        $saveDate['doge'] = $pigInfo['doge'];
        $saveDate['pig_no'] = create_trade_no();
        $saveDate['status'] = 1;
        $saveDate['create_time'] = time();
        $saveDate['end_time'] = time()+$pigInfo['cycle']*24*3600;
        $sell_id = Db::name('user_pigs')->insertGetId($saveDate);
        //生成订单
        $sellOrder = [];
        $sellOrder['order_no'] = create_trade_no();
        $sellOrder['uid'] = $this->user_id;
        $sellOrder['pig_id'] = $pigInfo['id'];
        $sellOrder['source_price'] = $price;
        $sellOrder['price'] = $price;
        $sellOrder['pig_name'] = $pigInfo['name'];
        $sellOrder['create_time'] = time();
        $sellOrder['sell_id'] = 0;
        $order_id = Db::name('PigOrder')->insertGetId($sellOrder);

        return ['status'=>true,'msg'=>''];
    }






}
