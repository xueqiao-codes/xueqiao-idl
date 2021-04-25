namespace java xueqiao.quotation.admin.web.api.thriftapi
namespace py xueqiao.quotation.admin.web.api.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "../contract/contract_standard.thrift"
include "../quotation/quotation_account.thrift"

struct CommodityActiveConfig{
	1:optional i32 sledCommodityId;
	2:optional string exchangeName;
	3:optional string commodityName;
	4:optional list<i32> activeMonths;

	5:optional quotation_account.ContractActiveType activeType;	// 活跃合约类型
	6:optional string fixedCode;				// 固定合约代号
}

struct CommodityActiveConfigPage{
	1:optional i32 total;
	2:optional list<CommodityActiveConfig> page;
}

struct ReqCommodityActiveConfigOption{
	1:optional string commodityNamePartical;
	2:optional i32 commodityId;
	3:optional quotation_account.ContractActiveType activeType;	// 活跃合约类型
}

struct CommodityRegister{
	1:optional i32 sledCommodityId;
	2:optional string exchangeName;
	3:optional string commodityName;
	4:optional i32 registerPriority;			// 订阅优先级
	5:optional i32 activeShowCount;				// 活跃合约展示数量
	6:optional i32 inactiveShowCount;			// 非活跃合约展示数量
	7:optional contract_standard.TechPlatformEnv platformEnv;// 行情环境: 实盘、模拟盘
	8:optional i32 orderIndex;					// 订阅次序

	9:optional quotation_account.ContractActiveType activeType;	// 活跃合约类型
	10:optional string fixedCode;				// 固定合约代号
}

struct CommodityRegisterPage{
	1:optional i32 total;
	2:optional list<CommodityRegister> page;
}

struct ReqCommodityRegisterOption{
	1:optional string commodityNamePartical;
	2:contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
}

struct QuotationAccountInfo{
	1:optional i64 accountId;
	2:optional string accountName;				// 登陆用户名
	3:optional string accountpwd;				// 登陆密码
	4:optional string nickName;					// 账号别名
	5:optional contract_standard.TechPlatform platform;	// 接入技术平台
	6:optional i32 brokerId;               		// 对接的券商ID
	7:optional i32 brokerAccessId;				// 券商接入id
	8:optional map<string,string> accountProperties; 		// 账户的扩展属性
	9:optional quotation_account.QuotationAccountState accountState;          // 账号本身状态

	10:optional quotation_account.QuotationAccountAccessState accessState; 	//账号接入状态
	11:optional string invalidReason;       		// 账号不可用原因
	12:optional i32 invalidErrorCode;      			// 不可用的原因, 内部定义的错误码
	13:optional i32 apiRetCode;         			// 接入API返回的错误码

    14:optional i32 maxRegisterCount;				// 最大订阅数量
	
	15:optional i64 createTimestamp;
	16:optional i64 lastModifyTimestamp;

	17:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘

	18:optional string brokerName;					// 券商名称
	19:optional string brokerAccessName;			// 席位

	20:optional quotation_account.DeploySet deploySet;				// 部署区域
}

struct QuotationAccountInfoPage{
	1:optional i32 total;
	2:optional list<QuotationAccountInfo> page;
}

struct ReqQuotationAccountInfoOption{
	1:optional i64 accountId;
	2:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
	3:optional string accountNamePartical;
	4:optional string accountNickNamePartical;
	5:optional string brokerNamePartical;
	6:optional string commodityNamePartical;

	7:optional contract_standard.TechPlatform platform;	// 接入技术平台 
	8:optional quotation_account.DeploySet deploySet;						// 部署区域
}

struct AccountRegisterAbility{
	1:optional i64 registerAbilityId;
	2:optional i64 accountId;
	3:optional i32 sledCommodityId;
	4:optional i32 sledExchangeId;
	5:optional quotation_account.SupportType supportType;
	6:optional string commodityName;
	7:optional string exchangeName;

}

struct CommodityRegisterAbility{
	1:optional i64 registerAbilityId;
	2:optional i64 accountId;
	3:optional i32 sledCommodityId;
	4:optional i32 sledExchangeId;
	6:optional string commodityName;
}

struct ExchangeRegisterAbility{
	1:optional i64 accountId;
	2:optional i32 sledExchangeId;
	4:optional quotation_account.SupportType supportType;
	5:optional string exchangeName;
	6:optional list<CommodityRegisterAbility> commodityAbilities;
}

struct ReqAccountRegisterAbilityOption{
	1:optional i64 accountId;
	2:optional i32 sledCommodityId;
	3:optional i32 sledExchangeId;

	4:optional string exchangeNamePartical;
	5:optional string commodityNamePartical;
	6:optional i64 registerAbilityId;
}

