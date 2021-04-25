/**
  * errorcode访问的Agent
  */
namespace * org.soldier.platform.errorcode

include "../comm.thrift"
include "errorcode_manager/errorcode_manager.thrift"

service(5) ErrorCodeAgent {
    list<errorcode_manager.ErrorCodeItem> 1:getErrorCodeItem(1:comm.PlatformArgs platformArgs
                            , 2:string domain
                            , 3:i32 errorCode) throws (1:comm.ErrorInfo err);
}

