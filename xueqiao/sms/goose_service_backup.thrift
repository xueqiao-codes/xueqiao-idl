/**
  * 短信验证ao
  */

namespace java com.longsheng.xueqiao.goose.thriftapi

include "../../../comm.thrift"
include "goose_common.thrift"

/**
  * 短信验证ao
  */
service(82) GooseAo {
	/**
	  * 用户绑定手机
	  * @throw VerifyCodeFailed
	  * @throw UserHadBoundMobile
	  * @throw MobileHadBoundAnotherUser
	  */
	void 1:bindUserMobile(
		1:comm.PlatformArgs platformArgs, 2:i32 userId, 3:string mobileNo, 4:string verifyCode) throws (1:comm.ErrorInfo err);

	/**
	  * 发送短信验证码
	  * @throw DonotSendSmsTooFrequently 如果一分钟内重复发送短信给同一个手机
	  * @throw SentTooManySmsToTheMobileNoOneDay 如果一天内重复3次发送短信给同一个手机
	  * @throw SendSmsVerifyFailed
	  */
	void 2:sendVerifyCode(1:comm.PlatformArgs platformArgs, 2:string mobileNo) throws (1:comm.ErrorInfo err);

	/**
		* 验证验证码
	*/
	bool 3:verifySmsCode(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:string smsCode) throws (1:comm.ErrorInfo err);
	
	/**
	  * 当通过常规发送方式发送验证码失败，新增重发短信任务
	*/
	i32 4:addSmsResendTask(1:comm.PlatformArgs platformArgs, 2:string mobileNo) 
			throws (1:comm.ErrorInfo err);
			
	/**
		* 获取并锁定重发短信任务列表
	*/
	list<goose_common.TSmsResendTask> 5:getAndLockSmsResendTask(1:comm.PlatformArgs platformArgs, 2:i32 taskNum) 
			throws (1:comm.ErrorInfo err);
	
	/**
		* 更新重发短信任务
	*/
	void 6:updateSmsResendTask(1:comm.PlatformArgs platformArgs, 2:goose_common.TSmsResendTask task) 
			throws (1:comm.ErrorInfo err);
	/**
	  * 给聊吧app发送短信验证码
	  * @throw DonotSendSmsTooFrequently 如果一分钟内重复发送短信给同一个手机
	  * @throw SentTooManySmsToTheMobileNoOneDay 如果一天内重复3次发送短信给同一个手机
	  * @throw SendSmsVerifyFailed
	  */
	void 7:sendVerifyCodeSetSign(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:string sign) throws (1:comm.ErrorInfo err);

	/**
	  * 给聊吧app发送语音验证码
	  * @throw DonotSendSmsTooFrequently 如果一分钟内重复发送短信给同一个手机
	  * @throw SentTooManySmsToTheMobileNoOneDay 如果一天内重复3次发送短信给同一个手机
	  * @throw SendSmsVerifyFailed
	  */
	void 8:sendVerifyCodeByVoice(1:comm.PlatformArgs platformArgs, 2:string mobileNo) throws (1:comm.ErrorInfo err);

	/**
	  * 根据不同appId使用不同模板发送短信验证码
	  * @throw DonotSendSmsTooFrequently 如果一分钟内重复发送短信给同一个手机
	  * @throw SentTooManySmsToTheMobileNoOneDay 如果一天内重复3次发送短信给同一个手机
	  * @throw SendSmsVerifyFailed
	  */
	void 9:sendVerifyCodeCommon(1:comm.PlatformArgs platformArgs, 2:string mobileNo, 3:i32 appId) throws (1:comm.ErrorInfo err);

	/**
	  * 根据不同appId使用不同模板发送语音验证码
	  * @throw DonotSendSmsTooFrequently 如果一分钟内重复发送短信给同一个手机
	  * @throw SentTooManySmsToTheMobileNoOneDay 如果一天内重复3次发送短信给同一个手机
	  * @throw SendSmsVerifyFailed
	  */
	void 10:sendVerifyCodeByVoiceCommon(1:comm.PlatformArgs platformArgs, 2:string mobileNo,3:i32 appId) throws (1:comm.ErrorInfo err);
	
}