struct Tree{
	1:optional string name;
	2:optional string treeJson;
}

struct Item{
	1:optional string value;
	2:optional string label;
}

struct SubscribedContract{
	1:optional i64 accountId;
	2:optional i32 sledCommodityId;
	3:optional i32 sledContractId;
	4:optional bool isActiveMonth;
	5:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
	8:optional i32 sledExchangeId;
	9:optional string exchangeName;
	10:optional string commodityName;
	11:optional string accountName;
	12:optional string contractName;
	13:optional string sledExchangeMic;

	14:optional quotation_account.DeploySet deploySet;						// 部署区域
}

struct SubscribedContractPage{
	1:optional i32 total;
	2:optional list<SubscribedContract> page;
}

struct ReqSubscribedContractOption{
	1:optional string accountNamePartical;
	2:optional string commodityNamePartical;
	3:contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
	4:optional quotation_account.DeploySet deploySet;						// 部署区域
}

enum ContractTreeNodeType{
	EXCHANGE = 1,
	COMMODITY = 2,
	CONTRACT = 3,
}
 
struct ContractTreeNode{
	1:optional i32 id;				// sled exchange id, commodity id, contract id
	2:optional string code;			// sled exchange mic, commodity code, contract code
	3:optional string name;			// sled exchange name, commodity name, contract name
	4:optional ContractTreeNodeType nodeType;
	5:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
}

struct PreviewFields{
	1:optional string activeMonths;  // 活跃月份
    2:optional string inactiveMonths; // 非活跃月份
    3:optional i32 activeSubscribeNum;  // 活跃合约需要订阅的数量
    4:optional i32 inActiveSubscribeNum; // 非活跃合约订阅的数量
    5:optional i32 backupCounts;		// 备份数量
    6:optional string fixedCode;		// 固定合约编号
}

/**
  * 已规划订阅信息
  */
struct PlanningSubscribedInfo{
	1:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
	2:optional i32 sledExchangeId;
	3:optional i32 sledCommodityId;
	4:optional string exchangeName;
	5:optional string commodityName;
	6:optional PreviewFields fields;
}

/**
  * 重新规划预览
  */
struct RePlanSubscribedInfoPreview{
	1:optional contract_standard.TechPlatformEnv platformEnv; // 实盘、模拟盘
	2:optional i32 sledExchangeId;
	3:optional i32 sledCommodityId;
	4:optional string exchangeName;
	5:optional string commodityName;
	6:optional bool isCurrentSubcribe;
	7:optional bool isReplanSubcribe;

	8:optional PreviewFields rePlanFields;
	9:optional PreviewFields currentFields;

    10:optional bool isFieldsDifferent;
}

enum PreviewState{
	EMPTY = 0,
	GEN_TASK_RUNNING = 1,
	FINISH = 2,
	GEN_FAIL = 3,
}

struct RePlanSubscribedInfoPreviewPage{
	1:optional i32 total;
	2:optional list<RePlanSubscribedInfoPreview> page;
	3:optional PreviewState state;
	4:optional string stateMsg;
	5:optional i64 lastUpdateTimestampMs;
}

struct ReqRePlanSubscribedInfoPreviewOption{
	1:optional contract_standard.TechPlatformEnv platformEnv;
	2:optional string commodityNamePartical;
}

struct ReqPlanningSubscribedInfoOption{
	1:optional contract_standard.TechPlatformEnv platformEnv;
	2:optional string commodityNamePartical;	
}

/**
  * 雪橇行情管理后台web api
  */
