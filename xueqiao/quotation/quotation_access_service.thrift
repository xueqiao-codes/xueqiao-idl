namespace * xueqiao.quotation.access

include "../../comm.thrift"
include "quotation_account.thrift"

struct QuotationAccessState {
    1:optional quotation_account.QuotationAccountAccessState state;
    2:optional string stateMsg;
}

/**
  * 服务仅仅用于行情接入的内部通讯，并不为云上使用
  */
service(3001) QuotationAccessService {
    /**
      *  获取与上手通信的有效时间戳
      */
    i64 1:getLastUpsideEffectiveTimestamp(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    /**
      *  向上手发送心跳, 检测活性
      */
    void 2:sendUpsideHeartBeat(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    
    /**
      * 获取接入状态
      */
    QuotationAccessState  3:getAccessState(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}