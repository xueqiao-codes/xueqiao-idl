namespace * xueqiao.trade.hosting.quot.comb.thriftapi

include "../../comm.thrift"
include "../quotation/quotation_item.thrift"

/**
  * 组合行情定义
  */
struct HostingQuotationComb {
    1:optional i64 composeGraphId;  // 组合ID
    2:optional quotation_item.QuotationItem combItem;  // 组合行情条目
    3:optional list<quotation_item.QuotationItem> legItems; // 每条腿的行情腿条目 
}

struct SyncCombTopicsRequest {
    1:optional string consumerKey;
    2:optional set<i64> composeGraphIds;
}

service(720) TradeHostingQuotComb {
    /**
      * 同步订阅主题
      */
    void 1:syncCombTopics(1:comm.PlatformArgs platformArgs, 2:SyncCombTopicsRequest syncRequest) throws (1:comm.ErrorInfo err);
}