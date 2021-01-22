<?php
/*
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
author:ming    contactQQ:811627583
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 */
namespace app\common\model;

use think\Model;
use think\Db;
use codepay;

class User extends Model
{
    protected $insert = [];
    protected $readonly = ['username','create_time','pid','pusername'];

    protected $baseConfig;

    protected function initialize()
    {
        //需要调用`Model`的`initialize`方法
        parent::initialize();
        //TODO:自定义的初始化
        $this->baseConfig = unserialize(Db::name('system')->where('name','base_config')->value('value'));
    }
     /**
     * 注册
     * @return bool|string
     */
    public function reg($data=null)
    {
        Db::startTrans();
    	if($data){
    		$re=$this->allowField(true)->save($data);
    	}else{
    		$request=request();
    		$data = $request->post();
            if(!isset($data['data'])){
                $data['data'] = $data;
            }
    		$info = $data['data'];

    		$info['username'] = $info['mobile'];
    		$info['nickname'] = $info['nickname'];
        if(isset($info['pay_password'])){
          $info['pay_password'] = md5($info['pay_password'].config('salt'));
        }
    		$info['reg_ip'] =$_SERVER['REMOTE_ADDR'];
//            if (empty($data['pwd_pay'])) {
//                $data['pwd_pay'] = '666666';
//            }
            $info['create_time'] = time();
    		$re=$this->allowField(true)->save($info);
    		if ($re) {
    		    $pusername = $info['pusername'];
    		    if (!$this->getByMobile($info['pusername'])) {
    		        $pusername = 0;
                }
    		    model('UserRelation')->createRelation($this->id,$pusername);
            }
    	}
        //赠送宠物
        $pigInfo = model('Pig')->where(['is_reward'=>1])->find();
    	if($pigInfo){
            $price = 0;
            $saveDate = [];
            $saveDate['uid'] = $this->id;
            $saveDate['pig_id'] = $pigInfo['id'];
            $saveDate['pig_name'] = $pigInfo['name'];
            $saveDate['price'] = $price;
            $saveDate['contract_revenue'] = $pigInfo['contract_revenue'];
            $saveDate['cycle'] = $pigInfo['cycle'];
            $saveDate['doge'] = $pigInfo['doge'];
            $saveDate['pig_no'] = create_trade_no();
            $saveDate['status'] = 0;
            $saveDate['create_time'] = time();
            $saveDate['end_time'] = time()+$pigInfo['cycle']*24*3600;
            $sell_id = Db::name('user_pigs')->insertGetId($saveDate);
            //生成订单
            $sellOrder = [];
            $sellOrder['order_no'] = create_trade_no();
            $sellOrder['uid'] = $this->id;
            $sellOrder['pig_id'] = $pigInfo['id'];
            $sellOrder['source_price'] = $price;
            $sellOrder['price'] = $price;
            $sellOrder['pig_name'] = $pigInfo['name'];
            $sellOrder['create_time'] = time();
            $sellOrder['sell_id'] = $sell_id;
            $sellOrder['status'] = 3;
            $order_id = Db::name('PigOrder')->insertGetId($sellOrder);
            Db::name('user_pigs')->where('id',$sell_id)->update(['order_id'=>$order_id]);
        }
        Db::commit();

    	return $this->id;
    }

    public function UserInfo ($username) {
        $userInfo = $this->getByUsername($username);
        return $userInfo;
    }


    public function getUserLevelAttr($level)
    {
        $userLevel = [
          1 => '会员',
          2 => '初级合伙人',
          3 => '中级合伙人',
          4 => '高级合伙人'
        ];
        return $userLevel[$level];
    }



    /**
     * 创建时间
     * @return bool|string
     */
    protected function setCreateTimeAttr()
    {
        return time();
    }

     /**
     * 密码
     * @return bool|string
     */
    protected function setPasswordAttr($value)
    {
        return md5($value.config('salt'));
    }

