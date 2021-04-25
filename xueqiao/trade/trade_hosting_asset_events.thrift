/**
  * 交易托管机基础事件定义(资产)
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_basic.thrift"
include "trade_hosting_asset.thrift"

/**
  * 实时持仓量变化信息事件，使用MessageAgent 推送
  */
struct HostingPositionVolumeEvent {
    1:optional trade_hosting_asset.HostingPositionVolume positionVolume;
    2:optional i64 eventCreateTimestampMs;
}

/**
  * 实时持仓的资金变化信息事件，使用 PushApi 推送
  */
struct HostingPositionFundEvent{
    1:optional trade_hosting_asset.HostingPositionFund positionFund;
    2:optional i64 eventCreateTimestampMs;
}

/**
  * 实时操作账号资金信息事件，使用 PushApi 推送
  */
struct HostingFundEvent{
    1:optional i64 subAccountId;
    2:optional string currency;
    3:optional trade_hosting_asset.HostingFund hostingFund;
    4:optional i64 eventCreateTimestampMs;
    5:optional bool baseCurrency;
}

enum HostingAssetGuardEventType {
    HOSTING_POSITION_CHANGED_GUARD = 1,
}

struct HostingPositionGuardEvent {
    1:optional HostingAssetGuardEventType type;  // GUARD类型
    2:optional i64 sledContractId;  // 雪橇合约id
    3:optional i64 subAccountId;    // 子账号id
}

/**
  * 操作账号过期合约删除事件，使用 PushApi 推送
  */
struct ExpiredContractDeleteEvent{
    1:optional i64 subAccountId;
    2:optional i64 sledContractId;
    3:optional i64 eventCreateTimestampMs;
}
