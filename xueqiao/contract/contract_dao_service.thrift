namespace java com.longsheng.xueqiao.contract.dao.thriftapi
namespace cpp xueqiao.contract.dao

include "../../comm.thrift"
include "contract.thrift"
include "../../page.thrift"

struct TSledCommodity{
	1:optional i32 sledCommodityId;
	2:optional string exchangeMic;
	3:optional i32 sledCommodityType;
	4:optional string sledCommodityCode;
	5:optional list<i32> relateCommodityIds;
	7:optional string tradeCurrency;
	8:optional double contractSize;						// 合约每手乘数
	9:optional double tickSize;							// 最小变动价位
	10:optional i32 denominator;						// 报价分母
	11:optional i32 cmbDirect;					// 组合方向
	15:optional i32 commodityState;			// 商品状态

	16:optional string zoneId;
	23:optional string engName;
	24:optional string cnName;
	25:optional string tcName;
	26:optional string engAcronym;						// 英文简称
	27:optional string cnAcronym;						// 中文简称
	28:optional string tcAcronym;						// 繁体简称
	30:optional list<string> sledCommodityConfig;
	31:optional i64 activeStartTimestamp;
	32:optional i64 activeEndTimestamp;
	33:optional bool isAlsoSupportSim;
	40:optional i32 editstatus;
	41:optional i32 workingStatus;
	42:optional i64 createTimestamp;					// 创建时间
	43:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TSledExchange{
	1:optional i32 sledExchangeId;						
	2:optional string exchangeMic;						
	3:optional string country;							
	4:optional string countryCode;						
	5:optional string operatingMic;						
	6:optional i32 operatingMicType;					
	7:optional string nameInstitution;					
	8:optional string acronym;							
	9:optional string city;								
	10:optional string website;
	13:optional string cnName;
	14:optional string cnAcronym;
	16:optional string zoneId;
	17:optional i64 timeLagMs;
	31:optional i64 activeStartTimestamp;
	32:optional i64 activeEndTimestamp;
	42:optional i64 createTimestamp;					// 创建时间
	43:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TSledExchangePage{
	1:optional i32 total;
	2:optional list<TSledExchange> page;
}

struct TSledContract{
	1:optional i32 sledContractId;
	2:optional i32 sledCommodityId;
	3:optional string sledContractCode;	
	4:optional list<i32> relateContractIds;
	5:optional i32 techPlatformEnv;
	6:optional string sledTag;	
	7:optional string engName;
	8:optional string cnName;
	9:optional string tcName;
	10:optional i64 contractExpDate;		
	11:optional i64 lastTradeDate;		
	12:optional i64 firstNoticeDate;		
	13:optional i32 contractStatus;
	14:optional i32 editstatus;
	15:optional i32 workingStatus;
	22:optional i32 subscribeXQQuote;					// 是否订阅了雪橇行情 false = 0, true = 1(2019-03-07新加字段)
	31:optional i64 activeStartTimestamp;
	32:optional i64 activeEndTimestamp;
	42:optional i64 createTimestamp;					// 创建时间
	43:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TCommodityMap{
	1:optional i32 mapId;
	3:optional i32 sledCommodityId;
	4:optional i32 techPlatform;
	5:optional string exchange;
	6:optional string commodityType;
	7:optional string commodityCode;
	9:optional double moneyRatio;
	10:optional i32 brokerEntryId;
	14:optional i32 editstatus;
	15:optional i32 workingStatus;
	31:optional i64 activeStartTimestamp;
	32:optional i64 activeEndTimestamp;
	42:optional i64 createTimestamp;					// 创建时间
	43:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TCommodityMapFileInfo{
	1:optional binary commodityMapFile;				// 映射文件
	2:optional i32 techPlatform; 					// 映射对应的技术平台
	3:optional i32 brokerEntryId;					// 券商接入实体的id
	4:optional string fileMD5;
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TCommodityMapPage{
	1:optional i32 total;
	2:optional list<TCommodityMap> page;
}

struct ReqTCommodityMapOption{
	1:optional list<i32> mapIds;
	2:optional list<i32> sledCommodityIds;
	4:optional i32 platform;
	5:optional string exchange;
	6:optional string commodityType;
	7:optional string commodityCode;
	9:optional i32 brokerEntryId;
	14:optional i32 editstatus;
	15:optional i32 workingStatus;
}

struct ReqTSledCommodityOption{
	1:optional list<i32> sledCommodityIds;
	2:optional string exchangeMic;
	3:optional i32 sledCommodityType;
	4:optional string sledCommodityCode;
	5:optional bool isSim;
	14:optional i32 editstatus;
	15:optional i32 workingStatus;

	// 以下字段使用逻辑或模糊查询
	20:optional string sledCommodityCodePartical;
	22:optional string engNamePartical;
	23:optional string cnNamePartical;
}

struct ReqTSledContractOption{
	1:optional i32 sledCommodityId;
	2:optional string sledContractCode;
	5:optional i32 techPlatformEnv;
	6:optional list<i32> sledContractIds;
	7:optional i32 contractStatus;
	14:optional i32 editStatus;
	15:optional i32 workingStatus;
	16:optional bool isSubscribeQuote;

	// 以下字段使用逻辑或模糊查询
	20:optional string contractCodePartical;
	21:optional string sledTagPartical;
	22:optional string contractEngNamePartical;
	23:optional string contractCnNamePartical;
}

struct TSledContractPage{
	1:optional i32 total;
	2:optional list<TSledContract> page;
}

struct ReqTSledExchangeOption{
	1:optional list<i32> sledExchangeIds;
	2:optional string exchangeMic;

	// 以下字段使用逻辑或模糊查询
	20:optional string exchangeMicPartical;
	21:optional string nameInstitutionPartical;
	22:optional string acronymPartical;
	23:optional string cnAcronymPartical;
	24:optional string cnNamePartical;
}

struct TCommodityPage{
	1:optional i32 total;
	2:optional list<TSledCommodity> page;
}

struct TSledCommodityChange{
	1:optional i32 sledCommodityId;
	42:optional i64 createTimestamp;					// 创建时间
	43:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct TSledCommodityChangePage{
	1:optional i32 total;
	2:optional list<TSledCommodityChange> page;
}

struct ReqTSledCommodityChangeOption{
	1:optional list<i32> sledCommodityIds;
}

struct RemoveSledCommodityOption{
	1:optional i32 sledCommodityId;
	2:optional list<i32> brokerEntryIds;
}

struct RemoveSledExchangeOption{
	1:optional i32 sledExchangeId;
}

service(251) ContractDaoService {

	/**
	  * 添加sled_commodity记录
	  * 返回sled_commodity_id
	  */
	i32 1:addTSledCommodity(1:comm.PlatformArgs platformArgs, 2:TSledCommodity tSledCommodity) throws (1:comm.ErrorInfo err);

	/**
	  * 更新sled_commodity记录
	  * 返回sled_commodity_id
	  */
	i32 2:updateTSledCommodity(1:comm.PlatformArgs platformArgs, 2:TSledCommodity tSledCommodity) throws (1:comm.ErrorInfo err);

	TCommodityPage 3:reqTSledCommodity(1:comm.PlatformArgs platformArgs, 2:ReqTSledCommodityOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 添加sled_contract记录
	  * 返回sled_contract_id
	  */
	i32 4:addTSledContract(1:comm.PlatformArgs platformArgs, 2:TSledContract tSledContract) throws (1:comm.ErrorInfo err);

	/**
	  * 更新sled_contract记录
	  * 返回sled_contract_id
	  */
	i32 5:updateTSledContract(1:comm.PlatformArgs platformArgs, 2:TSledContract tSledContract) throws (1:comm.ErrorInfo err);

	TSledContractPage 6:reqTSledContract(1:comm.PlatformArgs platformArgs, 2:ReqTSledContractOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 添加sled_exchange记录
	  * 返回sled_exchange_id
	  */
	i32 7:addTSledExchange(1:comm.PlatformArgs platformArgs, 2:TSledExchange tSledExchange) throws (1:comm.ErrorInfo err);

	/**
	  * 更新sled_exchange记录
	  * 返回sled_exchange_id
	  */
	i32 8:updateTSledExchange(1:comm.PlatformArgs platformArgs, 2:TSledExchange tSledExchange) throws (1:comm.ErrorInfo err);

	TSledExchangePage 9:reqTSledExchange(1:comm.PlatformArgs platformArgs, 2:ReqTSledExchangeOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);



	TCommodityMapPage 12:reqTCommodityMap(1:comm.PlatformArgs platformArgs, 2:ReqTCommodityMapOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	void 14:addTCommodityMap(1:comm.PlatformArgs platformArgs,2:TCommodityMap tCommodityMap) throws (1:comm.ErrorInfo err);

	void 15:addSledExchangeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledExchangeMapping sledExchangeMapping) throws (1:comm.ErrorInfo err);
	void 16:updateSledExchangeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledExchangeMapping sledExchangeMapping) throws (1:comm.ErrorInfo err);
	contract.SledExchangeMappingPage 17:reqSledExchangeMapping(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledExchangeMappingOption option) throws (1:comm.ErrorInfo err);

	void 18:addSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledCommodityTypeMapping sledCommodityTypeMapping) throws (1:comm.ErrorInfo err);
	void 19:updateSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledCommodityTypeMapping sledCommodityTypeMapping) throws (1:comm.ErrorInfo err);
	contract.SledCommodityTypeMappingPage 20:reqSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledCommodityTypeMappingOption option) throws (1:comm.ErrorInfo err);

	i32 21:updateTCommodityMap(1:comm.PlatformArgs platformArgs,2:TCommodityMap tCommodityMap) throws (1:comm.ErrorInfo err);

	bool 22:inactiveExpiredSledContract(1:comm.PlatformArgs platformArgs,2:i64 expiredTimestamp) throws (1:comm.ErrorInfo err);

	TSledCommodityChangePage 23:reqTSledCommodityChange(1:comm.PlatformArgs platformArgs,2:ReqTSledCommodityChangeOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	i32 24:addTSledCommodityChange(1:comm.PlatformArgs platformArgs,2:TSledCommodityChange tCommodityChange) throws (1:comm.ErrorInfo err);

	bool 25:removeTSledCommodityChange(1:comm.PlatformArgs platformArgs,2:TSledCommodityChange tCommodityChange) throws (1:comm.ErrorInfo err);

	void 26:addCommodityMapFileInfo(1:comm.PlatformArgs platformArgs,2:contract.CommodityMapFileInfo mapFileInfo) throws (1:comm.ErrorInfo err);
	void 27:updateCommodityMapFileInfo(1:comm.PlatformArgs platformArgs,2:contract.CommodityMapFileInfo mapFileInfo) throws (1:comm.ErrorInfo err);
	contract.CommodityMapFileInfoPage 28:reqCommodityMapFileInfo(1:comm.PlatformArgs platformArgs,2:contract.ReqCommodityMapFileInfoOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);


	// 同步接口
	contract.SyncMappingTaskPage 32:reqSyncMappingTask(1:comm.PlatformArgs platformArgs, 2:contract.ReqSyncMappingTaskOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
  
	void 34:addSyncMappingTask(1:comm.PlatformArgs platformArgs, 2:contract.SyncMappingTask tTask) throws (1:comm.ErrorInfo err);
 
	void 35:removeSyncMappingTask(1:comm.PlatformArgs platformArgs, 2:contract.ReqSyncMappingTaskOption option) throws (1:comm.ErrorInfo err);
 
	/**
	  * 查询最新的合约版本信息
	  * 返回合约版本信息
	  */
	//TContractVersionPage 36:reqTContractVersion(1:comm.PlatformArgs platformArgs, 2:ReqTContractVersionOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
 
	//i32 37:addTContractVersion(1:comm.PlatformArgs platformArgs, 2:TContractVersion tContractVersion) throws (1:comm.ErrorInfo err);
 
	/**
	  * 根据versionId更新合约版本信息
	  * 返回合约版本信息
	  */
	//i32 38:updateTContractVersion(1:comm.PlatformArgs platformArgs, 2:TContractVersion tContractVersion) throws (1:comm.ErrorInfo err);
 
	/**
	  * 删除versionId对应的合约版本信息
	  * 
	  */
	//void 39:removeTContractVersion(1:comm.PlatformArgs platformArgs, 2:i32 versionId) throws (1:comm.ErrorInfo err);
 
	void 40:addTechPlatformCommodity(1:comm.PlatformArgs platformArgs, 2:contract.TechPlatformCommodity techPlatformCommodity)throws (1:comm.ErrorInfo err);

	contract.TechPlatformCommodityPage 41:reqTechPlatformCommodity(1:comm.PlatformArgs platformArgs, 2:contract.ReqTechPlatformCommodityOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 42:removeSledCommodity(1:comm.PlatformArgs platformArgs, 2:RemoveSledCommodityOption removeOption)throws (1:comm.ErrorInfo err);

	void 43:removeSledExchange(1:comm.PlatformArgs platformArgs, 2:RemoveSledExchangeOption removeOption)throws (1:comm.ErrorInfo err);

	void 44:addContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.ContractVersion contractVersion)throws (1:comm.ErrorInfo err);

	void 45:removeContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.RemoveContractVersionOption removeOption)throws (1:comm.ErrorInfo err);

	contract.ContractVersionPage 46:reqContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.ReqContractVersionOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 47:updateContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.ContractVersion contractVersion)throws (1:comm.ErrorInfo err);

	void 50:addDbLocking(1:comm.PlatformArgs platformArgs, 2:contract.DbLockingInfo dbLockingInfo)throws (1:comm.ErrorInfo err);

	void 51:removeDbLocking(1:comm.PlatformArgs platformArgs, 2:string lockedBy)throws (1:comm.ErrorInfo err);

	contract.DbLockingInfo 52:reqDbLockingInfo(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);

	//****** 交易时间接口 ******
	void 60:addSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.SledTradeTimeConfig config)throws (1:comm.ErrorInfo err);

	void 61:updateSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.SledTradeTimeConfig config)throws (1:comm.ErrorInfo err);

	contract.SledTradeTimeConfigPage 62:reqSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradeTimeConfigOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 63:addSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.SpecTradeTime specTradeTime)throws (1:comm.ErrorInfo err);

	void 64:updateSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.SpecTradeTime specTradeTime)throws (1:comm.ErrorInfo err);

