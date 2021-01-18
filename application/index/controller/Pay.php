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
        $data['uid'] = Session::get('user_id');
        $data['w_time'] = time();
        Db::name('pay_order')->insertGetId($data);
        $pay = codepay\Codepay::pay($params);
        dump($pay);exit;
    }

    public function notify_pay(){
        file_put_contents('codepay.txt',date('Ymd H:i:s').json_encode($_REQUEST)."\r\n",FILE_APPEND);
        ksort($_POST); //排序post参数
        reset($_POST); //内部指针指向数组中的第一个元素
        $codepay_key="这里改成您的码支付密钥"; //这是您的密钥
        $sign = '';//初始化
        foreach ($_POST AS $key => $val) { //遍历POST参数
            if ($val == '' || $key == 'sign') continue; //跳过这些不签名
            if ($sign) $sign .= '&'; //第一个字符串签名不加& 其他加&连接起来参数
            $sign .= "$key=$val"; //拼接为url参数形式
        }
        if (!$_POST['pay_no'] || md5($sign . $codepay_key) != $_POST['sign']) { //不合法的数据
            exit('fail');  //返回失败 继续补单
        } else { //合法的数据
            //业务处理
            $pay_id = $_POST['pay_id']; //需要充值的ID 或订单号 或用户名
            $money = (float)$_POST['money']; //实际付款金额
            $price = (float)$_POST['price']; //订单的原价
            $param = $_POST['param']; //自定义参数
            $pay_no = $_POST['pay_no']; //流水号
            exit('success'); //返回成功 不要删除哦
        }
    }

    public function return_pay(){
        file_put_contents('codepay.txt',date('Ymd H:i:s').json_encode($_REQUEST)."\r\n",FILE_APPEND);
        ksort($_REQUEST); //排序post参数
        reset($_REQUEST); //内部指针指向数组中的第一个元素
        $codepay_key="这里改成您的码支付密钥"; //这是您的密钥
        $sign = '';//初始化
        foreach ($_REQUEST AS $key => $val) { //遍历POST参数
            if ($val == '' || $key == 'sign') continue; //跳过这些不签名
            if ($sign) $sign .= '&'; //第一个字符串签名不加& 其他加&连接起来参数
            $sign .= "$key=$val"; //拼接为url参数形式
        }
        if (!$_REQUEST['pay_no'] || md5($sign . $codepay_key) != $_REQUEST['sign']) { //不合法的数据
            exit('fail');  //返回失败 继续补单
        } else { //合法的数据
            //业务处理
            $pay_id = $_REQUEST['pay_id']; //需要充值的ID 或订单号 或用户名
            $money = (float)$_REQUEST['money']; //实际付款金额
            $price = (float)$_REQUEST['price']; //订单的原价
            $param = $_REQUEST['param']; //自定义参数
            $pay_no = $_REQUEST['pay_no']; //流水号
            exit('success'); //返回成功 不要删除哦
        }
    }


}
