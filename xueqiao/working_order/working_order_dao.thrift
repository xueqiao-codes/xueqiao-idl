/**
  * 雪橇用户工单系统
  */
namespace * xueqiao.working.order.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "working_order.thrift"

/**
  * 工单信息存储类型，dao内部使用
  */
struct WorkingOrderStorage{
	1:optional working_order.BaseWorkingOrder baseWorkingOrder;
	2:optional string orderClassType;
	3:optional string content;
}

struct WorkingOrderStoragePage{
	1:optional i32 total;
	2:optional list<WorkingOrderStorage> page;
}

service(904) WorkingOrderDao{
		
	/**
	  * 添加工单
	  */
	i64 1:addWorkingOrderStorage(1:comm.PlatformArgs platformArgs, 2:WorkingOrderStorage workingOrderStorage) throws (1:comm.ErrorInfo err);
	void 2:updateWorkingOrderStorage(1:comm.PlatformArgs platformArgs, 2:WorkingOrderStorage workingOrderStorage) throws (1:comm.ErrorInfo err);
	WorkingOrderStoragePage 3:reqWorkingOrderInfo(1:comm.PlatformArgs platformArgs, 2:working_order.ReqWorkingOrderOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}