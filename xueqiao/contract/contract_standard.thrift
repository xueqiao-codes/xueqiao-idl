namespace java com.longsheng.xueqiao.contract.standard.thriftapi
namespace csharp xueqiao.contract.standard
namespace cpp xueqiao.contract.standard

include "../../comm.thrift"

// 雪橇商品类型
enum SledCommodityType{
    NONE    = 0,						// 无
    FUTURES = 1,						// 期货
    OPTION  = 2,						// 期权
    SPOT    = 3,						// 现货
    SPREAD_MONTH        = 4,			// 跨期套利
    SPREAD_COMMODITY    = 5,			// 跨品种套利
    BUL     = 6,						// 看涨垂直套利
    BER     = 7,						// 看跌垂直套利
    STD     = 8,						// 跨式套利
    STG     = 9,						// 宽跨式套利
    PRT     = 10,						// 备兑组合
    DIRECTFOREX    = 11,				// 外汇——直接汇率
    INDIRECTFOREX  = 12,				// 外汇——间接汇率
    CROSSFOREX     = 13,				// 外汇——交叉汇率
    INDEX    = 14,						// 指数
    STOCK    = 15,						// 股票
}

// 组合方向,品种两腿组合合约的买卖方向和第几腿相同
enum CmbDirect{
    NONE      = 0,			// 无
    FIRST     = 1,			// 和第一腿一致
    SECOND    = 2,			// 和第二腿一致
}

// 交割行权方式,期货和期权了结的方式
enum DeliveryMode{
    NONE        = 0,				// 无
    GOODS       = 1,				// 实物交割
    CASH        = 2,				// 现金交割
    EXECUTE     = 3,				// 期权行权
    ABANDON     = 4,				// 期权放弃
    HKF         = 5,				// 港交所行权
}

// 商品状态
enum CommodityState{
    NONE = 0,					// 无
    TRADEABLE = 1,				// 商品允许交易
    NO_TRADEABLE = 2,			// 商品禁止交易
    CLOSE_ONLY = 3,				// 商品只可平仓
}

//合约状态
enum ContractStatus{
	NORMAL = 0,					//正常
	EXPIRED = 1,				//过期
	DISABLED = 2,				//禁用 (过滤条件之一, 可通过设置变为正常状态)
}

// 计算方式
enum CalculateMode{
    COMBINE     = 0,			// 比例+定额（仅限手续费）大于0.01部分为定额，小于0.01部分为比例，如：0.001为比例收取1%。
    PERCENTAGE  = 1,			// 比例
    QUOTA       = 2,			// 定额
    CHAPERCENTAGE  = 3,			// 差值比例 
    CHAQUOTA   = 4,				// 差值定额
    DISCOUNT   = 5,				// 折扣
}

// 实际发生交易的交易所归属类型
enum ExchangeOperatingMicType{
	OPERATING_MIC   = 0,			// 实际发生交易的交易所是本交易所
	SEGMENT_MIC     = 1,			// 实际发生交易的交易所是上级交易所
}

enum TechPlatformEnv{
	NONE = 0,
	REAL = 1,	// 实盘
	SIM = 2,	// 模拟盘
}

enum TechPlatform{
	NONE = 0,
	CTP = 1,
	ESUNNY =2,			// 易盛9.0（默认）
	SP =3,		
	ESUNNY_3 =4,		// 易盛3.0
}

// 雪橇交易所信息
struct SledExchange{
	1:optional i32 sledExchangeId;						// 内部唯一数字id
	2:optional string exchangeMic;						// ISO标准的交易所代号，唯一
	3:optional string country;							// 交易所所在国家
	4:optional string countryCode;						// 国家代号
	5:optional string operatingMic;						// 实际发生交易的交易所代号
	6:optional ExchangeOperatingMicType operatingMicType;	// 实际发生交易的交易所归属类型
	7:optional string nameInstitution;					// 交易所英文名称
	8:optional string acronym;							// 交易所英文简称
	9:optional string city;								// 所在城市
	10:optional string website;							// 交易所网站
	11:optional string cnName;							// 交易所中文名称
	12:optional string cnAcronym;						// 交易所中文简称
	13:optional string zoneId;							// 所在时区id
	14:optional i64 timeLagMs;							// 交易所与雪橇的延时毫秒数(
														// 正数表示雪橇比交易所晚，负数表示雪橇比交易所早)
	32:optional i64 activeStartTimestamp;				// 生效起始日期
	33:optional i64 activeEndTimestamp;					// 生效结束日期
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}


