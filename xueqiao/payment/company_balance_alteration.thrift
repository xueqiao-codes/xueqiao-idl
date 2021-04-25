/**
  * 公司账户雪橇币金额变更记录
  */

namespace java com.longsheng.xueqiao.payment.balance.alteration

enum OperationType {
	ADD_XCOIN = 0,						// 增加雪橇币
	REDUCE_XCOIN = 1,					// 减少雪橇币
}

// 产品目的
enum AlterationChannel{
	NONE = 0,			// 无
	ALIPAY = 1,			// 支付宝
	WXPAY = 2,			// 微信支付
	BANK_TRANSFER = 3,	// 银行转账
	OTHERS = 4,			// 其他
}

struct BalanceAlteration {
	1:optional i64 alterationId;
	2:optional i64 companyId;
	3:optional OperationType operationType;
	4:optional AlterationChannel alterationChannel;
	5:optional string thirdPartyTradeNo;
	6:optional string description;
	7:optional string operator;
	8:optional double alerationXCoin;				// 变更的雪橇币数量
	9:optional double xCoinBalance;				// 变更后雪橇币数量

	20:optional i64 createTimestamp;
	21:optional i64 lastModifyTimestamp;
}

struct ReqBalanceAlterationOption{
	1:optional set<i64> alterationIds;
	2:optional i64 companyId;
}

struct BalanceAlterationPage{
	1:optional i32 total;
	2:optional list<BalanceAlteration> page;
}