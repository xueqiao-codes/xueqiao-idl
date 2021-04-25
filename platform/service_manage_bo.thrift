/**
  * 服务管理服务
  */

include "../comm.thrift"

struct TService {
    1:optional i32 serviceKey;  // 服务命令号
    2:optional string serviceName; //服务名称
    3:optional list<string> serviceHostNameList; // 服务部署机器名
    4:optional list<string> serviceIPList;       // 服务部署的机器IP列表
    5:optional list<string> serviceAdminList;    // 服务管理负责人
    6:optional string idlRelativePath; // 服务定义IDL的相对路径
    7:optional string relatedScreenId;  // 服务关联的监控ScreenId
    8:optional string relatedScreenUrl;  // 用于访问监控的关联ScreenUrl
    9:optional i32    createTimestamp;
    10:optional i32 lastmodifyTimestamp; 
}

struct QueryServiceOption {
    1:optional i32 serviceKey;
    2:optional string serviceNamePartical;
    3:optional string hostNamePartical;
    4:optional string serviceAdminPartical;
    5:optional string idlRelativePathPartical;
}

struct QueryServiceResult {
    1:optional i32 totalNum;
    2:list<TService> resultList;
}

service(23) ServiceManageBo {
    QueryServiceResult 1:queryServices(1:comm.PlatformArgs platformArgs
            , 2:QueryServiceOption option
            , 3:i32 pageIndex
            , 4:i32 pageSize) throws (1:comm.ErrorInfo err);
            
    void 2:addService(1:comm.PlatformArgs platformArgs, 2:TService aService) throws (1:comm.ErrorInfo err);
            
    void 3:updateService(1:comm.PlatformArgs platformArgs, 2:TService aService) throws (1:comm.ErrorInfo err);
    
    void 4:deleteService(1:comm.PlatformArgs platformArgs, 2:i32 serviceKey) throws (1:comm.ErrorInfo err);
}