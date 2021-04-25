namespace java com.longsheng.xueqiao.aliyun.resource.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "../hosting_machine/hosting_machine.thrift"

/**
  * 阿里云实例付费方式
  */
enum InstanceChargeType{
    PREPAID = 0,       // 预付费，即包年包月
    POSTPAID = 1,      // 后付费，即按量付费
}

/**
  * 阿里云实例网络类型
  */
enum InstanceNetworkType{
    CLASSIC = 0,        // 经典网络
    VPC = 1,            // 私有网络
}

/**
  * 托管机机器实体的描述
  */
struct EcsInstance{
    1:optional string aliyunInstanceId;     // 阿里云ECS实例id
    2:optional string regionId;             // 地域id
    3:optional string instanceName;         // 实例名称
    4:optional i64 aliyunExpiredTimestamp;  // 实例过期时间
    5:optional string zoneId;               // 可用区ID
    6:optional InstanceNetworkType instanceNetworkType;     // 实例网络类型
    7:optional InstanceChargeType instanceChargeType;       // 实例付费方式
    8:optional map<string, string> tags;    // 标签
    9:optional string innerIpAddress;       // 机器内网IP 
    10:optional string publicIpAddress;     // 机器外网IP
    11:optional hosting_machine.HostingMachineRunningStatus runningStatus;      // 实例运行状态
    13:optional hosting_machine.HostingMachineSpec machineSpec;  // 机器规格
}

struct EcsInstancePage{
    1:optional i32 total;
    2:optional list<EcsInstance> page;
}

struct ReqEcsInstanceOption{
    1:optional set<string> instanceIds;
    2:optional string regionId;
    5:optional page.IndexedPageOption pageOption;
}

enum AliYunResourceErrorCode {
    REQUEST_ECS_INSTANCES_FAIL = 1001,   // 查询ECS实例信息失败
}