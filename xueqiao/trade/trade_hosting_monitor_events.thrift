/**
  * 探测监控事件
  */
namespace * xueqiao.trade.hosting.events

// 内部使用的消息队列正常工作的探测事件
struct MessageBusDetectEvent {
    1:optional i64 detectTimestampMs;
}