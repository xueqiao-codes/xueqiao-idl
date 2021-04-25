/**
  * 短信验证ao
  */

namespace java com.longsheng.xueqiao.goose.thriftapi

include "../../comm.thrift"
include "goose_error_code.thrift"

/**
  * 短信验证ao
  */
service(82) GooseAo {

	/**
	  * 发送短信验证码
	  */
	void 1:sendVerifyCode(1:comm.PlatformArgs platformArgs, 2:string mobileNo) throws (1:comm.ErrorInfo err);

	/**
	  * 验证验证码
	  */
	bool 2:verifySmsCode(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:string smsCode) throws (1:comm.ErrorInfo err);
	
	/**
	  * 发送用户通知短信
	  */
	void 5:sendUserNotificationSms(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:string msg) throws (1:comm.ErrorInfo err);

	/**
	  * 发送运维通知短信（发送给公司运维人员）
	  * 运维人员的电话号码由QCONF配置
	  */
	void 6:sendMaintenanceNotificationSms(1:comm.PlatformArgs platformArgs, 2:string msg) throws (1:comm.ErrorInfo err);
	
	/**
	  * 发送信箱消息短信
	  */
	void 7:sendMailboxMessage(1:comm.PlatformArgs platformArgs, 2:string tel, 3:string userName, 4:string content) throws (1:comm.ErrorInfo err);
	
	/**
	  * 验证验证码
	  */
	bool 8:verifySmsCodeForClear(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:string smsCode, 4:bool clear) throws (1:comm.ErrorInfo err);

}