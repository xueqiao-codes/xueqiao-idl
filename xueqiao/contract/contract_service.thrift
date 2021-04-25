namespace java com.longsheng.xueqiao.contract.thriftapi
namespace cpp xueqiao.contract.service

include "../../comm.thrift"
include "contract_standard.thrift"
include "contract.thrift"
include "../../page.thrift"

// 编辑状态
enum EditStatus{
	NEW = 0,					// 新增
	EDIT = 1,					// 编辑中
	VERIFIED_CORRECT = 2,		// 已验证
	SYNCHRONIZED = 3,			// 已同步
}

// 使用状态
enum WorkingStatus{
	NOT_WORKING = 0,			// 尚未使用
	WORKING =1,					// 使用中
}

struct SledCommodityEdit{
	1:optional contract_standard.SledCommodity sledCommodity;
	2:optional EditStatus editStatus;
	3:optional WorkingStatus workingStatus;
}

struct SledContractEdit{
	1:optional contract_standard.SledContract sledContract;
	2:optional EditStatus editStatus;
	3:optional WorkingStatus workingStatus;
}

struct CommodityMappingEdit{
	1:optional contract_standard.CommodityMapping commodityMapping;
	2:optional EditStatus editStatus;
	3:optional WorkingStatus workingStatus;
}

struct SledCommodityEditPage{
	1:optional i32 total;
	2:optional list<SledCommodityEdit> page  
}

struct SledContractEditPage{
	1:optional i32 total;
	2:optional list<SledContractEdit> page
}

struct CommodityMappingEditPage{
	1:optional i32 total;
	2:optional list<CommodityMappingEdit> page;
}

struct ReqCommodityMappingEditOption{
	1:optional list<i32> sledCommodityIdList;
	2:optional string exchange;						// 券商交易所代号
	3:optional string commodityType;				// 券商商品类型
	4:optional string commodityCode;				// 券商商品代号
	5:optional i32 brokerEntryId;					// 券商实体的id
	6:optional list<i32> mapIds;
	7:optional contract_standard.TechPlatform techPlatform;
	8:optional EditStatus editStatus;
	9:optional WorkingStatus workingStatus;
}

struct LinkCommodityMappingInfo{
	1:optional i32 sledCommodityId;
	2:optional contract_standard.TechPlatform techPlatform;  // 映射对应的技术平台
}

struct LinkCommodityMappingResp{
	1:optional bool success;
}

struct ImportCommodityMapResp{
	1:optional bool complete;
	2:optional list<string> existMapping;
	3:optional list<string> conflictMapping;
	4:optional list<string> addMapping;
}

enum ContractManageErrorCode{
	MAP_FILE_READ_FAIL= 2001,
	MAP_FILE_MD5_ERROR = 2002,
	DATA_FORMAT_ERROR = 2003,
	PLATFORM_COMMODITY_NOT_FOUND = 2004,
	PLATFORM_COMMODITY_MORE_THAN_ONE = 2005,
	PLATFORM_NOT_SUPPORT = 2006,
	PLATFORM_COMMODITY_PROPERTY_ERROR = 2007,
	SLED_COMMODITY_NO_DELETE = 2008,
	SLED_COMMODITY_WORKING_STATUS_ERROR= 2009,
	DATABASE_LOCKED = 2010,
	DATABASE_LOCKED_BY_OTHER =2011,
	SLED_COMMODITY_NOT_VERIFY = 2012,
	SLED_COMMODITY_TRADE_TIME_NOT_SET = 2013,
	ZONE_ID_ERROR = 2014,
	SLED_COMMODITY_DST_CONFIG_EXISTS = 2015,
	SLED_COMMODITY_NOT_WORKING = 2016,
	SLED_EXCHANGE_MAPPING_EXISTS = 2017,
	SLED_COMMODITY_TYPE_MAPPING_EXISTS = 2018,
	SLED_EXCHANGE_SOURCE_EXISTS = 2019,
	SOURCE_ACCOUNT_IP_PORT_EXISTS = 2020,
	SLED_EXCHANGE_SOURCE_NOT_FOUND = 2021,
}


struct ActiveCommodityResp{
	1:optional bool success;

}

struct SyncCommodityConfigResp{
	1:optional bool success;
}

struct RemoveCommodityResp{
	1:optional bool success;
}

struct RemoveSledExchangeResp{
	1:optional bool success;
}

struct SledCommodityStateChangeResp{
	1:optional bool success;
}

struct SyncContractOption{
	1:optional string userName;
}
struct SyncContractResp{
	1:optional bool success;
}

struct SyncTradeTimeResp{
	1:optional bool success;
}

struct VerifyCommodityResp{
	1:optional bool success;
}

/**
  * 雪橇统一商品合约管理服务
  * 包括交易所，商品，合约的导入添加修改，同步等业务需求
  */
