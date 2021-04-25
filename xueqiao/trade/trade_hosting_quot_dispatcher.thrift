/**
  * 托管机行情分发器
  */
  
namespace * xueqiao.trade.hosting.quot.dispatcher

include "../../comm.thrift"

struct SyncQuotTopic {
    1:optional string platform;
    2:optional string contractSymbol;
}

struct SyncTopicsRequest {
    1:optional string consumerKey;
    2:optional list<SyncQuotTopic> quotTopics;
}

service(711) TradeHostingQuotDispatcher {
    /**
      * 同步订阅主题
      */
    void 1:syncTopics(1:comm.PlatformArgs platformArgs, 2:SyncTopicsRequest syncRequest) throws (1:comm.ErrorInfo err);
}


