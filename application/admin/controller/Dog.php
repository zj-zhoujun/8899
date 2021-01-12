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
    /**
     * 团队级别
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function category()
    {
        $list = Db::name('dog_level')->select();
        $this->assign('list',$list);
        return view();
    }

    /**
     * 添加团队级别
     * @return \think\response\View
     */
    public function categoryadd()
    {
        if ($this->request->isPost()) {
            $data = $this->request->post();
            $res = model('MarketLevel')->save($data);
            $res ? $this->success('操作成功') : $this->error('操作失败');
        }
        return view();
    }

    /**
     * 市场角色修改
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function categoryedit()
    {
        $id = $this->request->param('id');
        //dump($id);
        if ($this->request->isPost()) {
            $data = $this->request->post();
            //dump($data);
            $res = model('MarketLevel')->save($data,['id'=>$data['id']]);
            //dump($res);
            $res ? $this->success('操作成功') : $this->error('修改失败');
        }
        $this->assign('confInfo',model('MarketLevel')->find($id));
        return view();
    }

    public function categoryDel()
    {
        $id = $this->request->param('id');
        $res = Db::name('market_level')->where('id',$id)->delete();
        $res ? $this->success('操作成功') : $this->error('操作失败');
    }



}