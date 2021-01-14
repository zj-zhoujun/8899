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

    //道具列表
    public function daoju_list(){
        $list = Db::name('dog_daoju')->select();
        //dump($list);exit;
        $this->assign('list',$list);
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
        $pwd = input('paypwd');
        if(!$type){
            $this->error('请选择道具');
        }
        $num = $num?:1;
        $info = Db::name('dog_daoju')->where('type',$type)->find();

        //密码验证
        if (!$user['pay_password']) $this->success('请先设置二级密码',url('user/set_paypwd'));
        if (md5($pwd.config('salt')) != $user['pay_password']) $this->error('二级密码不正确');
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
        $pid = input('pid');
        $user = $this->user;
        $info = Db::name('daoju_user')->where('user_id',$user['id'])->find();
        if($info[$type]<=0){
            $this->error('道具不足，请先购买！');
        }
        $pig_info = Db::name('user_pigs')->where(['uid'=>$user['id'],'id'=>$pid])->find();
        if(!$pig_info){
            $this->error('数据不存在');
        }
        if($pig_info['health']==0){
            $this->error('狗狗状态良好，不需要使用道具');
        }
        $daoju_info = Db::name('dog_daoju')->where('type',$type)->find();
        if(!$daoju_info){
            $this->error('道具错误');
        }
        Db::startTrans();
        //扣除道具
        $res = daojuLog($user['id'],$info['id'],$type,-1,3,'使用道具');
        if(!$res['status']){
            Db::rollback();
            $this->error('操作失败');
        }
        //更改宠物狗状态
        Db::name('user_pigs')->where(['uid'=>$user['id'],'id'=>$pid])->setField('health',0);
        Db::commit();
        $this->success('操作成功！');
    }






}
