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
 * 大转盘
 * Class System
 * @package app\admin\controller
 */
class Dazhuanpan extends AdminBase
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
    public function index()
    {
        $list = Db::name('dazhuanpan')->select();
        $this->assign('list',$list);

        $bonus_types = config('extra_types.dazhuanpan_bonus');
        $this->assign('bonus_types',$bonus_types);
        return view();
    }

    /**
     * 市场角色修改
     * @return \think\response\View
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function setedit()
    {
        $id = $this->request->param('id');
        //dump($id);
        if ($this->request->isPost()) {
            $params = $this->request->post();
            $data = [];
            $data['bonus_type'] = $params['bonus_type'];
            $data['bonus_num'] = $params['bonus_num'];
            $res = Db::name('dazhuanpan')->where(['id'=>$id])->update($data);
            //dump($res);
            $res ? $this->success('操作成功') : $this->error('修改失败');
        }
        $info = Db::name('dazhuanpan')->where(['id'=>$id])->find();
        $this->assign('confInfo',$info);

        $bonus_types = config('extra_types.dazhuanpan_bonus');
        $this->assign('bonus_types',$bonus_types);
        return view();
    }

    public function categoryDel()
    {
        $id = $this->request->param('id');
        $res = Db::name('market_level')->where('id',$id)->delete();
        $res ? $this->success('操作成功') : $this->error('操作失败');
    }



}