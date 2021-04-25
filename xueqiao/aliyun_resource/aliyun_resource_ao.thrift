namespace java com.longsheng.xueqiao.aliyun.resource.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "aliyun_resource.thrift"

enum ResourceType{
    INSTANCE = 0,
    DISK = 1,
    IMAGE = 2,
    SECURITYGROUP = 3,
    SNAPSHOT = 4,
}

struct ResourceTag{
    1:optional i32 tagIndex; //标签索引，1~5
    2:optional string tagKey;
    3:optional string tagValue;
    4:optional string regionId;
    5:optional ResourceType resourceType;
    6:optional string resourceId; 
}

struct AddResourceTagResp{
    1:optional bool success;
    2:optional string errMsg;
}

struct SynceEcsInstanceOption{
    1:optional set<string> instanceIds;
    2:optional string regionId;
}

service(350) AliyunResourceAoService {

    aliyun_resource.EcsInstancePage 1:reqEcsInstance(1:comm.PlatformArgs platformArgs, 2:aliyun_resource.ReqEcsInstanceOption option) throws (1:comm.ErrorInfo err);

    AddResourceTagResp 2:addResourceTag(1:comm.PlatformArgs platformArgs, 2:ResourceTag resourceTag) throws (1:comm.ErrorInfo err);

    void 3:syncEcsInstance(1:comm.PlatformArgs platformArgs, 2:SynceEcsInstanceOption option) throws (1:comm.ErrorInfo err);
}