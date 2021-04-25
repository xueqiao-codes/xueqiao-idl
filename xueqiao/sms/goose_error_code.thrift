/**
  * 短信验证
  */

namespace java com.longsheng.xueqiao.goose.errorcode

enum SmsErrorCode {
	SEND_VERIFY_CODE_FAILED = 80201,						// 验证码发送失败
	SEND_VERIFY_CODE_TOO_FREQUENTLY = 80202,				// 验证码发送太频繁
	SEND_VERIFY_CODE_TOO_MANY_TIMES_ONE_DAY = 80203,		// 验证码发送超过一天的限额
	
	VERIFY_CODE_ERROR = 80222,								// 验证码错误，验证失败
	
	SEND_SMS_FAILED = 80230,								// 短信发送失败
}
