namespace java com.longsheng.xueqiao.broker.dao.thriftapi
namespace csharp xueqiao.broker.dao

include "../../comm.thrift"
include "broker.thrift"

struct ReqBrokerEntryOption{
	1:optional list<i32> brokerIds;
	2:optional string engNameWhole;
	3:optional string engNamePartical;
	4:optional string cnNameWhole;
	5:optional string cnNamePartical;
	6:optional broker.BrokerPlatform platform;
	7:optional broker.TechPlatformEnv env;

	// 按字段排序option，默认 DESC
	8:optional bool orderAsc;
	9:optional bool orderByCreateTimestamp;
	10:optional bool orderByBrokerName;
}

struct ReqBrokerAccessEntryOption{
	1:optional list<i32> brokerIds;
	2:optional broker.BrokerPlatform platform;
	3:optional broker.BrokerAccessStatus accessStatus;
	4:optional list<i32> entryIds;
	5:optional broker.BrokerAccessWorkingStatus workingStatus;
	6:optional string accessName;
	7:optional broker.TechPlatformEnv env;
	8:optional set<broker.BrokerPlatform> platforms;
}

struct BrokerEntryPage{
	1:optional i32 total;
	2:optional list<broker.BrokerEntry> page;
}

struct BrokerAccessEntryPage{
	1:optional i32 total;
	2:optional list<broker.BrokerAccessEntry> page;
}

struct WorkingBrokerAccessEntryResp{
	1:optional bool working;
	2:optional broker.BrokerAccessEntry entry;
}

struct RemoveBrokerAccessEntryResp{
	1:optional bool success;
}

struct RemoveBrokerEntryResp{
	1:optional bool success;
}

struct SyncBrokerOption{
	1:optional string userName;
}

struct SyncBrokerResp{
	1:optional bool success;
}

service(301) BrokerDaoService {

    i32 1:addBrokerEntry(1:comm.PlatformArgs platformArgs, 2:broker.BrokerEntry brokerEntry) throws (1:comm.ErrorInfo err);

    void 2:updateBrokerEntry(1:comm.PlatformArgs platformArgs, 2:broker.BrokerEntry brokerEntry) throws (1:comm.ErrorInfo err);

    BrokerEntryPage 3:reqBrokerEntry(1:comm.PlatformArgs platformArgs, 2:ReqBrokerEntryOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

    i32 4:addBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:broker.BrokerAccessEntry brokerAccessEntry) throws (1:comm.ErrorInfo err);

    void 5:updateBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:broker.BrokerAccessEntry brokerAccessEntry) throws (1:comm.ErrorInfo err);

    BrokerAccessEntryPage 6:reqBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:ReqBrokerAccessEntryOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

    WorkingBrokerAccessEntryResp 7:reqWorkingBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:i32 brokerAccessEntryId)throws (1:comm.ErrorInfo err);

    WorkingBrokerAccessEntryResp 8:syncBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:i32 brokerAccessEntryId)throws (1:comm.ErrorInfo err);

    RemoveBrokerAccessEntryResp 9:removeBrokerAccessEntry(1:comm.PlatformArgs platformArgs, 2:i32 brokerAccessEntryId) throws (1:comm.ErrorInfo err);

    RemoveBrokerEntryResp 10:removeBrokerEntry(1:comm.PlatformArgs platformArgs, 2:i32 brokerEntryId) throws (1:comm.ErrorInfo err);

    SyncBrokerResp 11:syncBroker(1:comm.PlatformArgs platformArgs, 2:SyncBrokerOption option)throws (1:comm.ErrorInfo err);
}