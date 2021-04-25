namespace java com.longsheng.xueqiao.contract.online.dao.thriftapi
namespace csharp xueqiao.contract.online
namespace cpp xueqiao.contract.online.dao

include "../../comm.thrift"
include "contract_standard.thrift"
include "contract.thrift"

/**
  * 雪橇线上合约查询服务
  * 
  */
service(253) ContractOnlineDaoService {

	/**
	  * 
	  * 查询雪橇合约详细
	  * 返回雪橇合约详细
	  */
	contract_standard.SledContractPage 1:reqSledContract(1:comm.PlatformArgs platformArgs, 2:contract_standard.ReqSledContractOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 
	  * 查询雪橇合约聚合详细
	  * 返回雪橇合约聚合详细
	  * 默认最大返回数pageSize = 50
	  */
	contract_standard.SledContractDetailsPage 2:reqSledContractDetail(1:comm.PlatformArgs platformArgs, 2:contract_standard.ReqSledContractDetailsOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 根据 option 查询雪橇商品映射
	  * 返回商品映射信息
	  */
	contract_standard.CommodityMappingPage 11:reqCommodityMapping(1:comm.PlatformArgs platformArgs, 2:contract_standard.ReqCommodityMappingOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 查询雪橇交易所
	  * 分页返回交易所信息
	  */
	contract_standard.SledExchangePage 20:reqSledExchange(1:comm.PlatformArgs platformArgs, 3:contract_standard.ReqSledExchangeOption option, 4:i32 pageIndex, 5:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 根据 option 查询雪橇商品
	  * 分页返回雪橇商品信息
	  */
	contract_standard.SledCommodityPage 30:reqSledCommodity(1:comm.PlatformArgs platformArgs, 3:contract_standard.ReqSledCommodityOption option, 4:i32 pageIndex, 5:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 查询最新的合约版本信息
	  * 返回合约版本信息
	  */
	contract.ContractVersionPage 40:reqContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.ReqContractVersionOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

	/**
	  * 根据versionId更新合约版本信息
	  * 返回合约版本信息
	  */
	void 42:updateContractVersion(1:comm.PlatformArgs platformArgs, 2:contract.ContractVersion contractVersion) throws (1:comm.ErrorInfo err);

	/**
	  * 删除versionId对应的合约版本信息
	  * 
	  */
	void 43:removeContractVersion(1:comm.PlatformArgs platformArgs, 2:i32 versionId) throws (1:comm.ErrorInfo err);

	void 50:addDbLocking(1:comm.PlatformArgs platformArgs, 2:contract.DbLockingInfo dbLockingInfo)throws (1:comm.ErrorInfo err);

	void 51:removeDbLocking(1:comm.PlatformArgs platformArgs, 2:string lockedBy)throws (1:comm.ErrorInfo err);

	contract.DbLockingInfo 52:reqDbLockingInfo(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);

	contract.SledTradeTimePage 67:reqSledTradeTime(1:comm.PlatformArgs platformArgs, 2:contract.ReqSledTradeTimeOption option, 3:i32 pageIndex, 4:i32 pageSize)throws (1:comm.ErrorInfo err);
}



