/**
  * 套利相关事件定义
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_arbitrage.thrift"

// 雪橇订单创建时间
struct XQOrderCreatedEvent {
    1:optional trade_hosting_arbitrage.HostingXQOrder createdOrder;  // 订单内容
}

// 雪橇订单变化事件
struct XQOrderChangedEvent {
    1:optional trade_hosting_arbitrage.HostingXQOrder changedOrder;  // 变化的雪橇订单
}

// 雪橇订单清理事件
struct XQOrderExpiredEvent {
    1:optional string orderId;
}

// 雪橇订单成交列表变化
struct XQTradeListChangedEvent {
    1:optional trade_hosting_arbitrage.HostingXQOrder order;
    // 一般情况下为新增的成交列表，某些情况下可能会是所有成交列表， 接受方需要处理判重逻辑
    2:optional list<trade_hosting_arbitrage.HostingXQTrade> tradeList; 
}

enum XQOrderGuardEventType {
    XQ_ORDER_CREATED_GUARD = 1,
    XQ_ORDER_CHANGED_GUARD = 2,
    XQ_ORDER_EXPIRED_GUARD = 3,
    XQ_ORDER_TRADELIST_CHANGED_GUARD = 4,
}

struct XQOrderGuardEvent {
    1:optional XQOrderGuardEventType type;  // GUARD类型
    2:optional string orderId;  // 雪橇订单ID
}

/**
  * 组合限价单设置发生变化
  */
struct XQCLOSettingsChangedEvent {
    1:optional string key;
}