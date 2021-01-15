<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\admin\controller;

use app\common\controller\AdminBase;
use think\Cache;
use think\Db;

/**
 * 系统配置
 * Class System
 * @package app\admin\controller
 */
class Dog extends AdminBase
{
    public function _initialize()
    {
        parent::_initialize();
    }

    public function daoju()
    {
        $list = Db::name('dog_daoju')->where('is_del',0)->select();
        $this->assign('list',$list);
        return view();
    }

    public function daojuedit()
    {
        $id = $this->request->param('id');
        //dump($id);
        if ($this->request->isPost()) {
            $args = $this->request->post();
            //dump($data);
            $data = [];
            $data['price'] = $args['price'];
            $res = Db::name('dog_daoju')->where(['id'=>$id])->update($data);
            //dump($res);
            $res ? $this->success('操作成功') : $this->error('修改失败');
        }
        $info = Db::name('dog_daoju')->where(['id'=>$id])->find();
        $this->assign('confInfo',$info);
        return view();
    }

    public function daojuDel()
    {
        $id = $this->request->param('id');
        $res = Db::name('market_level')->where('id',$id)->delete();
        $res ? $this->success('操作成功') : $this->error('操作失败');
    }



}