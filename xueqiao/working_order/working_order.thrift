/**
  * 雪橇用户工单系统
  */
namespace java xueqiao.working.order.thriftapi
namespace py xueqiao.working.order.thriftapi
namespace csharp xueqiao.working.order.thriftapi

enum WorkingOrderType{
	ASSET_ACCOUNT = 0,		// 资金账号
}

enum WorkingOrderState{
	CREATE = 0,			// 新建
	IN_PROGRESS = 1,	// 进行中
	DONE =2,			// 完成
}

/**
  * 资金账户
  */
struct AssetAccount{
	1:optional string accountName;		// 账号
	2:optional string password;
	3:optional string nickName;			// 别名
	4:optional string authorizationCode;// 授权码
	5:optional i64 brokerId;
	6:optional i64 brokerAccessId;
	7:optional map<string,string> extraInfo;	//扩展信息
}

/**
  * 工单基本信息
  */
struct BaseWorkingOrder{
	1:optional i64 orderId;
	2:optional i64 companyId;
	3:optional i64 companyUserId;
	4:optional WorkingOrderType workingOrderType;
	5:optional WorkingOrderState state;
	6:optional i64 createTimestamp;
	7:optional i64 lastModifyTimestamp;
	8:optional string operateUser;				// 操作者
}

/**
  * 资金账户工单信息
  */
struct AssetAccountWorkingOrder{
	1:optional i64 workingOrderId;
	2:optional BaseWorkingOrder baseWorkingOrder;
	3:optional AssetAccount account;
}

struct ReqWorkingOrderOption{
	1:optional i64 orderId;
	2:optional i64 companyUserId;
	3:optional WorkingOrderType type;
	4:optional WorkingOrderState state;
	5:optional set<i64> orderIds;
	6:optional i64 companyId;
	7:optional set<i64> companyIds;
	8:optional set<i64> companyUserIds;
}

struct AssetAccountWorkingOrderPage{
	1:optional i32 total;
	2:optional list<AssetAccountWorkingOrder> page;
}