service(252) ContractService {

	/**
	  * 
	  * 查询雪橇合约详细
	  * 返回雪橇合约详细
	  */
	SledContractEditPage 2:reqSledContractDetail(1:comm.PlatformArgs platformArgs, 2:contract_standard.ReqSledContractOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 
	  * 更新合约状态
	  * 
	  */
	void 3:updateSledContractStatus(1:comm.PlatformArgs platformArgs, 2:set<i32> sledContractIds, 3:contract_standard.ContractStatus newContractStatus) throws (1:comm.ErrorInfo err);

	/**
	  * 根据 option 查询雪橇商品
	  * 分页返回雪橇商品信息
	  */
	SledCommodityEditPage 6:reqSledCommodity(1:comm.PlatformArgs platformArgs, 3:contract_standard.ReqSledCommodityOption option, 4:i32 pageIndex, 5:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 查询雪橇交易所
	  * 分页返回交易所信息
	  */
	contract_standard.SledExchangePage 7:reqSledExchange(1:comm.PlatformArgs platformArgs, 3:contract_standard.ReqSledExchangeOption option, 4:i32 pageIndex, 5:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 添加雪橇商品代号映射
	  * 
	  */
	CommodityMappingEdit 8:addCommodityMapping(1:comm.PlatformArgs platformArgs, 2:contract_standard.CommodityMapping commodityMapping) throws (1:comm.ErrorInfo err);

	contract_standard.SledExchange 9:addSledExchange(1:comm.PlatformArgs platformArgs, 3:contract_standard.SledExchange sledExchange) throws (1:comm.ErrorInfo err);

	/**
	  * 根据 option 查询雪橇商品映射
	  * 返回商品映射信息
	  */
	CommodityMappingEditPage 10:reqCommodityMapping(1:comm.PlatformArgs platformArgs, 2:ReqCommodityMappingEditOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	SledCommodityEdit 11:addSledCommodity(1:comm.PlatformArgs platformArgs, 3:contract_standard.SledCommodity sledCommodity, 4:string mappingCode) throws (1:comm.ErrorInfo err);

	contract_standard.SledExchange 12:updateSledExchange(1:comm.PlatformArgs platformArgs, 3:contract_standard.SledExchange sledExchange) throws (1:comm.ErrorInfo err);

	SledCommodityEdit 13:updateSledCommodity(1:comm.PlatformArgs platformArgs, 3:contract_standard.SledCommodity sledCommodity) throws (1:comm.ErrorInfo err);

	CommodityMappingEdit 14:updateCommodityMapping(1:comm.PlatformArgs platformArgs, 2:contract_standard.CommodityMapping commodityMapping) throws (1:comm.ErrorInfo err);

	void 15:addSledExchangeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledExchangeMapping sledExchangeMapping) throws (1:comm.ErrorInfo err);
	void 16:updateSledExchangeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledExchangeMapping sledExchangeMapping) throws (1:comm.ErrorInfo err);
	contract.SledExchangeMappingPage 17:reqSledExchangeMapping(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledExchangeMappingOption option) throws (1:comm.ErrorInfo err);

	void 18:addSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledCommodityTypeMapping sledCommodityTypeMapping) throws (1:comm.ErrorInfo err);
	void 19:updateSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 3:contract.SledCommodityTypeMapping sledCommodityTypeMapping) throws (1:comm.ErrorInfo err);
	contract.SledCommodityTypeMappingPage 20:reqSledCommodityTypeMapping(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledCommodityTypeMappingOption option) throws (1:comm.ErrorInfo err);

	/**
 	 * 以下接口主要根据业务提供:
	 * 导入和管理雪橇商品映射的业务接口
	 * 包括文件导入和指定商品导入, 创建并保存映射,导入对应合约
 	 */
 	ImportCommodityMapResp 30:importCommodityMapFile(1:comm.PlatformArgs platformArgs, 2:contract.CommodityMapFileInfo mapFileInfo) throws (1:comm.ErrorInfo err);

 	contract.CommodityMapFileInfoPage 31:reqCommodityMapFileInfo(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommodityMapFileInfoOption option, 3:i32 pageIndex, 4:i32 pageSize ) throws (1:comm.ErrorInfo err);

 	LinkCommodityMappingResp 32:linkTechPlatformMapping(1:comm.PlatformArgs platformArgs, 2:LinkCommodityMappingInfo linkCommodityMappingInfo) throws (1:comm.ErrorInfo err);

 	contract.TechPlatformCommodityPage 33:reqTechPlatformCommodity(1:comm.PlatformArgs platformArgs, 2:contract.ReqTechPlatformCommodityOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

 	// 保存商品源数据
 	void 34:addTechPlatformCommodity(1:comm.PlatformArgs platformArgs, 2:contract.TechPlatformCommodity techPlatformCommodity)throws (1:comm.ErrorInfo err);

 	// 启用时需要验证一系列上线要求
 	ActiveCommodityResp 35:activeSledCommodity(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId)throws (1:comm.ErrorInfo err);

 	// 启用时需要验证一系列上线要求
 	VerifyCommodityResp 36:verifySledCommodity(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId)throws (1:comm.ErrorInfo err);

 	// 只能在未启用前删除
	RemoveCommodityResp 37:removeSledCommodity(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId)throws (1:comm.ErrorInfo err);

	// 该交易所下不存在商品才可以删除
	RemoveSledExchangeResp 38:removeSledExchange(1:comm.PlatformArgs platformArgs, 2:i32 sledExchangeId)throws (1:comm.ErrorInfo err);

	SledCommodityStateChangeResp 39:changeSledCommodityState(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:contract_standard.CommodityState newState)throws (1:comm.ErrorInfo err);

	void 40:addDbLocking(1:comm.PlatformArgs platformArgs, 2:contract.DbLockingInfo dbLockingInfo)throws (1:comm.ErrorInfo err);

	void 41:removeDbLocking(1:comm.PlatformArgs platformArgs, 2:string lockedBy)throws (1:comm.ErrorInfo err);

	contract.DbLockingInfo 42:reqDbLockingInfo(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);

	SyncContractResp 43:syncContract(1:comm.PlatformArgs platformArgs, 2:SyncContractOption option)throws (1:comm.ErrorInfo err);

	void 44:removeCommodityMapFileInfo(1:comm.PlatformArgs platformArgs, 2:contract.RemoveCommodityMapFileInfoOption option) throws (1:comm.ErrorInfo err);

//****** 交易时间接口 ******
//****** 已废弃，使用trading session设计的交易时间 开始******
	void 60:addSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.SledTradeTimeConfig config)throws (1:comm.ErrorInfo err);

	void 61:updateSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.SledTradeTimeConfig config)throws (1:comm.ErrorInfo err);

	contract.SledTradeTimeConfigPage 62:reqSledTradeTimeConfig(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradeTimeConfigOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 69:addDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.DstTransferConfig transferConfig)throws (1:comm.ErrorInfo err);

	void 70:updateDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.DstTransferConfig transferConfig)throws (1:comm.ErrorInfo err);

	contract.DstTransferConfigPage 71:reqDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.ReqDstTransferConfigOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 73:removeDstTransferConfig(1:comm.PlatformArgs platformArgs, 2:contract.RemoveDstTransferConfigOption removeOption)throws (1:comm.ErrorInfo err);

