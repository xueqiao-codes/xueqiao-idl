/**
  * 持仓统计事件定义
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_position_statis.thrift"
include "trade_hosting_arbitrage.thrift"

/**
  * 事件类型
  */
enum StatPositionEventType {
    STAT_ITEM_CREATED = 1,
    STAT_ITEM_UPDATED = 2,
    STAT_ITEM_REMOVED = 3,
}

/**
  * 实时统计持仓  汇总  变化信息事件，使用 MessageAgent 推送
  * 推送重新计算的持仓汇总(StatPositionSummary)
  */
struct StatPositionSummaryChangedEvent {
    1:optional i64 subAccountId;
    2:optional trade_hosting_position_statis.StatPositionSummary statPositionSummary;
    3:optional i64 eventCreateTimestampMs;
    4:optional StatPositionEventType eventType;
}

/**
  * 实时统计持仓  汇总  变化 guard 事件
  */
struct StatPositionSummaryChangedGuardEvent {
    1:optional i64 subAccountId;
    2:optional string targetKey;
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
    4:optional StatPositionEventType eventType;
}

/**
  * 子账号 持仓动态信息事件，使用PushApi 推送
  */
struct StatPositionDynamicInfoEvent {
    1:optional i64 subAccountId;
    2:optional string targetKey;
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
    4:optional trade_hosting_position_statis.StatPositionDynamicInfo positionDynamicInfo;
    5:optional i64 eventCreateTimestampMs;
}