service(893) QuotationAdminWebApi {

// ######################## 行情账号管理接口 开始 ########################
	// #### 活跃合约规律接口 ####
	/**
	  * 查询活跃合约配置信息
	  */
	CommodityActiveConfigPage 1:reqCommodityActiveConfig(1:comm.PlatformArgs platformArgs, 2:ReqCommodityActiveConfigOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	CommodityActiveConfig 2:updateCommodityActiveConfig(1:comm.PlatformArgs platformArgs, 2:CommodityActiveConfig activeConfig) throws (1:comm.ErrorInfo err);

	CommodityActiveConfig 3:addCommodityActiveConfig(1:comm.PlatformArgs platformArgs, 2:CommodityActiveConfig activeConfig) throws (1:comm.ErrorInfo err);

	void 4:deleteCommodityActiveConfig(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId,3:quotation_account.ContractActiveType activeType, 4:string fixedCode ) throws (1:comm.ErrorInfo err);



	// #### 订阅商品合约接口 ####
	/**
	  * 查询订阅商品合约信息
	  */
	CommodityRegisterPage 5:reqCommodityRegister(1:comm.PlatformArgs platformArgs, 2:ReqCommodityRegisterOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	CommodityRegister 6:updateCommodityRegister(1:comm.PlatformArgs platformArgs, 2:CommodityRegister commodityRegister) throws (1:comm.ErrorInfo err);

	CommodityRegister 7:addCommodityRegister(1:comm.PlatformArgs platformArgs, 2:CommodityRegister commodityRegister) throws (1:comm.ErrorInfo err);

	void 8:deleteCommodityRegister(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:contract_standard.TechPlatformEnv platformEnv, 4:quotation_account.ContractActiveType activeType, 5:string fixedCode ) throws (1:comm.ErrorInfo err);

	/**
	  * 设置订阅商品排序
	  */
	void 21:setCommodityRegisterOrderIndex(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:contract_standard.TechPlatformEnv platformEnv, 4:i32 orderIndex,5:quotation_account.ContractActiveType activeType, 6:string fixedCode ) throws (1:comm.ErrorInfo err);


	// #### 行情账号信息接口 ####
	/**
	  * 查询行情账号信息
	  */
	QuotationAccountInfoPage 9:reqQuotationAccountInfo(1:comm.PlatformArgs platformArgs, 2:ReqQuotationAccountInfoOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	QuotationAccountInfo 10:updateQuotationAccountInfo(1:comm.PlatformArgs platformArgs, 2:QuotationAccountInfo quotationAccountInfo) throws (1:comm.ErrorInfo err);

	QuotationAccountInfo 11:addQuotationAccountInfo(1:comm.PlatformArgs platformArgs, 2:QuotationAccountInfo quotationAccountInfo) throws (1:comm.ErrorInfo err);

	void 12:deleteQuotationAccount(1:comm.PlatformArgs platformArgs, 2:i64 accountId) throws (1:comm.ErrorInfo err);


	// #### 行情账号订阅能力接口 ####
	/**
	  * 查询行情账号订阅能力信息
	  */
	list<ExchangeRegisterAbility> 13:reqExchangeRegisterAbility(1:comm.PlatformArgs platformArgs, 2:ReqAccountRegisterAbilityOption option) throws (1:comm.ErrorInfo err);

	void 15:batAddAccountRegisterAbility(1:comm.PlatformArgs platformArgs, 2:list<AccountRegisterAbility> abilities) throws (1:comm.ErrorInfo err);

	void 16:deleteAccountRegisterAbility(1:comm.PlatformArgs platformArgs, 2:i64 abilityId) throws (1:comm.ErrorInfo err);

	void 23:deleteAccountRegisterAbilityByExchange(1:comm.PlatformArgs platformArgs, 2:i64 accountId, 3:i32 exchangeId) throws (1:comm.ErrorInfo err);

	SubscribedContractPage 17:reqSubscribedContract(1:comm.PlatformArgs platformArgs, 2:ReqSubscribedContractOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);



	// 重新规划
	void 18:replanSubscribe(1:comm.PlatformArgs platformArgs, 2:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

	// 查询预览
	RePlanSubscribedInfoPreviewPage 19:reqPreviewSubscribedContract(1:comm.PlatformArgs platformArgs, 2:ReqRePlanSubscribedInfoPreviewOption option, 3: page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	// 提交规划
	void 20:submitSubscribeInfo(1:comm.PlatformArgs platformArgs, 2:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

	// 查询已规划
	list<PlanningSubscribedInfo> 22:reqPlanningSubscribedInfo(1:comm.PlatformArgs platformArgs, 2:ReqPlanningSubscribedInfoOption option) throws (1:comm.ErrorInfo err);


// ######################## 行情账号管理接口 结束 ########################


// ######################## 雪橇合约接口 开始 ########################

	/**
	  * 代码中约定json内容类型
	  */
	Tree 30:reqCommodityTree(1:comm.PlatformArgs platformArgs, 2:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

	/**
	  * 代码中约定json内容类型
	  */
	Tree 31:reqCommodityTypeTree(1:comm.PlatformArgs platformArgs, 2:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

	list<ContractTreeNode> 32:reqContractTreeCommodityNodes(1:comm.PlatformArgs platformArgs, 2:i32 sledExchangeId, 3:contract_standard.SledCommodityType commodityType, 4:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

	list<ContractTreeNode> 34:reqContractNodes(1:comm.PlatformArgs platformArgs, 2:i32 sledCommodityId, 3:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);	

// ######################## 雪橇合约接口 结束 ########################


// ######################## 券商信息接口 开始 ########################
	/**
	  * 代码中约定json内容类型
	  */
	Tree 33:reqBrokerTree(1:comm.PlatformArgs platformArgs, 2:contract_standard.TechPlatformEnv platformEnv) throws (1:comm.ErrorInfo err);

// ######################## 券商信息接口 结束 ########################
}