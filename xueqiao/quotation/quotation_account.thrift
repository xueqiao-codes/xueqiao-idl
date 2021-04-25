/**
  * 管理行情账号与合约订阅规则
  */
namespace java xueqiao.quotation.account.thriftapi
namespace py xueqiao.quotation.account.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

enum QuotationTechPlatform{
	NONE = 0,
	CTP = 1,
	ESUNNY =2,			// 易盛9.0
}

enum QuotationPlatformEnv{
	NONE = 0,
	REAL = 1,	// 实盘
	SIM = 2,	// 模拟盘
}

/**
  * 部署区域
  */
enum DeploySet{
	MASTER = 0,
	SLAVE = 1,
}

enum ContractActiveType{
	ACTIVE_MONTH = 0,		// 活跃月份
	FIXED_CODE = 1,			// 固定合约号
}

/**
  * 商品活跃合约规则
  */
struct ContractActiveRule{
	1:optional i32 sledCommodityId;				// 商品id
	2:optional map<i32, bool> activeMonthMap; 	// key:月份（1-12）value：是否活跃

	3:optional ContractActiveType activeType;
	4:optional string fixedCode;				// 固定合约号

	6:optional i64 createTimestamp;
	7:optional i64 lastModityTimestamp;
}

/**
  * 合约订阅规则
  */
struct ContractRegisterRule{
	1:optional i32 sledCommodityId;				// 商品id
	2:optional i32 registerPriority;			// 订阅优先级
	3:optional i32 activeShowCount;				// 活跃合约展示数量
	4:optional i32 inactiveShowCount;			// 非活跃合约展示数量
	5:optional QuotationPlatformEnv platformEnv;// 行情环境: 实盘、模拟盘
	6:optional i64 createTimestamp;
	7:optional i64 lastModityTimestamp;
	8:optional i32 orderIndex;					// 次序编号(编号越小优先级越高)

	9:optional ContractActiveType activeType;
	10:optional string fixedCode;				// 固定合约号
}

struct CommodityRegisterOrder{
	1:optional i32 sledCommodityId;
	2:optional QuotationPlatformEnv platformEnv;// 行情环境: 实盘、模拟盘
	3:optional i32 orderIndex;
}

/**
  * 账号本身的状态
  */
enum QuotationAccountState {
    ACCOUNT_DISABLED = 0,                         // 账号停用
    ACCOUNT_ENABLED = 1,                          // 账号启用
}

/**
  * 账号接入的状态
  */
enum QuotationAccountAccessState {
	ACCOUNT_NOT_ACCESS = 0,						//  账号未接入
	ACCOUNT_ACTIVE = 1,                         //  账号接入正常, 活跃可使用
	ACCOUNT_INVALID = 2,                        //  账号接入无效, 接入异常
}

/**
  * 行情账号信息
  */
struct QuotationAccount{
	1:optional i64 accountId;
	2:optional string accountName;				// 登陆用户名
	3:optional string accountpwd;				// 登陆密码
	4:optional string nickName;					// 账号别名
	5:optional QuotationTechPlatform platform;	// 接入技术平台
	6:optional i32 brokerId;               		// 对接的券商ID
	7:optional i32 brokerAccessId;				// 券商接入id
	8:optional map<string,string> accountProperties; 		// 账户的扩展属性
	9:optional QuotationAccountState accountState;          // 账号本身状态

	10:optional QuotationAccountAccessState accessState; 	//账号接入状态
	11:optional string invalidReason;       		// 账号不可用原因
	12:optional i32 invalidErrorCode;      			// 不可用的原因, 内部定义的错误码
	13:optional i32 apiRetCode;         			// 接入API返回的错误码

    14:optional i32 maxRegisterCount;			// 最大订阅数量
	
	15:optional i64 createTimestamp;
	16:optional i64 lastModifyTimestamp;

	17:optional QuotationPlatformEnv platformEnv; // 实盘、模拟盘
	18:optional DeploySet deploySet;				// 部署区域
}

enum SupportType{
	SET = 0,
	ALL = 1,
}

struct MicSupportCommodity{
	1:optional SupportType supportType;
	2:optional set<i32> supportCommodityIds;	// 支持商品id
}

struct QuotationAccountSupport{
	1:optional i64 accountId;
	2:optional map<string, MicSupportCommodity> micSupport;
}

struct ReqQuotationAccountSupportOption{
	1:optional set<i64> accountIds;
}

struct QuotationAccountSupportPage{
	1:optional i32 total;
	2:optional list<QuotationAccountSupport> page;
}

struct AccountCommodityRegisterAbility{
	1:optional i64 registerAbilityId;
	2:optional i64 accountId;
	3:optional i32 sledExchangeId;
	4:optional string exchangeMic;
	5:optional SupportType supportType;
	6:optional i32 sledCommodityId;

	7:optional i64 createTimestamp;
	8:optional i64 lastModifyTimestamp;
}

struct AccountCommodityRegisterAbilityPage{
	1:optional i32 total;
	2:optional list<AccountCommodityRegisterAbility> page;
}

struct ReqAccountCommodityRegisterAbilityOption{
	1:optional i64 registerAbilityId;
	2:optional i64 accountId;
	3:optional set<i32> sledCommodityIds;
	4:optional set<i32> sledExchangeIds;
	5:optional SupportType supportType;
	6:optional set<string> exchangeMics;
}

struct QuotationAccountPage{
	1:optional i32 total;
	2:optional list<QuotationAccount> page;
}

struct ContractActiveRulePage{
	1:optional i32 total;
	2:optional list<ContractActiveRule> page;
}

struct ContractRegisterRulePage{
	1:optional i32 total;
	2:optional list<ContractRegisterRule> page;
}

struct ReqContractActiveRuleOption{
	1:optional set<i32> commodityIds;
}

struct ReqContractRegisterRuleOption{
	1:optional set<i32> commodityIds;
	2:optional QuotationPlatformEnv platformEnv;// 行情环境: 实盘、模拟盘
}

enum QuotationAccountOrderBy{
	ACCOUNT_ID = 0,
	CREATE_TIMESTAMP = 1,
}

enum QueryOrderType{
	ASC = 0,		// 升序
	DESC = 1,		// 降序
}

struct ReqQuotationAccountOption{
	1:optional set<i64> accountIds;
	2:optional QuotationTechPlatform platform;
	3:optional QuotationPlatformEnv platformEnv;

	4:optional set<i32> supportCommodityIds;
	5:optional set<i32> brokerIds;

	6:optional string accountNamePartical;
	7:optional string nickNamePartical;

	8:optional QuotationAccountOrderBy orderBy; 

	9:optional DeploySet deploySet;				// 部署区域

	10:optional QueryOrderType orderType;
}

struct SubcribeQuoteStateTask{
	1:optional i64 taskId;
	2:optional i64 createTimestamp;
}