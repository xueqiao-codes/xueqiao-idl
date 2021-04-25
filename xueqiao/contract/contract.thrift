namespace java com.longsheng.xueqiao.contract.thriftapi
namespace csharp xueqiao.contract
namespace cpp xueqiao.contract

include "../../comm.thrift"
include "contract_standard.thrift"
include "../../page.thrift"

enum CommodityMapFileStatus{
	IN_USE = 0;
	NO_USE = 1;
}

struct CommodityMapFileInfo{
	1:optional binary commodityMapFile;					// 映射文件
	2:optional contract_standard.TechPlatform techPlatform;  // 映射对应的技术平台
	3:optional i32 brokerEntryId;						// 券商实体的id
	4:optional string fileMD5;
	5:optional string path;
	6:optional string url;
	7:optional i32 version;
	8:optional i32 fileInfoId;							// 记录自增id
	9:optional CommodityMapFileStatus status;			// 状态标记，0表示最新
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct CommodityMapFileInfoPage{
	1:optional i32 total;
	2:optional list<CommodityMapFileInfo> page;
}

struct ReqCommodityMapFileInfoOption{
	1:optional list<i32> brokerEntryIds;
	2:optional contract_standard.TechPlatform techPlatform;
	3:optional list<i32> fileInfoIds;
	4:optional CommodityMapFileStatus status;
}

struct RemoveCommodityMapFileInfoOption{
	1:optional list<i32> brokerEntryIds;
	2:optional list<i32> fileInfoIds;
	4:optional CommodityMapFileStatus status;
}

enum SyncTaskType{
	COMMODITY = 0,
	CONTRACT = 1,
	COMMODITY_MAPPING = 2,
}

struct SyncMappingTask{
	1:optional i32 taskId;
	2:optional i32 syncTargetId;
	3:optional contract_standard.TechPlatformEnv techPlatformEnv;
	4:optional SyncTaskType taskType;
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct SyncMappingTaskPage{
	1:optional i32 total;
	2:optional list<SyncMappingTask> page;
}

struct ReqSyncMappingTaskOption{
	1:optional list<i32> taskIds;
	2:optional list<i32> targetIds;
	3:optional contract_standard.TechPlatformEnv techPlatformEnv;
	4:optional SyncTaskType taskType;
}

// 保存平台商品源数据
struct TechPlatformCommodity{
	1:optional i32 sledCommodityId;						// 内部唯一数字id
	2:optional string exchange;							// 交易所代号
	3:optional string commodityType;				// 商品类型
	4:optional string commodityCode;				// 商品代号
	5:optional list<string> relateCommodityCodes;		// 关联商品
	6:optional string tradeCurrency;					// 交易币种
	7:optional string timezone;							// 商品时区
	8:optional double contractSize;						// 合约每手乘数
	9:optional double tickSize;							// 最小变动价位
	10:optional i32 denominator;						// 报价分母
	11:optional contract_standard.CmbDirect cmbDirect;				// 组合方向
	15:optional contract_standard.CommodityState commodityState;	// 商品状态

	22:optional string engName;							// 商品英文名称
	23:optional string cnName;							// 商品简体中文名称
	24:optional string tcName;							// 商品繁体中文名称

	12:optional contract_standard.DeliveryMode deliveryMode;				// 交割行权方式
	13:optional i32 deliveryDays;						// 交割日偏移
	17:optional i32 maxSingleOrderVol;					// 单笔最大下单量
	18:optional i32 maxHoldVol;							// 最大持仓

	20:optional contract_standard.CalculateMode commissionCalculateMode;	// 手续费计算方式
	21:optional double openCloseFee;					// 开平手续费计算因子
	
	26:optional contract_standard.CalculateMode marginCalculateMode;		// 保证金计算方式
	27:optional double initialMargin;					// 初始保证金计算因子
	28:optional double maintenanceMargin;				// 维持保证金计算因子
	29:optional double sellInitialMargin;				// 看空初始保证金计算因子
	30:optional double sellMaintenanceMargin;			// 看空维持保证金计算因子
	31:optional double lockMargin;						// 锁仓保证金计算因子

