/*
 * 平台级别公用IDL, 不允许随意变更
 */
namespace java org.soldier.platform.svr_platform.comm
namespace cpp  platform.comm

enum EClientActionType {
    CLIENT_HANDLE = 1, // 客户端自行处理
    LOG = 2,    // 记录一条对应的错误日志即可，无需提示，例如定时同步数据失败
    TIPS = 4, // 需要告知用户的重要信息，具体tips的形式由客户端决定, 例如注册用户失败
    TIPS_ABORT = 5,  // 需要弹出框告知用户相关信息，同时点击确认后退出到软件启动的起始框, 例如SESSION过期
    NO_MAPPING = 6,  // 服务端找不到相应的映射
}

exception ErrorInfo{
	1:required i32 errorCode;  // 错误代码
	2:required string errorMsg; // 错误信息, 主要用于程序内部传递和读取
	
	// 错误码组件控制如下
	// 服务端有一个KEYINFO变量可以书写在对应的提示变量中，KEYINFO的意义唯一标识一条人为可读的信息
	// 例如：{KEYINFO}挂单失败，重复挂单(客户端可以将KEYINFO映射为套利单号)
	//       {KEYINFO}无法组合，组合行情过多(客户端可以将KEYINFO映射为所有的合约符号的组合，例如格式为黄金1703,白银1707,XXXX，KKKK...)
	// 客户端也可以无视KEYINFO，KEYINFO只是用于支持服务端更细化的显示一次请求错误的控制手段，客户端需了解每次请求对应的KEYINFO是什么
	// 服务端错误码细化得越多，在后台可以控制的粒度也就越细
	3:optional string clientMsg; // 用于展示给客户端的错误提示信息
	4:optional EClientActionType clientActionType; // 服务端给予的错误类型的处理
}

enum EClientLang {
    CN = 1,  // 中文
    EN = 2   // 英文
}

/**
  *  平台级参数，方便以后进行治理和查错
  */
struct PlatformArgs{
	1:optional string sourceDesc;
	2:optional i32 sourceIpV4; // 废弃，字段无用
	3:optional string remoteAddress;
	4:optional i32 remotePort;
	5:optional string xForwardAddress;
	6:optional string sourceIp;
	7:optional i32 timeoutMs;  // 客户端超时的时间，便于过载保护
	8:optional EClientLang clientLang = EClientLang.CN;  // 调用方语言类型
	9:optional map<string, string> extraParams;  // 额外的参数
}