//****** 已废弃，使用trading session设计的交易时间 结束******

	void 63:addSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.SpecTradeTime specTradeTime)throws (1:comm.ErrorInfo err);

	void 64:updateSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.SpecTradeTime specTradeTime)throws (1:comm.ErrorInfo err);

	contract.SpecTradeTimePage 65:reqSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqSpecTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	contract.SledCommoditySpecTradeTimePage 66:reqSledCommoditySpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySpecTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	SyncTradeTimeResp 67:syncTradeTime(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);

	contract.SledTradeTimePage 68:reqSledTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);

	void 72:removeSpecTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.RemoveSpecTradeTimeOption removeOption)throws (1:comm.ErrorInfo err);

	void 74:addCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySource commoditySource)throws (1:comm.ErrorInfo err);

	void 75:updateCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySource commoditySource)throws (1:comm.ErrorInfo err);

	contract.CommoditySourcePage 76:reqCommoditySource(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySourceOption option)throws (1:comm.ErrorInfo err);

	void 77:addCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySourceAccount commoditySourceAccount)throws (1:comm.ErrorInfo err);

	void 78:updateCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.CommoditySourceAccount commoditySourceAccount)throws (1:comm.ErrorInfo err);

	contract.CommoditySourceAccountPage 79:reqCommoditySourceAccount(1:comm.PlatformArgs platformArgs, 2:contract.ReqCommoditySourceAccountOption option)throws (1:comm.ErrorInfo err);

//******trading session 的时间接口 ******
	void 80:addSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.SledTradingSession sledTradingSession)throws (1:comm.ErrorInfo err);

	void 81:updateSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.SledTradingSession sledTradingSession)throws (1:comm.ErrorInfo err);

	contract.SledTradingSessionPage 82:reqSledTradingSession(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradingSessionOption option, 3:page.IndexedPageOption pageOption)throws (1:comm.ErrorInfo err);

	void 83:removeSledTradingSession(1:comm.PlatformArgs platformArgs, 2:i64 tradeSessionId)throws (1:comm.ErrorInfo err);
}