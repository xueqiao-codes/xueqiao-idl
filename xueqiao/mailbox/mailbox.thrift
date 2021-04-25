/**
  * 信箱服务 核心数据结构
  */
namespace java xueqiao.mailbox.thriftdata.mb

include "./mb_message.thrift"


/**
  * 消息发送策略
  */
enum MSendingPolicy {
	MSP_NOW = 0,           // 立即
	MSP_FIXED_TIME = 1,    // 定时
	MSP_REPEAT = 2,        // 重复
}

/**
  * 消息发送通道
  */
enum MSendingChannel {
	MSC_MAIL = 1,    // 邮件
	MSC_SMS = 2,     // 短信
	MSC_HOSTING = 4, // 托管机
}

/**
  * 信息状态
  */
enum MStatus {
	MS_VALID = 0,      // 有效中
	MS_SENDING = 1,    // 发送中（发送之前设置为发送中状态，如果是单次，发送完成，则设置为完成；否则设置回有效中）
	MS_PAUSE = 2,      // 停止
	MS_COMPLETED = 10, // 完成

	//MS_EXCEPTION_STOP = 12,  // 异常停止 （非网络原因的异常导致的停止）
	//MS_NETWORK_ERROR_RETRY = 13,  // 网络异常重试 （过段时间会重新发送）
	//MS_NETWORK_ERROR_STOP = 14,  // 网络异常停止
}

/**
  * 信息实例状态
  */
enum MJStatus {
	MJS_SENDING = 0,    // 发送中
	MJS_COMPLETED = 1, // 完成

	MJS_EXCEPTION_STOP = 2,  // 异常停止 （非网络原因的异常导致的停止）
	MJS_NETWORK_ERROR_RETRY = 3,  // 网络异常重试 （过段时间会重新发送）
	MJS_NETWORK_ERROR_STOP = 4,  // 网络异常停止
}

/**
  * 消息发送时间重复单位
  */
enum MSendingTimeRepeatUnit {
	MSTRU_INFINITE = 0;  // 以天为周期无限循环
	MSTRU_DAY = 1,       // 以天为周期有限循环
	MSTRU_WEEK = 2,      // 以周为周期有限循环
	MSTRU_MONTH = 3,     // 以月为周期有限循环
}

/**
  * 信箱消息发送时间规则描述
  */
struct MSendingTimeRule {
	1:optional i64 mbmId;
	2:optional i64 mbStartTime;
	3:optional MSendingTimeRepeatUnit repeatUnit;
	4:optional i32 repeatCount;
	5:optional list<i64> dayTimeList;
	6:optional list<i32> unitTimeList;
}

/**
  * 信箱消息短信接收者
  */
struct MReceiverSms {
	1:optional i64 mbmId;
	2:optional string tel;
}

/**
  * 信箱消息邮件接收者
  */
struct MReceiverMail {
	1:optional i64 mbmId;
	2:optional string mail;
}

/**
  * 托管机用户角色
  */
enum HostingUserRole {
	//ALL = 0,             // 所有用户
	TRADER = 1,          // 交易员
	ADMIN = 2,           // 管理员
}

/**
  * 信箱消息托管机接收者
  */
struct MReceiverHosting {
	1:optional i64 mbmId;
	2:optional i64 companyId;
	3:optional i64 groupId;
	4:optional list<HostingUserRole> roleList;
}

/**
  * 信箱消息
  */
struct MBMessage {
	1:optional i64 mbmId;             // 信箱消息ID
	2:optional MSendingPolicy policy;
	3:optional list<MSendingChannel> channelList;
	4:optional list<MReceiverSms> smsList;
	5:optional list<MReceiverMail> mailList;
	6:optional list<MReceiverHosting> hostingList;
	7:optional MSendingTimeRule timeRule;
	
	8:optional mb_message.MessageContent content;
	9:optional MStatus status;
	10:optional string operator;
	
	40:optional i64 createTimestamp;      // 创建时间
	41:optional i64 lastModityTimestamp;  // 修改时间
}

/**
  * 信箱消息模板
  */
struct MBMessageTemplate{
	1:optional i64 templateId;             // 信箱消息ID
	2:optional MSendingPolicy policy;
	3:optional list<MSendingChannel> channelList;
	4:optional list<MReceiverSms> smsList;
	5:optional list<MReceiverMail> mailList;
	6:optional list<MReceiverHosting> hostingList;
	7:optional MSendingTimeRule timeRule;
	
	8:optional mb_message.MessageContent content;
	9:optional string templateName;
	
	40:optional i64 createTimestamp;      // 创建时间
	41:optional i64 lastModityTimestamp;  // 修改时间
}


/**
  * 信箱消息实例
  */
struct MBMessageJob {
	1:optional i64 jobId;
	2:optional i64 mbmId;
	3:optional list<MSendingChannel> channelList;
	4:optional list<MReceiverSms> smsList;
	5:optional list<MReceiverMail> mailList;
	6:optional list<MReceiverHosting> hostingList;
	
	8:optional mb_message.MessageContent content;
	9:optional MJStatus status;
	10:optional string errorDescription;
	11:optional string operator;
	
	40:optional i64 createTimestamp;      // 创建时间
	41:optional i64 lastModityTimestamp;  // 修改时间
}