	contract.SpecTradeTimePage 65:reqSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqSpecTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	contract.SledCommoditySpecTradeTimePage 66:reqSledCommoditySpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySpecTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	contract.SledTradeTimePage 67:reqSledTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 68:batAddSledTradeTime(1:comm.PlatformArgs platformArgs, 2:list<contract.SledTradeTime> sledTradeTimes)throws (1:comm.ErrorInfo err);

	void 69:addDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.DstTransferConfig transferConfig)throws (1:comm.ErrorInfo err);

	void 70:updateDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.DstTransferConfig transferConfig)throws (1:comm.ErrorInfo err);

	contract.DstTransferConfigPage 71:reqDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.ReqDstTransferConfigOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 72:removeSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.RemoveSpecTradeTimeOption removeOption)throws (1:comm.ErrorInfo err);

	void 73:removeDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.RemoveDstTransferConfigOption removeOption)throws (1:comm.ErrorInfo err);

	void 74:batUpdateSledTradeTimeConfigs(1:comm.PlatformArgs platformArgs, 2:list<contract.SledTradeTimeConfig> configs)throws (1:comm.ErrorInfo err);

	void 75:addCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySource commoditySource)throws (1:comm.ErrorInfo err);

	void 76:updateCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySource commoditySource)throws (1:comm.ErrorInfo err);

	contract.CommoditySourcePage 77:reqCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySourceOption option)throws (1:comm.ErrorInfo err);

	void 78:addCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySourceAccount commoditySourceAccount)throws (1:comm.ErrorInfo err);

	void 79:updateCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySourceAccount commoditySourceAccount)throws (1:comm.ErrorInfo err);

	contract.CommoditySourceAccountPage 80:reqCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySourceAccountOption option)throws (1:comm.ErrorInfo err);

	//******trading session 的时间接口 ******
	void 81:addSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.SledTradingSession sledTradingSession)throws (1:comm.ErrorInfo err);

	void 82:updateSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.SledTradingSession sledTradingSession)throws (1:comm.ErrorInfo err);

	contract.SledTradingSessionPage 83:reqSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradingSessionOption option, 3:page.IndexedPageOption pageOption)throws (1:comm.ErrorInfo err);

	void 84:removeSledTradingSession(1:comm.PlatformArgs platformArgs, 2:i64 tradeSessionId)throws (1:comm.ErrorInfo err);

	void 85:clearAllTechPlatformCommodity(1:comm.PlatformArgs platformArgs, 2:i32 techPlatformValue)throws (1:comm.ErrorInfo err);
}