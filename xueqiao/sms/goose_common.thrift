/**
  * 短信验证
  */

namespace java com.longsheng.xueqiao.goose.thriftapi

enum Status {
	Unknown = 0, // 未知
	Succeed = 1, // 发送成功
	Failed = 2, // 发送失败
}

enum SmsResendTaskStatus {
	Created = 0, // 创建
	Resending = 1, // 重发中
	Succeed = 2, // 发送成功
	Failed = 3, // 发送失败
}

enum MessageType{
	SMS = 0,  //短信
	VOICE = 1, //语音
}

struct TSmsVerify {
	1:optional i32 smsVerifyId;
	2:optional string mobileNo;
	3:optional string verifyCode;
	4:optional i32 sendTimestamp;
	5:optional Status status;
	6:optional string message;
	7:optional MessageType type;
}

struct TSmsResendTask {
	1:optional i32 smsResendTaskId;
	2:optional string mobileNo;
	3:optional string verifyCode;
	4:optional i32 sendTimestamp;
	5:optional SmsResendTaskStatus status;
	6:optional string message;
}

struct TSmsResendTaskPage {
	1:optional i32 total;
	2:optional list<TSmsResendTask> page;
}

struct QuerySmsResendTaskOption{
	1:optional i32 smsResendTaskId;
	2:optional string mobileNo;
	3:optional SmsResendTaskStatus status;
	4:optional string orderBy;
}

struct QuerySmsVerifyOption{
	1:optional string mobileNo;
	2:optional Status status;
	3:optional string orderBy;
	4:optional i32 limitParam1;
	5:optional i32 limitParam2;
	6:optional MessageType type; 
}

enum WebstorageErrorCode {
	DonotSendSmsTooFrequently = 80201, // 发送验证码
	SentTooManySmsToTheMobileNoOneDay = 80202, //同一天发送太多次验证码到同一个手机 
	VerifyCodeFailed = 80203, // 验证码错误
	SendSmsVerifyFailed = 80204, // 发送短信验证码失败
	UserHadBoundMobile = 80205, // 用户已经绑定了手机
	MobileHadBoundAnotherUser = 80206, // 该手机已经绑定了其他用户
	ShouldSendSmsVerifyFirst = 80207, // 要先发送验证码，才能重新发送
	ToWaitSomeTimeAndResendSms = 80208, // 发送了验证码以后，如果收不到，要隔一段时间才能重新发送
	ResendSmsToManyTimes = 80209, // 重新发送验证码达到或者超过3次，则不允许再发
	ResendingAndWait = 80210, // 正在重发中，请稍等
}
