/**
  * 交易托管机基础事件定义(持仓调整)
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_position_adjust.thrift"

/**
  * 持仓编辑锁定事件，使用 MessageAgent 推送
  */
struct PositionEditLockEvent{
    1:optional trade_hosting_position_adjust.PositionEditLock positionEditLock;
    2:optional i64 eventCreateTimestampMs;
}

enum PositionAdjustGuardEventType {
    HOSTING_POSITION_EDIT_LOCK_CHANGE = 1,
}

/**
  * 持仓编辑锁定守护事件，使用 MessageAgent 推送
  * 根据lockKey查询到最新的锁定状态
  */
struct PositionAdjustGuardEvent {
    1:optional PositionAdjustGuardEventType type;   // GUARD类型
    2:optional string lockKey;		 				// 持仓编辑锁key
}
