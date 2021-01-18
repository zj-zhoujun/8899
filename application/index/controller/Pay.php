<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\index\controller;
use think\Controller;
use think\Db;
use My\DataReturn;
use codepay;

class Pay extends controller
{
    public function index(){
        $params = [
            'pay_id' => build_order_no(),
            'total_amount' => 0.01,
            'ext' => [],
        ];
        $data = $params;
        $data['uid'] = session('user_id');
        $data['w_time'] = time();
        Db::name('pay_order')->insertGetId($data);
        $pay = codepay\Codepay::pay($params);
        dump($pay);exit;
    }

    public function notify_pay(){
        file_put_contents('codepay.txt',date('Ymd H:i:s').'notify::'.json_encode($_REQUEST)."\r\n",FILE_APPEND);
        $config = config('codepay');
        $data = $_POST;
        //dump($data);exit;
        unset($data['s']);
        
        ksort($data); //排序post参数
        reset($data); //内部指针指向数组中的第一个元素
        $codepay_key = $config['key']; //这是您的密钥
        $sign = '';//初始化
        foreach ($data AS $key => $val) { //遍历POST参数
            if ($val == '' || $key == 'sign') continue; //跳过这些不签名
            if ($sign) $sign .= '&'; //第一个字符串签名不加& 其他加&连接起来参数
            $sign .= "$key=$val"; //拼接为url参数形式
        }
        if (!$data['pay_no'] || md5($sign . $codepay_key) != $data['sign']) { //不合法的数据
            exit('fail');  //返回失败 继续补单
        } else { //合法的数据
            //业务处理
            $pay_id = $data['pay_id']; //需要充值的ID 或订单号 或用户名
            $money = (float)$data['money']; //实际付款金额
            $price = (float)$data['price']; //订单的原价
            $param = $data['param']; //自定义参数
            $pay_no = $data['pay_no']; //流水号
            Db::startTrans();
            $info = Db::name('pay_order')->where('pay_id',$pay_id)->lock(true)->find();
            if(!$info){
                exit('fail');
            }
            if($info['status']==1){
                exit('success');
            }
            $data_u = [];
            $data_u['status'] = 1;
            $data_u['pay_time'] = time();
            $data_u['pay_no'] = $pay_no;
            Db::name('pay_order')->where('pay_id',$pay_id)->update($data_u);
            $log = [
                'user_id' => $info['uid'],
                'username' => model('User')->where('id', $info['uid'])->value('mobile'),
                'from_id' => 0,
                'currency' => $info['wallet'],
                'amount' => $money,
                'type' => 3,
                'note' => '在线充值',
                'create_time' => date('Y-m-d H:i:s')
            ];
            $log['from_username'] =  '在线充值';
            Db::name('money_log')->insert($log);
            Db::name('user')->where('id', $info['uid'])->setInc($info['wallet'], $money);
            Db::commit();
            exit('success'); //返回成功 不要删除哦
        }
    }

    public function return_pay(){
        file_put_contents('codepay.txt',date('Ymd H:i:s').'return::'.json_encode($_REQUEST)."\r\n",FILE_APPEND);
        $config = config('codepay');
        $data = $_POST;
        //dump($data);exit;
        unset($data['s']);
        ksort($data); //排序post参数
        reset($data); //内部指针指向数组中的第一个元素
        $codepay_key = $config['key']; //这是您的密钥
        $sign = '';//初始化
        foreach ($data AS $key => $val) { //遍历POST参数
            if ($val == '' || $key == 'sign') continue; //跳过这些不签名
            if ($sign) $sign .= '&'; //第一个字符串签名不加& 其他加&连接起来参数
            $sign .= "$key=$val"; //拼接为url参数形式
        }
        if (!$data['pay_no'] || md5($sign . $codepay_key) != $data['sign']) { //不合法的数据
            exit('fail');  //返回失败 继续补单
        } else { //合法的数据
            //业务处理
            $pay_id = $data['pay_id']; //需要充值的ID 或订单号 或用户名
            $money = (float)$data['money']; //实际付款金额
            $price = (float)$data['price']; //订单的原价
            $param = $data['param']; //自定义参数
            $pay_no = $data['pay_no']; //流水号
            Db::startTrans();
            $info = Db::name('pay_order')->where('pay_id',$pay_id)->lock(true)->find();
            if(!$info){
                exit('fail');
            }
            if($info['status']==1){
                exit('success');
            }
            $data_u = [];
            $data_u['status'] = 1;
            $data_u['pay_time'] = time();
            $data_u['pay_no'] = $pay_no;
            Db::name('pay_order')->where('pay_id',$pay_id)->update($data_u);
            $log = [
                'user_id' => $info['uid'],
                'username' => model('User')->where('id', $info['uid'])->value('mobile'),
                'from_id' => 0,
                'currency' => $info['wallet'],
                'amount' => $money,
                'type' => 3,
                'note' => '在线充值',
                'create_time' => date('Y-m-d H:i:s')
            ];
            $log['from_username'] =  '在线充值';
            Db::name('money_log')->insert($log);
            Db::name('user')->where('id', $info['uid'])->setInc($info['wallet'], $money);
            Db::commit();
            exit('success'); //返回成功 不要删除哦
        }
    }


}
