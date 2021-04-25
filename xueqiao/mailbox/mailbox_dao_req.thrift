/**
  * 信箱服务 核心数据结构
  */
namespace java xueqiao.mailbox.thriftdata.req

include "./mailbox.thrift"
include "./mb_message.thrift"


/**
  * 信箱消息页
  */
struct MBMessagePage {
	1:optional i32 totalNum;
	2:optional list<mailbox.MBMessage> messageList;
}

/**
  * 查询信箱消息条件
  */
struct QueryMBMessageOption {
	1:optional set<i64> mbmIdSet;
	2:optional set<mailbox.MStatus> statusList;
}

/**
  * 信箱消息模板页
  */
struct MBMessageTemplatePage {
	1:optional i32 totalNum;
	2:optional list<mailbox.MBMessageTemplate> templateList;
}

/**
  * 查询信箱消息条件
  */
struct QueryMBMessageTemplateOption {
	1:optional set<i64> templateIdSet;
	2:optional string templateNamePartial;
	3:optional mailbox.MSendingChannel channel;
	4:optional mb_message.MType type;
	5:optional mb_message.MLevel level;
}


/**
  * 信箱消息实例页
  */
struct MBMessageJobPage {
	1:optional i32 totalNum;
	2:optional list<mailbox.MBMessageJob> messageJobList;
}

/**
  * 查询信箱消息实例条件
  */
struct QueryMBMessageJobOption {
	1:optional set<i64> jobIdSet;
	2:optional mailbox.MSendingChannel channel;
	3:optional mb_message.MType type;
	4:optional mb_message.MLevel level;
	5:optional i64 queryStartCreateTimestamp;
	6:optional i64 queryEndCreateTimestamp;
	7:optional set<mailbox.MJStatus> statusSet;
}