    protected function setPwdPayAttr($val)
    {
        return md5($val.config('salt'));
    }

    /**
     * 团队人数达标奖励
     * @param $user_id
     * @throws \think\Exception
     */
    public function sunTeamForward ($user_id)
    {
        //所有上级用户
        $parentStr = Db::name('user')->where('id',$user_id)->value('prel');
        $parentArr = explode(',',$parentStr);
        array_shift($parentArr);
        array_pop($parentArr);
        foreach ($parentArr as $key=>$val) {
            $childCount = $this->sunTeamCount($val);
            if ($childCount == 500) {
                //增加资产
                $money = 100;
                Db::name('user')->where('id',$val)->setInc('money',$money);
                //  资产记录
                $moneyLog = [
                    'user_id' =>$val,
                    'money' =>$money,
                    'type' =>4,
                    'note' =>'团队达标500人奖励',
                    'create_time'=>date('Y-m-d H:i:s')
                ];
                Db::name('money_log')->insert($moneyLog);
            } elseif ($childCount ==1500) {
                $money = 1000;
                Db::name('user')->where('id',$val)->setInc('money',$money);
                //  资产记录
                $moneyLog = [
                    'user_id' =>$val,
                    'money' =>$money,
                    'type' =>4,
                    'note' =>'团队达标1500人奖励',
                    'create_time'=>date('Y-m-d H:i:s')
                ];
                Db::name('money_log')->insert($moneyLog);
            }
        }
    }
    /**
     * 团队用户统计
     * @param $user_id
     * @return int|string
     */
    public function sunTeamCount($user_id)
    {
        $count = Db::name('user')->where('prel','like','%,'.$user_id.',%')->count();
        return $count;
    }

    /**
     * 团队会员明细
     * @param $user_id
     * @return false|\PDOStatement|string|\think\Collection
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\ModelNotFoundException
     * @throws \think\exception\DbException
     */
    public function teamInfo($user_id)
    {
        $teamInfo = Db::name('user')->where('prel','like','%,'.$user_id.',%')->field('username')->select();
        return $teamInfo;
    }


    /**
     * 按充值金额统计业绩
     * @param $user_id
     * @return float|int
     */
    public function teamReacharge($user_id)
    {
        $childs = Db::name('user')->where('prel','like','%,'.$user_id.',%')->column('id');
//        dump($childs);
        $total = Db::name('money_log')->where(['user_id'=>['in',$childs],'type'=>['in',[2,5]]])->sum('money');
//        dump($total);die;
        return $total;
    }

    //根据上级级数分发分成
    public function parentForward($user_id,$money)
    {
        $userPrel = $this->where('id',$user_id)->value('prel');
        $prelArr = explode(',',$userPrel);
        array_pop($prelArr);
        array_shift($prelArr);
        foreach ($prelArr as $key=>$val) {
            echo $key;
            echo '<br/>';
        }
        dump($prelArr);die;
    }

    public function pay($user_id,$number,$pay_type,$wallet,$type='recharge',$data_id=0){
        $result = ['status'=>false,'msg'=>'','data'];
        $pay_type_arr = [
            'ali' => 1,
            'qq' => 2,
            'wx' => 3,
        ];
        if(empty($pay_type_arr[$pay_type])){
            $result['msg'] = '充值方式错误';
            return $result;
        }
        $params = [
            'pay_id' => build_order_no(),
            'total_amount' => $number,
            'pay_type' => $pay_type_arr[$pay_type],
            'ext' => ['充值狗狗币'],
        ];
        $data = $params;
        $data['uid'] = $user_id;
        $data['w_time'] = time();
        $data['wallet'] = $wallet;
        $data['type'] = $type;
        $data['data_id'] = $data_id;
        Db::name('pay_order')->insertGetId($data);
        $pay = codepay\Codepay::pay($params);

        $result['status'] = true;
        $result['data'] = $pay;
        return $result;
    }
}