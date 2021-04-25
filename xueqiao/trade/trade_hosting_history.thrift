/**
  * 雪橇历史相关内容模块
  */
namespace * xueqiao.trade.hosting.history.thriftapi
  
include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_arbitrage.thrift"

//雪橇订单历史索引条目
struct HostingXQOrderHisIndexItem {
    1:optional i64 subAccountId;  // 子账户ID
    2:optional i32 subUserId;     // 订单下单子用户ID
    3:optional trade_hosting_arbitrage.HostingXQOrderType orderType; // 订单类型
    4:optional trade_hosting_arbitrage.HostingXQTarget orderTarget;  // 订单标的
    5:optional i64 orderCreateTimestampMs;  // 订单创建时间
    6:optional i64 orderEndTimestampMs; // 订单终结态时间(撤单或者完成的时间)
    7:optional string orderId;  // 雪橇订单ID

    9:optional i64 createTimestampMs; // 历史索引创建时间戳
    10:optional i64 lastmodifyTimestampMs; // 历史索引最近修改时间戳
}

//雪橇历史成交索引条目
struct HostingXQTradeHisIndexItem {
    1:optional i64 subAccountId; // 子账户ID
    2:optional i32 subUserId;  // 成交对应的订单的子用户ID
    3:optional trade_hosting_arbitrage.HostingXQTarget tradeTarget; //成交标的
    4:optional i64 tradeCreateTimestampMs; // 成交时间
    5:optional i64 tradeId; // 雪橇成交ID
    6:optional string orderId; // 雪橇订单ID
    
    9:optional i64 createTimestampMs; // 历史索引创建时间戳
    10:optional i64 lastmodifyTimestampMs; // 历史索引最近修改时间戳
}

struct QueryTimePeriod {
    1:optional i64 startTimestampMs;
    2:optional i64 endTimestampMs;
}

enum QueryXQOrderHisIndexItemOrderType {
    XQ_ORDER_CREATE_TIMESTAMP_ASC = 1,  // 雪橇订单创建时间戳升序
    XQ_ORDER_CREATE_TIMESTAMP_DESC = 2, // 雪橇订单创建时间戳降序
    XQ_ORDER_END_TIMESTAMP_ASC = 3,     // 雪橇订单终结时间戳升序
    XQ_ORDER_END_TIMESTAMP_DESC = 4,    // 雪橇订单终结时间戳降序
}

struct QueryXQOrderHisIndexItemOption {
    1:optional QueryTimePeriod orderCreateTimePeriod;  // 订单创建时间区间
    2:optional QueryTimePeriod orderEndTimePeriod;     // 订单完结时间区间
    3:optional set<i64> subAccountIds;  // 订单所属子账号列表
    4:optional set<trade_hosting_arbitrage.HostingXQTarget> orderTargets; // 查询订单标的 
    5:optional QueryXQOrderHisIndexItemOrderType itemOrderType; // 排序类型
}

struct HostingXQOrderHisIndexPage {
    1:optional i32 totalNum;
    2:optional list<HostingXQOrderHisIndexItem> resultList;
}

enum QueryXQTradeHisIndexItemOrderType {
    XQ_TRADE_CREATE_TIMESTAMP_ASC = 1,  // 雪橇成交创建时间戳升序
    XQ_TRADE_CREATE_TIMESTAMP_DESC = 2, // 雪橇成交创建时间戳降序
}

struct QueryXQTradeHisIndexItemOption {
    1:optional QueryTimePeriod tradeCreateTimePeriod;
    2:optional set<i64> subAccountIds;
    3:optional set<trade_hosting_arbitrage.HostingXQTarget> tradeTargets;
    4:optional QueryXQTradeHisIndexItemOrderType itemOrderType;
}

struct HostingXQTradeHisIndexPage {
    1:optional i32 totalNum;
    2:optional list<HostingXQTradeHisIndexItem> resultList;
}

service(716) TradeHostingHistory {
    void 1:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    HostingXQOrderHisIndexPage 2:getXQOrderHisIndexPage(
            1:comm.PlatformArgs platformArgs
            , 2:QueryXQOrderHisIndexItemOption qryOption
            , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
            
    HostingXQTradeHisIndexPage 3:getXQTradeHisIndexPage(
            1:comm.PlatformArgs platformArgs
            , 2:QueryXQTradeHisIndexItemOption qryOption
            , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}


  