	35:optional contract_standard.TechPlatform techPlatform; //所属技术平台

	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TechPlatformCommodityPage{
	1:optional i32 total;
	2:optional list<TechPlatformCommodity> page;
}

struct ReqTechPlatformCommodityOption{
	1:optional list<i32> techPlatformCommodityIds;
	2:optional list<i32> sledCommodityIds;
	3:optional contract_standard.TechPlatform techPlatform;
	4:optional string techPlatformExchange;
	5:optional string techPlatformCommodityType;
	6:optional string techPlatformCommodityCode;
}

struct ContractVersion{
	1:optional i32 versionId;
	2:optional string fileMD5;
	3:optional string filePath;
	4:optional i64 createTimestamp;
	5:optional i64 lastModityTimestamp;
}

struct ContractVersionPage{
	1:optional i32 total;
	2:optional list<ContractVersion> page;
}

struct ReqContractVersionOption{
	1:optional i32 versionId;
	2:optional bool latest;
	6:optional bool needTotalCount = true;
}

struct RemoveContractVersionOption{
	1:optional i32 versionId;
	2:optional bool all;
}

struct DbLockingInfo{
	1:optional bool isLocked;
	2:optional string lockedBy;
	3:optional i64 startLockedTimestamp;
	4:optional i64 createTimestamp;
	5:optional string lockArea;
}


// **** 交易时间的查询与使用 ****

	// 时间段的状态
enum TimeSpanState{
	T_OPEN = 0,
	REST = 1,
	CLOSED = 2,
	T_PLUS_ONE_OPEN = 3,
}

	// 一个交易时段并描述该时段的状态
struct TTimeSpan{
	1:optional string timespan;					// 时间段，格式 hh:mm:ss - hh:mm:ss
	2:optional TimeSpanState timeSpanState;
	3:optional i64 startTimestamp;
	4:optional string startTimeString;
	5:optional i64 endTimestamp;
	6:optional string endTimeString;
}

	// 一天各个时间段及其状态
struct DateTimeSpan{
	2:optional string date;									// 日期,格式 yyyy-MM-dd
	3:optional list<TTimeSpan> tTimeSpan;					// 当日所有时间段及其状态
}

	// 计算出商品某天前后n天的交易时间
struct SledTradeTime{
	1:optional i32 sledCommodityId;
	2:optional list<DateTimeSpan> dateTimeSpans;
	6:optional string zoneId;						// 时钟计算时，商品所在的时区id
}

	//	查询商品交易时间的option
struct ReqSledTradeTimeOption{
	1:optional list<i32> sledCommodityIds;

	// 2字段将废弃，请使用3,4字段的组合描述需要查询的交易天数信息
	2:optional i64 dateTimestamp;					// 查询某一天的交易时间, 时间戳，精确到毫秒
	
