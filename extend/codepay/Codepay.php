<?php
namespace codepay;

use think\Cache;
use think\Loader;
Class Codepay
{
    public static function pay($params)
    {
        $config = config('codepay');
        $codepay_key = $config['key'];
        $parameter = array(
            "id" => $config['id'],//平台ID号
            "type" => $params['pay_type'],//支付方式
            "price" => (float)$params['total_amount'],//原价
            "pay_id" => $params['pay_id'], //可以是用户ID,站内商户订单号,用户名
            "param" => json_encode($params['ext']),//自定义参数
            "act" => 0,//此参数即将弃用
            "outTime" => 360,//二维码超时设置
            "page" => 1,//订单创建返回JS 或者JSON
            "return_url" => $_SERVER['REQUEST_SCHEME'].'://'.$_SERVER['HTTP_HOST'].'/index/pay/return_pay',//付款后附带加密参数跳转到该页面
            "notify_url" => $_SERVER['REQUEST_SCHEME'].'://'.$_SERVER['HTTP_HOST'].'/index/pay/notify_pay',//付款后通知该页面处理业务
            "style" => 1,//付款页面风格
            "pay_type" => 1,//支付宝使用官方接口
            "user_ip" => getIp(),//付款人IP
            //"qrcode_url" => $codepay_config['qrcode_url'],//本地化二维码
            "chart" => trim(strtolower('utf-8'))//字符编码方式
            //其他业务参数根据在线开发文档，添加参数.文档地址:https://codepay.fateqq.com/apiword/
            //如"参数名"=>"参数值"
        );
        file_put_contents('codepay.txt',date('Ymd H:i:s').'params::'.json_encode($parameter)."\r\n",FILE_APPEND);
        ksort($parameter); //重新排序$data数组
        reset($parameter); //内部指针指向数组中的第一个元素
        $sign = '';
        $urls = '';
        foreach ($parameter AS $key => $val) {
            if ($val == '') continue;
            if ($key != 'sign') {
                if ($sign != '') {
                    $sign .= "&";
                    $urls .= "&";
                }
                $sign .= "$key=$val"; //拼接为url参数形式
                $urls .= "$key=" . urlencode($val); //拼接为url参数形式
            }
        }

        $key = md5($sign . $codepay_key);//开始加密
        $query = $urls . '&sign=' . $key; //创建订单所需的参数
        $apiHost =  "http://api4.xiuxiu888.com/creat_order/?"; //网关
        $url = $apiHost . $query; //生成的地址
        return array("url" => $url, "query" => $query, "sign" => $sign, "param" => $urls);
        header("Location:{$url}");
//        $result = curl_get($url);
//        $result = json_decode($result,true);
//        return $result;
    }

    /**
     * 校检参数
     */
    private static function checkParams($params)
    {
        if (empty(trim($params['out_trade_no']))) {
            self::processError('商户订单号(out_trade_no)必填');
        }

        if (empty(trim($params['subject']))) {
            self::processError('商品标题(subject)必填');
        }

        if (floatval(trim($params['total_amount'])) <= 0) {
            self::processError('退款金额(total_amount)为大于0的数');
        }
    }

    /**
     * 统一错误处理接口
     * @param  string $msg 错误描述
     */
    private static function processError($msg)
    {
        throw new \think\Exception($msg);
    }

}


