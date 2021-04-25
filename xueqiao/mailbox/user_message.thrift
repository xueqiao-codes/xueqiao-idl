/**
  * 托管机消息信箱服务数据类型
  */
namespace * xueqiao.mailbox.user.message.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

enum MailBoxUserMessageError{
	HOSTING_MESSAGE_EXIST = 1001;				// 消息已存在
	HOSTING_MESSAGE_NOT_FOUND =1002;			// 消息不存在
	HOSTING_MESSAGE_MARK_READ_OPTION_NOT_SET = 1003;	// 没有设置已读条件
}

/**
  * 信息类型
  */
enum MType {
	TYPE_XUEQIAO_NOTICE = 0,         // 雪橇通知
	TYPE_SYSTEM_NOTICE = 1,          // 系统通知
	TYPE_EXCHANGE_NOTICE = 2,        // 交易所通知
	TYPE_MARKETING_PROMOTION = 3,    // 营销推广
}

/**
  * 信息级别
  */
enum MLevel {
	LEVEL_LOW = 0,     // 低
	LEVEL_MEDIUM = 1,  // 中
	LEVEL_HIGH = 2,    // 高
}


/**
  * 信息状态
  */
enum MessageState{
	CREATE = 0, 	// 新建
	READ = 1,		// 已读
}

struct UserMessage{
	1:optional i64 messageId;		// 托管机消息id
	2:optional i64 companyId;				// 公司id
	3:optional i64 userId;					// 用户id
	4:optional i64 messageJobId;			// 消息发送id
	5:optional MType type;					// 信息类型
	6:optional MLevel level;				// 信息级别
	7:optional string title;				// 信息标题
	8:optional string summary;				// 信息概要
	9:optional string contentFileName;		// 信息内容所存储的文件名
	10:optional MessageState state;			// 阅读状态

	11:optional i64 createTimestamp;
	12:optional i64 lastModifyTimestamp;
}

struct ReqUserMessageOption{
	1:optional i64 userId;
	2:optional i64 companyId;
	3:optional i64 messageJobId;
	4:optional i64 messageId;
	5:optional MessageState state;
	6:optional i64 startTimestamp;
  	7:optional i64 endTimstamp;
}

struct MarkReadOption{
	1:optional set<i64> messageIds;
	2:optional i64 messageJobId;
	3:optional i64 userId;
	4:optional i64 companyId;
}

struct UserMessagePage{
	1:optional i32 total;
	2:optional list<UserMessage> page;
}