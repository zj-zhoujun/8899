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


class Dog extends IndexBase
{

    /**
     * 签到
     * @return \think\response\View
     */
    public function index()
    {
        return $this->fetch();
    }

    /**
     * 购买道具
     */
    public function buy_daoju()
    {
        $user = $this->user;
        $type = input('type');
        $num = input('num');
        if(!$type){
            $this->error('请选择道具');
        }
        $num = $num?:1;
        $info = Db::name('dog_daoju')->where('type',$type)->find();
        //电力
        $price_total = bcmul($info['price'],$num);
        if ($user['pay_points']<$info['price']){
            $this->error('微分不足,请充值');
        }
        moneyLog($user['id'],$info['id'],'pay_points',-$price_total,3,'购买道具');
        Db::startTrans();
        $res = daojuLog($user['id'],$info['id'],$type,$num,3,'购买');
        Db::commit();
        $this->success('购买成功',url('index'));
    }

    public function use_daoju(){
        $type = input('type');
        $user = $this->user;
        $info = Db::name('dog_daoju_user')->where('user_id',$user['id'])->find();
        if(!$info[$type]<=0){
            $this->error('道具不足，请先购买！');
        }

        Db::startTrans();
        $res = daojuLog($user['id'],$info['id'],$type,-1,3,'使用道具');
        Db::commit();
    }






}
