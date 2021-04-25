namespace java xueqiao.quotation.account.thriftapi
namespace py xueqiao.quotation.account.thriftapi.dao

include "../../comm.thrift"
include "../../page.thrift"
include "quotation_account.thrift"
/**
  * 管理行情账号与合约订阅规则dao
  */
service(891) QuotationAccountDao {

	/**
	  * 查询活跃合约规律
	  */
	quotation_account.ContractActiveRulePage 1:reqContractActiveRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ReqContractActiveRuleOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);


	/**
	  * 查询合约订阅规则
	  */
	quotation_account.ContractRegisterRulePage 2:reqContractRegisterRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ReqContractRegisterRuleOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 查询行情账号
	  */
	quotation_account.QuotationAccountPage 3:reqQuotationAccount(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ReqQuotationAccountOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 添加活跃合约规律
	  */
	void 4:addContractActiveRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ContractActiveRule rule) throws (1:comm.ErrorInfo err);

	/**
	  * 添加订阅合约规则
	  */
	void 5:addContractRegisterRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ContractRegisterRule rule) throws (1:comm.ErrorInfo err);

	/**
	  * 添加行情账号信息
	  */
	i64 6:addQuotationAccount(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.QuotationAccount account) throws (1:comm.ErrorInfo err);

	/**
	  * 修改活跃合约规律
	  */
	void 7:updateContractActiveRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ContractActiveRule rule) throws (1:comm.ErrorInfo err);

	/**
	  * 修改订阅合约规则
	  */
	void 8:updateContractRegisterRule(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.ContractRegisterRule rule) throws (1:comm.ErrorInfo err);

	/**
	  * 修改行情账号信息
	  */
	void 9:updateQuotationAccount(
		1:comm.PlatformArgs platformArgs, 2: quotation_account.QuotationAccount account) throws (1:comm.ErrorInfo err);

	/**
	  * 删除活跃合约规律
	  */
	void 10:removeContractActiveRule(
		1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId,3:quotation_account.ContractActiveType activeType, 4:string fixedCode ) throws (1:comm.ErrorInfo err);

	/**
	  * 删除订阅合约规则
	  */
	void 11:removeContractRegisterRule(
		1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:quotation_account.QuotationPlatformEnv platformEnv, 4:quotation_account.ContractActiveType activeType, 5:string fixedCode) throws (1:comm.ErrorInfo err);

	/**
	  * 删除行情账号信息
	  */
	void 12:removeQuotationAccount(
		1:comm.PlatformArgs platformArgs, 2:i64 accountId) throws (1:comm.ErrorInfo err);
	
	/**
	  * 查询行情账号的订阅能力信息
	  */
	quotation_account.AccountCommodityRegisterAbilityPage 14:reqAccountCommodityRegisterAbility(1:comm.PlatformArgs platformArgs, 2:quotation_account.ReqAccountCommodityRegisterAbilityOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	void 15:addAccountCommodityRegisterAbility(1:comm.PlatformArgs platformArgs, 2:quotation_account.AccountCommodityRegisterAbility ability) throws (1:comm.ErrorInfo err);

	void 16:removeAccountCommodityRegisterAbility(1:comm.PlatformArgs platformArgs, 2:i64 supportAbilityId) throws (1:comm.ErrorInfo err);

	void 17:batAddAccountCommodityRegisterAbility(1:comm.PlatformArgs platformArgs, 2:list<quotation_account.AccountCommodityRegisterAbility> abilities) throws (1:comm.ErrorInfo err);

	void 19:removeAccountCommodityRegisterAbilities(1:comm.PlatformArgs platformArgs, 2:i64 accountId, 3:i32 sledExchangeId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询行情账号支持订阅的情况
	  */
	quotation_account.QuotationAccountSupportPage 18:reqQuotationAccountSupport(1:comm.PlatformArgs platformArgs, 2: quotation_account.ReqQuotationAccountSupportOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);


	/**
	  * 设置订阅商品排序
	  */
	void 21:setCommodityRegisterOrderIndex(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:quotation_account.QuotationPlatformEnv platformEnv, 4:i32 orderIndex, 5:quotation_account.ContractActiveType activeType, 6:string fixedCode) throws (1:comm.ErrorInfo err);


	//****** 添加更新合约订阅标记的任务 2019-03-07******
	/**
	  * 设置行情订阅变化的通知
	  */
	void 50:notifySubscribeQuoteStateChange(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);

	/**
	  * 查询最新行情订阅变更任务
	  */
	quotation_account.SubcribeQuoteStateTask 51:reqLatestSQSTask(1:comm.PlatformArgs platformArgs)throws (1:comm.ErrorInfo err);
	
	/**
	  * 移除当前任务和更早的行情订阅变更任务
	  */
	void 52:removeEarlySQSTask(1:comm.PlatformArgs platformArgs, i64 taskId)throws (1:comm.ErrorInfo err);
}