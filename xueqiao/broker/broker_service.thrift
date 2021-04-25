namespace java com.longsheng.xueqiao.broker.thriftapi
namespace csharp xueqiao.broker

include "../../comm.thrift"
include "broker.thrift"

struct ReqBrokerOption{
	1:optional i32 brokerId;
	2:optional string engNameWhole;
	3:optional string engNamePartical;
	4:optional string cnNameWhole;
	5:optional string cnNamePartical;
	6:optional broker.TechPlatformEnv env;
}

struct ReqBrokerAccessOption{
	1:optional list<i32> brokerId;
	2:optional list<i32> brokerAccessIds;
	3:optional broker.BrokerPlatform platform;
	4:optional set<broker.BrokerPlatform> platforms;
}

struct BrokerPage{
	1:optional i32 total;
	2:optional list<broker.BrokerEntry> page;
}

struct BrokerAccessPage{
	1:optional i32 total;
	2:optional list<broker.BrokerAccessEntry> page;
}

struct ReqBrokerAccessInfoOption{
	1:optional list<i32> brokerAccessIds;
	2:optional list<i32> brokerIds;
	3:optional set<broker.BrokerPlatform> platforms;
}

struct BrokerAccessInfo{
	1:optional i32 entryId;									//系统生成，唯一id，不可变
	2:optional i32 brokerId;								//券商实体id
	3:optional broker.BrokerPlatform platform;				//券商接入平台
	4:optional string engName;								//券商英文名称
	5:optional string cnName;								//券商中文名称
	6:optional string note;									//备注
	10:optional broker.TechPlatformEnv techPlatformEnv;		//技术平台环境
	11:optional string accessName;							//券商接入名称
}

struct BrokerAccessInfoPage{
	1:optional i32 total;
	2:optional list<BrokerAccessInfo> page;
}

service(302) BrokerService {
    BrokerPage 1:reqBroker(1:comm.PlatformArgs platformArgs, 2:ReqBrokerOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
    BrokerAccessPage 2:reqBrokerAccess(1:comm.PlatformArgs platformArgs, 2:ReqBrokerAccessOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);

    // 聚合界面可视信息返回
	BrokerAccessInfoPage 3:reqBrokerAccessInfo(1:comm.PlatformArgs platformArgs, 2:ReqBrokerAccessInfoOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
}