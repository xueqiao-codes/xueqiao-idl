/**
  * 托管机推送的协议, 从原有的行情推送协议中衍生出来
  */
namespace * xueqiao.trade.hosting.push.protocol

include "../quotation/quotation_item.thrift"

/**
  * 协议类型
  */
enum ProtocolType {
	QUOTATION = 1,  // 行情类型
	USERMSG = 2, // 服务端产生用户消息
	REQ = 3,  // 请求
	RESP = 4, // 回复类型
	SEQMSG = 5, // 序列消息
}

enum ProtocolCallErrors {
	ParamError = 1000,     // 参数错误
	MethodNotFound = 1001, // 调用的方法未找到
	TokenInvalid = 1002,   // Token无效
	ServiceUnavailable = 2003, // 后台暂时无法服务
}

/**
  * 推送用户消息的内容
  */
struct UserMsgContent {
	1:required string msgType;
	2:optional binary msgBytes;
}

/**
  * 客户端发送请求的内容
  */
struct ReqContent {
	1:required i64 requestId;  // 请求唯一ID，调用方生成
	2:required string requestStructType; // 请求结构体
	3:optional binary requestStructBytes; // 请求结构体序列化形式
}

/**
  * 服务端回复内容
  */
struct RespContent {
	1:required i64 responseId; // 服务端生成的唯一回复ID
	2:required i64 requestId;  // 请求的ID
	3:required i32 errCode;    // 零表示调用成功
	4:optional string errMsg;  // 错误信息
	5:optional string responseStructType; // 回复结构体
	6:optional binary responseStructBytes; // 回复结构体的内容
}

const string SEQ_ALIGN_TYPE = "#SEQALIGN#";

struct SeqMsgContent {
    1:required i64 seqNo;   // 消息序列号
    2:required string msgType; // 消息类型
    3:optional binary msgBytes; // 消息结构体的内容
}

/**
  * 协议帧的数据结构
  */
struct ProtocolFrame {
	1:required ProtocolType protocol;
	2:optional UserMsgContent userMsg; // 当ProtocolType为USERMSG时有效
	3:optional ReqContent reqContent;  // 当ProtocolType为REQ时有效
	4:optional RespContent respContent; // 当ProtocolType为RESP时有效
	5:optional quotation_item.QuotationItem quotationItem; // 当ProtocolType为QUOTATION时有效 
	6:optional SeqMsgContent seqMsg;    // 当ProtocolType为SEQMSG时有效
}

/**
  * 行情主题
  */
struct QuotationTopic {
	1:optional string platform;           // 订阅平台
	2:optional string contractSymbol;    // 合约代码
}

// 订阅合约行情
struct QuotationSubscribeReq {
	1:required list<QuotationTopic> topics; 
}

// 取消合约订阅
struct QuotationUnSubscribeReq {
	1:required list<QuotationTopic> topics; 
}

// 心跳请求
struct HeartBeatReq {
	1:required i64 machineId;
	2:required i32 subUserId;
	3:required string token; 
}

// 强制客户端同步事件
struct ClientForceSyncEvent {
    1:required i32 subUserId; 
}
