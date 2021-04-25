/**
  * 保证金和手续费
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_position_fee.thrift"

/**
  * 事件类型
  */
enum PositionFeeEventType {
    PF_MARGIN_CHANGED = 1,       // 保证金更新
    PF_COMMISSION_CHANGED = 2,   // 手续费更新
}

/**
  * 持仓费率（保证金 和 手续费）变化事件，使用 MessageAgent 推送
  */
struct PositionFeeChangedEvent {
    1:optional i64 subAccountId;
    2:optional i64 contractId;
    10:optional trade_hosting_position_fee.MarginInfo margin;              // 保证金
    11:optional trade_hosting_position_fee.CommissionInfo commission;      // 手续费
    12:optional i64 eventCreateTimestampMs;     // 事件时间
    13:optional PositionFeeEventType eventType; // 事件类型
}

/**
  * 持仓费率（保证金 和 手续费）变化 guard 事件
  */
struct PositionFeeChangedGuardEvent {
    1:optional i64 subAccountId;
    2:optional i64 contractId;
    10:optional PositionFeeEventType eventType;
}

