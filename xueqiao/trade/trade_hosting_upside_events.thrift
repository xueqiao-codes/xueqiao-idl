/**
  * 上手进程通知的相关事件
  */

namespace * xueqiao.trade.hosting.events

/**
  * 上手持仓费率变化事件
  */
struct UpsidePositionRateDetailsUpdatedEvent {
    1:optional i64 tradeAccountId;
}