// 雪橇商品的配置信息, 一个商品可以同时有多个配置信息, 根据active 时间取当前配置信息
struct SledCommodityConfig{
	1:optional i32 configId;							// 配置信息id
	12:optional DeliveryMode deliveryMode;				// 交割行权方式
	13:optional i32 deliveryDays;						// 交割日偏移
	17:optional i32 maxSingleOrderVol;					// 单笔最大下单量
	18:optional i32 maxHoldVol;							// 最大持仓

	20:optional CalculateMode commissionCalculateMode;	// 手续费计算方式
	21:optional double openCloseFee;					// 开平手续费计算因子
	
	26:optional CalculateMode marginCalculateMode;		// 保证金计算方式
	27:optional double initialMargin;					// 初始保证金计算因子
	28:optional double maintenanceMargin;				// 维持保证金计算因子
	29:optional double sellInitialMargin;				// 看空初始保证金计算因子
	30:optional double sellMaintenanceMargin;			// 看空维持保证金计算因子
	31:optional double lockMargin;						// 锁仓保证金计算因子

	32:optional i64 activeStartTimestamp;				// 生效起始日期
	33:optional i64 activeEndTimestamp;					// 生效结束日期

	34:optional string measureUnit;						// 计量单位
	35:optional double chargeUnit;						// 计价单位

	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

// 雪橇统一商品
struct SledCommodity{
	// 不可变
	1:optional i32 sledCommodityId;						// 内部唯一数字id
	2:optional string exchangeMic;						// ISO标准的交易所代号
	3:optional SledCommodityType sledCommodityType;		// 雪橇商品类型
	4:optional string sledCommodityCode;				// 雪橇商品代号
	5:optional list<i32> relateCommodityIds;			// 关联商品
	6:optional string tradeCurrency;					// 交易币种
	7:optional string zoneId;							// 商品所在时区id
	8:optional double contractSize;						// 合约每手乘数
	9:optional double tickSize;							// 最小变动价位
	10:optional i32 denominator;						// 报价分母
	11:optional CmbDirect cmbDirect;					// 组合方向
	15:optional CommodityState commodityState;			// 商品状态

	20:optional list<SledCommodityConfig> sledCommodityConfig; // 所有配置信息
	22:optional string engName;							// 商品英文名称
	23:optional string cnName;							// 商品简体中文名称
	24:optional string tcName;							// 商品繁体中文名称

	25:optional bool isAlsoSupportSim;					// 是否同时支持模拟盘 (false：只支持实盘， true：同时支持实盘和模拟盘)
	26:optional string engAcronym;						// 英文简称
	27:optional string cnAcronym;						// 中文简称
	28:optional string tcAcronym;						// 繁体简称

	32:optional i64 activeStartTimestamp;				// 生效起始日期
	33:optional i64 activeEndTimestamp;					// 生效结束日期
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

// 雪橇合约详细
struct SledContract{
	1:optional i32 sledContractId;				// 雪橇合约内部唯一数字id
	2:optional i32 sledCommodityId;				// 雪橇商品id
	3:optional string sledContractCode;			// 雪橇合约编码
	4:optional list<i32> relateContractIds;		// 交易所组合合约的关联合约
	5:optional string sledTag;					// 雪橇合约别名，标识
	6:optional string contractEngName;			// 合约英文名称
	7:optional string contractCnName;			// 合约简体中文名称
	8:optional string contractTcName;			// 合约繁体中文名称
	9:optional i64 contractExpDate;				// 合约到期日
	10:optional i64 lastTradeDate;				// 最后交易日
	11:optional i64 firstNoticeDate;			// 首次通知日

