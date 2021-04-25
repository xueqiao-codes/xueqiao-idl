/**
  * 信箱服务 消息体数据结构
  */
namespace java xueqiao.mailbox.thriftdata.message

/**
  * 消息内绑定环境变量
  * 消息内出现以下字符串，最终发出的消息中会替换成实际使用的名称
  */
const string MESSAGE_ENV_VARIABLE_COMPANY_NAME = "{{companyName}}";
const string MESSAGE_ENV_VARIABLE_COMPANY_CODE = "{{companyCode}}";
const string MESSAGE_ENV_VARIABLE_GROUP_NAME = "{{groupName}}";
const string MESSAGE_ENV_VARIABLE_USER_NAME = "{{userName}}";

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
	LEVEL_MEDIUM = 10,  // 中
	LEVEL_HIGH = 20,    // 高
}

/**
  * 信息体
  */
struct MessageContent{
	1:optional MType type;                // 信息类型
	2:optional MLevel level;              // 信息级别
	10:optional string title;             // 信息标题
	11:optional string summary;           // 信息概要
	12:optional string content;           // 信息内容
}



