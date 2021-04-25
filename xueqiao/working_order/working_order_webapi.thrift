/**
  * 雪橇用户工单系统
  */
namespace java xueqiao.working.order.webapi.thriftapi
namespace py xueqiao.working.order.webapi.thriftapi
namespace csharp xueqiao.working.order.webapi.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "working_order.thrift"
include "../broker/broker.thrift"

/**
  * 资金账户工单信息
  */
struct AssetAccountWorkingOrderWebInfo{
	1:optional i64 orderId;
	2:optional working_order.AssetAccountWorkingOrder workingOrderInfo;
	3:optional string userName;
	4:optional broker.BrokerEntry brokerEntry;
	5:optional broker.BrokerAccessEntry brokerAccessEntry;
	6:optional string companyCode;
}

struct ReqWorkingOrderWebInfoOption{
	1:optional string companyNamePartical;
	2:optional string companyUserNamePartical;
	3:optional working_order.WorkingOrderType orderType;
	4:optional working_order.WorkingOrderState state;
}

struct AssetAccountWorkingOrderWebInfoPage{
	1:optional i32 total;
	2:optional list<AssetAccountWorkingOrderWebInfo> page;
}

struct OperateResult{
	1:optional bool success;
	2:optional i32 code;
	3:optional string message;
}

service(905) WorkingOrderWebapi{

	AssetAccountWorkingOrderWebInfoPage 1:reqWorkingOrderInfo(1:comm.PlatformArgs platformArgs, 2:ReqWorkingOrderWebInfoOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	OperateResult 2:markWorkingOrderState(1:comm.PlatformArgs platformArgs, 2:i64 workingOrderId, 3:working_order.WorkingOrderState state, 4:string operateName) throws (1:comm.ErrorInfo err);
}