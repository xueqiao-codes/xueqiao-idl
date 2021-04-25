/**
  * 机器管理服务
  */

namespace java  org.soldier.platform.machine
namespace cpp platform.machine
namespace py  platform.machine

include "../comm.thrift"

struct Machine {
    1:optional string hostName;       // 域名地址
    2:optional string hostInnerIP;    // 机器内网IP地址
    3:optional string hostDesc;       // 机器描述
    4:optional string hostAdmin;      // 机器管理员和负责人
    5:optional string rootPassword;   // ROOT密码
    6:optional map<string, string> machineProperties;   // 额外的机器属性记录
    7:optional string relatedScreenId;   // 关联的监控视图ID
    10:optional i32 createTimestamp;  // 记录创建时间戳  
    11:optional i32 lastModifyTimestamp; // 最近修改时间
    
    12:optional string relatedScreenURL;  // 关联的视图访问URL
}

struct MachineList {
    1:required i32 totalNum;
    2:required map<string, Machine> machinesMap;
}

enum KeyType {
    KEY_HOSTNAME = 1,
    KEY_HOSTINNER_IP = 2,
}

struct QueryMachineOption {
    1:optional list<string> hostNames;
    2:optional list<string> hostInnerIPS;
    3:optional string       hostDesc;
    4:optional string       hostAdmin;
    5:optional string       clusterPropertyExpression;
    
    6:optional KeyType      keyType = KeyType.KEY_HOSTNAME;
    7:optional string       hostNamePartical;   // 部分匹配hostName
}

enum MachineManageBoError {
    ERROR_DUPLICATE_HOSTNAME = 7001, // 重复的HOSTNAME
    ERROR_DUPLICATE_HOSTINNER_IP = 7002, // 重复的内网IP
    ERROR_NO_SUCH_MACHINE = 7003,        // 主机找不到
}

service(22) MachineManageBo {
    MachineList 1:queryMachineList(1:comm.PlatformArgs platformArgs
            , 2:QueryMachineOption option
            , 3:i32 pageIndex
            , 4:i32 pageSize) throws(1:comm.ErrorInfo err);

    void 2:addMachine(1:comm.PlatformArgs platformArgs, 2:Machine newMachine) throws(1:comm.ErrorInfo err);
    
    void 3:updateMachine(1:comm.PlatformArgs platformArgs, 2:Machine updateMachine) throws(1:comm.ErrorInfo err);
    
    void 4:deleteMachine(1:comm.PlatformArgs platformArgs, 2:string hostName) throws(1:comm.ErrorInfo err);  
    
    void 5:updateMachineRelatedMonitor(1:comm.PlatformArgs platformArgs, 2:string hostName) throws(1:comm.ErrorInfo err);
    
    void 6:deleteMachineRelatedMonitor(1:comm.PlatformArgs platformArgs, 2:string hostName) throws(1:comm.ErrorInfo err);
}