	3:optional string date;					// 查询参考日期，日期格式： yyyy-MM-dd
	4:optional i32 days;					// 参考日期前后天数，例如： days =1， 返回参考日期前一天，当天，后一天总共3天的数据
}

struct SledTradeTimePage{
	1:optional i32 total;
	2:optional list<SledTradeTime> page;
}


// **** 交易时间配置与存储 ****
enum Days{
	SUNDAY = 0,
	MONDAY = 1,
	TUESDAY = 2,
	WEDNESDAY = 3,
	THURSDAY = 4,
	FRIDAY = 5
	SATURDAY = 6,
}

enum NextTradeOpenType{
	NEXT_TIMESPAN = 0,
	IMMEDIATELY = 1,
}

// **** 根据trade session设计交易时间配置 开始****
// 时制
enum TimeSystem{
	STANDARD = 0, // 冬令时(标准时间)
	DST = 1,	  // 夏令时
}

struct SledTradingSessionTimeSpan{
	1:optional i64 timeSpanId;					// 内部生成，唯一
	2:optional Days startDay;					// 星期几, 例如：星期一
	3:optional string startTime;				// 开始时间，HH:mm:ss， 例如 9:00:00
	4:optional Days endDay;						// 星期几, 例如：星期一
	5:optional string endTime;					// 结束时间，HH:mm:ss， 例如 11:30:00
	6:optional TimeSpanState timeSpanState;		// 时间段的状态，例如开市状态
	7:optional i64 tradeSessionId;				// 所属tradingSession
	8:optional i64 createTimestamp;
	9:optional i64 lastModifyTimestamp;
}

struct SledTradingSession{
	1:optional i64 tradeSessionId;
	2:optional i32 sledCommodityId;
	3:optional string zoneId;
	4:optional list<SledTradingSessionTimeSpan> timeSpans;
	5:optional TimeSystem timeSystem;			// 时制
	9:optional i64 createTimestamp;
	10:optional i64 lastModifyTimestamp;
}

struct SledTradingSessionPage{
	1:optional i32 total;
	2:optional list<SledTradingSession> page;
}

struct ReqSledTradingSessionOption{
	1:optional i32 sledCommodityId;
	2:optional set<i64> tradeSessionIds;
	3:optional TimeSystem timeSystem;
}

// **** 根据trade session设计交易时间配置 结束****

// **** 旧版交易时间配置 （已废弃）开始****
struct DayTradeTime{
	1:optional list<string> tTradeTimes;				// 交易时间段设置，格式 HH:mm:ss-HH:mm:ss
	2:optional list<string> tPlusOneTradeTimes;			// T+1交易时间段设置，格式 HH:mm:ss-HH:mm:ss
}

struct SledTradeTimeConfig{
	1:optional i32 sledCommodityId;
	2:optional map<Days, DayTradeTime> standardWeekTradeTimes;
	3:optional string zoneId;
	4:optional map<Days, DayTradeTime> dstWeekTradeTimes;
	7:optional i64 createTimestamp;
	8:optional i64 lastModifyTimestamp;
	9:optional bool dstExists;
}

struct ReqSledTradeTimeConfigOption{
	1:optional set<i32> sledCommodityIds;
}

struct SledTradeTimeConfigPage{
	1:optional i32 total;
	2:optional list<SledTradeTimeConfig> page;
}

struct DstTransferConfig{
	1:optional i32 dstTransferConfigId;
	2:optional list<string> exchangeMics;
	3:optional list<string> sledCommodityTypes;
	4:optional list<string> sledCommodityNames;
	5:optional list<i32> commodityIds;
	8:optional i32 standard2DstOffSetMinute;
	9:optional i64 createTimestamp;
	10:optional i64 lastModifyTimestamp;
	11:optional bool custom;
}

struct DstTransferConfigPage{
	1:optional i32 total;
	2:optional list<DstTransferConfig> page;
}

struct ReqDstTransferConfigOption{
	1:optional list<i32> dstTransferConfigId;
	2:optional list<i32> sledCommodityIds;
}

struct RemoveDstTransferConfigOption{
	1:optional list<i32> dstTransferConfigIds;
}
// **** 旧版交易时间配置 （已废弃）结束****

struct SpecTradeTime{
	1:optional i32 specTradeTimeId;
	2:optional string exchangeMic;
	3:optional list<i32> sledCommodityIds;
	4:optional i64 nonTradeStartTimestamp;
	5:optional i64 nonTradeEndTimestamp;
	6:optional NextTradeOpenType nextTradeOpenType;
	7:optional i64 createTimestamp;
	8:optional i64 lastModifyTimestamp;
	9:optional list<string> sledCommodityTypes;
	10:optional list<string> sledCommodityNames;
	11:optional string zoneId;
}

struct SledCommoditySpecTradeTime{
	1:optional i32 sledCommodityId;
	2:optional i32 specTradeTimeId;
	4:optional i64 nonTradeStartTimestamp;
	5:optional i64 nonTradeEndTimestamp;
	6:optional NextTradeOpenType nextTradeOpenType;
	7:optional i64 createTimestamp;
	8:optional i64 lastModifyTimestamp;
}

struct ReqCommoditySpecTradeTimeOption{
	1:optional set<i32> sledCommodityIds;
	2:optional i64 startTimestamp;
	3:optional i64 endTimestamp;
}

struct SledCommoditySpecTradeTimePage{
	1:optional i32 total;
	2:optional list<SledCommoditySpecTradeTime> page;
}

struct ReqSpecTradeTimeOption{
	1:optional set<i32> specTradeTimeIds;
	2:optional string exchangeMic;
}

struct SpecTradeTimePage{
	1:optional i32 total;
	2:optional list<SpecTradeTime> page;
}

struct RemoveSpecTradeTimeOption{
	1:optional list<i32> specTradeTimeIds;
}

struct SledExchangeMapping{
	1:optional i32 mappingId;
	2:optional string sledExchangeMic;
	3:optional contract_standard.TechPlatform techPlatform;
	4:optional string techPlatformExchangeCode;
	5:optional i64 createTimestamp;
	6:optional i64 lastModifyTimestamp;
}

struct SledCommodityTypeMapping{
	1:optional i32 mappingId;
	2:optional contract_standard.SledCommodityType sledCommodityType;
	3:optional contract_standard.TechPlatform techPlatform;
	4:optional string techPlatformCommodityType;
	5:optional i64 createTimestamp;
	6:optional i64 lastModifyTimestamp;
}

struct ReqSledExchangeMappingOption{
	1:optional set<i32> mappingIds;
	2:optional string sledExchangeMic;
	3:optional contract_standard.TechPlatform techPlatform;
	4:optional string techPlatformExchangeCode;
	5:optional page.IndexedPageOption pageOption;
}

struct ReqSledCommodityTypeMappingOption{
	1:optional set<i32> mappingIds;
	2:optional contract_standard.SledCommodityType sledCommodityType;
	3:optional contract_standard.TechPlatform techPlatform;
	4:optional string techPlatformCommodityType;
	5:optional page.IndexedPageOption pageOption;
}

struct SledExchangeMappingPage{
	1:optional i32 total;
	2:optional list<SledExchangeMapping> page;
}

struct SledCommodityTypeMappingPage{
	1:optional i32 total;
	2:optional list<SledCommodityTypeMapping> page;
}

struct CommoditySource{
	1:optional i32 sourceId;
	2:optional list<string> exchangeMic;
	3:optional contract_standard.TechPlatform techPlatformSource;
	4:optional contract_standard.TechPlatformEnv techPlatformEnv;
	25:optional i64 createTimestamp;
	26:optional i64 lastModifyTimestamp;
}

/**
  * 账号接入的状态
  */
enum AccountAccessState {
	NONE = 0,									// 	初始化状态
	ACCOUNT_ACTIVE = 1,                         //  账号活跃可使用
	ACCOUNT_INVALID = 2,                        //  账号无效，接入出现问题
}

struct CommoditySourceAccount{
	1:optional i32 accountId;
	2:optional contract_standard.TechPlatform techPlatform;
	3:optional contract_standard.TechPlatformEnv techPlatformEnv;
	4:optional string accountName;
	5:optional string accountpwd;
	6:optional i32 brokerEntryId;
	7:optional i32 brokerAccessId;
	10:optional map<string,string> accountProperties;
	11:optional AccountAccessState accessState;
    12:optional string invalidReason;       // 账号不可用原因
    14:optional i32 apiRetCode;         	// 接入API返回的错误码
    16:optional string ipAddress;
    17:optional i32 port;
	
	25:optional i64 createTimestamp;
	26:optional i64 lastModifyTimestamp;
}

struct CommoditySourcePage{
	1:optional i32 total;
	2:optional list<CommoditySource> page;
}

struct CommoditySourceAccountPage{
	1:optional i32 total;
	2:optional list<CommoditySourceAccount> page;
}

struct ReqCommoditySourceAccountOption{
	1:optional set<i32> accountIds;
	5:optional page.IndexedPageOption pageOption;
}

struct ReqCommoditySourceOption{
	1:optional set<i32> sourceIds;
	5:optional page.IndexedPageOption pageOption;
}
