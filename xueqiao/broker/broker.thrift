namespace java com.longsheng.xueqiao.broker.thriftapi
namespace csharp xueqiao.broker

// 券商的接入状态信息
enum BrokerAccessStatus{
	NEW = 0,					// 新增
	EDIT = 1,					// 编辑中
	VERIFIED_CORRECT = 2,		// 已验证
	SYNCHRONIZED = 3,			// 已下发同步
}

// 券商接入信息的使用状态
enum BrokerAccessWorkingStatus{
	NOT_WORKING = 0,			// 尚未使用
	WORKING =1,					// 使用中
}

// 技术平台环境
enum TechPlatformEnv{
	NONE = 0,		// 未设定
	REAL = 1,		// 实盘
	SIM = 2,		// 模拟盘
}

enum BrokerPlatform{
	NONE = 0,
	CTP = 1,
	ESUNNY =2,			// 易盛9.0（默认）
	SP =3,		
	ESUNNY_3 =4,		// 易盛3.0
}

struct AccessAddress{
	1:optional string address;
	2:optional i32 port;
}

struct BrokerEntry{
	1:optional i32 brokerId;								//系统生成，唯一id，不可变
	2:optional string engName;								//券商英文名称
	3:optional string cnName;								//券商中文名称
	4:optional string note;									//备注
	5:optional list<TechPlatformEnv> techPlatformEnvs;		//可支持的平台环境
	8:optional list<BrokerPlatform> techPlatforms;			//可支持的技术平台
	6:optional i64 lastModityTimestamp;
	7:optional i64 createTimestamp;
}

struct BrokerAccessEntry{
	1:optional i32 entryId;									//系统生成，唯一id，不可变
	2:optional i32 brokerId;								//券商实体id
	3:optional BrokerPlatform platform;						//券商接入平台
	4:optional list<AccessAddress> tradeAddresses;			//接入地址列表
	5:optional map<string,string> customInfoMap;			//自定义券商接入相关信息
	6:optional BrokerAccessStatus status;					//券商的接入状态信息
	7:optional i64 lastModityTimestamp;
	8:optional i64 createTimestamp;
	9:optional BrokerAccessWorkingStatus workingStatus;		//券商接入信息的使用状态
	10:optional TechPlatformEnv techPlatformEnv;			//技术平台环境
	11:optional string accessName;							//券商接入名称
	12:optional list<AccessAddress> quotaAddresses;			//接入地址列表
}

enum BrokerErrorCode {
    BROKER_NOT_FOUND = 1000,				// 查询不到对应的期货公司信息
    BROKER_ENG_NAME_EXIST = 1001,			// 期货公司中文名称已经存在
    BROKER_CN_NAME_EXIST = 1002,			// 期货公司英文名称已经存在
    BROKER_ACCESS_NOT_VERIFIED = 1003,		// 期货公司接入信息并未通过验证
    BROKER_EXIST = 1004,					// 期货公司已经存在
    BROKER_ACCESS_EXIST = 1005, 			// 期货公司此接入已经存在
    BROKER_ACCESS_NOT_FOUND = 1006, 		// 期货公司此接入不存在
    BROKER_ACCESS_BROKERID_NO_CHANGE = 1007, // 期货公司此接入BROKER_ID不能修改
    BROKER_ACCESS_PLATFORM_NO_CHANGE = 1008, // 期货公司此接入PLATFORM不能修改
    BROKER_ACCESS_NOT_WORKING = 1009,		// 期货公司此接入并未同步下发
    BROKER_ACCESS_WORKING = 1010,			// 期货公司此接入已同步下发
    BROKER_ACCESS_ADDRESS_ERROR = 1011,		// 填入的address错误
    BROKER_ACCESS_ADDRESS_PORT_ERROR = 1012,	// 填入address的端口必须大于0
    BROKER_ACCESS_TECH_PLATFORM_MUST_SET = 1013, // 平台信息必须设定
    BROKER_ACCESS_TRADE_ADDRESS_MUST_SET = 1014, // 交易地址必须设定
    BROKER_ACCESS_TECH_PLATFORM_ENV_MUST_SET = 1015 // 技术平台环境（模拟、实盘）必须设定
    BROKER_ACCESS_MAPPING_FILE_MUST_SET = 1016,	// 映射文件必须设定
    BROKER_ACCESS_CUSTOM_INFO_MUST_SET = 1017,	// 对应于某个接入技术平台的一些特性必须设定
    BROKER_ACCESS_PLATFORM_ENV_NO_CHANGE = 1018, // 期货公司此接入平台环境不能修改
    BROKER_ACCESS_CUSTOM_INFO_NO_CHANGE = 1019,	// 对应于某个接入技术平台的特性不能修改
}