	20:optional TechPlatformEnv platformEnv;	// 实盘/模拟盘合约
	21:optional ContractStatus contractStatus;	// 合约活跃状态
	22:optional bool subscribeXQQuote;			// 是否订阅了雪橇行情 (2019-03-07新加字段)
	32:optional i64 activeStartTimestamp;		// 生效起始日期
	33:optional i64 activeEndTimestamp;			// 生效结束日期
	40:optional i64 createTimestamp;			// 创建时间
	41:optional i64 lastModityTimestamp;		// 最后修改时间
}

// 雪橇合约携带商品详细
struct SledContractDetails{
	1:optional SledCommodity sledCommodity;
	2:optional SledContract sledContract;
}

struct ReqSledContractDetailsOption{
	1:optional set<i32> sledContractIds;
}

struct SledContractDetailsPage{
	1:optional i32 total;
	2:optional list<SledContractDetails> page;
}

struct CommodityMapping{
	1:optional i32 mappingId;				// 映射
	3:optional i32 sledCommodityId;			// 雪橇商品id
	4:optional TechPlatform techPlatform;	// 技术平台
	5:optional string exchange;				// 交易所代号
	6:optional string commodityType;		// 商品类型
	7:optional string commodityCode;		// 商品代号
	9:optional double moneyRatio;			// 价格转换比率 雪橇/平台
	10:optional i32 brokerEntryId;			// 券商实体信息id
	32:optional i64 activeStartTimestamp;	// 生效起始日期
	33:optional i64 activeEndTimestamp;		// 生效结束日期
	40:optional i64 createTimestamp;		// 创建时间
	41:optional i64 lastModityTimestamp;	// 最后修改时间
}

/*
 *	合约查询条件
 *	10以上字段使用逻辑或模糊查询，10以下字段使用逻辑与精确查询
 *  同时精确查询与模糊查询同时存在，则使用逻辑与,例如: 1&(10 || 11)
 */
struct ReqSledContractOption{
	// 以下字段使用逻辑与精确查询
	1:optional list<i32> sledContractIdList;
	2:optional i32 sledCommodityId;						// 雪橇商品id
	3:optional TechPlatformEnv platformEnv;
	4:optional string sledContractCode;
	5:optional ContractStatus contractStatus;
	6:optional bool needTotalCount = true;

	// 以下字段使用逻辑或模糊查询
	10:optional string contractCodePartical;
	11:optional string sledTagPartical;
	12:optional string contractEngNamePartical;
	13:optional string contractCnNamePartical;
}

/*
 *	商品查询条件
 *	10以上字段使用逻辑或模糊查询，10以下字段使用逻辑与精确查询
 *  同时精确查询与模糊查询同时存在，则使用逻辑与,例如: 1&(10 || 11)
 */
struct ReqSledCommodityOption{
	// 以下字段使用逻辑与精确查询
	1:optional list<i32> sledCommodityIdList;
	2:optional string exchangeMic;						// ISO标准的交易所代号
	3:optional SledCommodityType sledCommodityType;		// 雪橇商品类型
	4:optional string sledCommodityCode;				// 雪橇商品代号
	5:optional TechPlatformEnv platformEnv;
	6:optional bool needTotalCount = true;

	// 以下字段使用逻辑或模糊查询
	10:optional string sledCommodityCodePartical;
	12:optional string engNamePartical;
	13:optional string cnNamePartical;
}

/*
 *	交易所查询条件
 *	10以上字段使用逻辑或模糊查询，10以下字段使用逻辑与精确查询
 *  同时精确查询与模糊查询同时存在，则使用逻辑与,例如: 1&(10 || 11)
 */
struct ReqSledExchangeOption{
	// 以下字段使用逻辑与精确查询
	1:optional list<i32> sledExchangeIds;
	2:optional string exchangeMic;
	6:optional bool needTotalCount = true;

	// 以下字段使用逻辑或模糊查询
	10:optional string exchangeMicPartical;
	11:optional string nameInstitutionPartical;
	12:optional string acronymPartical;
	13:optional string cnAcronymPartical;
	14:optional string cnNamePartical;
}

struct SledExchangePage{
	1:optional i32 total;
	2:optional list<SledExchange> page;
}

struct SledCommodityPage{
	1:optional i32 total;
	2:optional list<SledCommodity> page;
}

struct SledContractPage{
	1:optional i32 total;
	2:optional list<SledContract> page;
}

struct CommodityMappingPage{
	1:optional i32 total;
	2:optional list<CommodityMapping> page;
}

struct ReqCommodityMappingOption{
	1:optional list<i32> sledCommodityIdList;
	2:optional string exchange;						// 券商交易所代号
	3:optional string commodityType;				// 券商商品类型
	4:optional string commodityCode;				// 券商商品代号
	5:optional i32 brokerEntryId;					// 券商实体的id
	6:optional list<i32> mapIds;
	7:optional TechPlatform techPlatform;
	8:optional bool needTotalCount = true;
}

/**
* 雪橇统一合约的业务错误码
* 
*/
enum SledContractErrorCode{
	SLED_COMMODITY_NOT_FOUND = 1000,
	COMMODITY_MAP_NOT_FOUND = 1001,
	SLED_EXCHANGE_NOT_FOUND	= 1002,
	COMMODITY_MAP_UPDATE_FORBID = 1003,
	SLED_COMMODITY_EXISTS = 1004,
	SLED_EXCHANGE_EXISTS = 1005,
	CONTRACT_VERSION_NOT_FOUND = 1006,
	COMMODITY_MAP_EXISTS = 1007,
	SLED_CONTRACT_NOT_FOUND = 1008,
}

