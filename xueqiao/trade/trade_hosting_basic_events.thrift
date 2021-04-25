/**
  * 交易托管机基础事件定义
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_basic.thrift"

enum HostingEventType {
    HOSTING_INITED = 1,
    HOSTING_DESTORIED = 2
}

/**
  * 主机事件
  */
struct HostingEvent {
    1:optional HostingEventType type;
}

/**
  * 用户事件定义
  */
enum UserEventType {
    USER_ADD = 1,         // 托管机添加用户
    USER_REMOVE = 2,      // 托管机删除用户
    USER_INFO_UPDATED = 3, // 用户信息发生改变
    USER_ALL_CLEARD = 4,   // 所有用户被清除
    USER_STATE_CHANGED = 5,  // 用户的状态发生变化
}

struct UserEvent {
    1:optional UserEventType type;
    2:optional i32 subUserId;       // 子用户ID
}

/**
  * 用户登陆态变化事件
  */
struct LandingStatusChangedEvent {
    1:optional i32 subUserId;
}

/**
  * 组合视图事件定义
  */
enum ComposeViewEventType {
    COMPOSE_VIEW_ADDED = 1,           // 组合视图被添加
    COMPOSE_VIEW_SUBSCRIBED = 2,      // 组合视图被订阅
    COMPOSE_VIEW_UNSUBSCRIBD = 3,     // 组合视图取消订阅
    COMPOSE_VIEW_DELETED = 4,         // 组合视图被删除
    COMPOSE_VIEW_ALL_CLEARED = 5,     // 组合视图被清空
}

struct ComposeViewEvent {
    1:optional ComposeViewEventType type;
    2:optional i64 composeGraphId;
    3:optional set<i32> subUserIds;  // 事件中影响的子用户
}

/**
  * 合约版本变更事件
  */
struct ContractVersionChangedEvent {
    1:optional i64 eventTimestampMs;
}

/**
  * 交易账户信息
  */
enum TradeAccountEventType {
    TRADE_ACCOUNT_ADDED = 1,  // 交易账户添加
    TRADE_ACCOUNT_INFO_UPDATED = 2, // 交易账户信息修改, 主要是登陆用户名，密码，以及账户的属性信息
    TRADE_ACCOUNT_STATE_CHANGED = 3, // 账号的状态变更
    TRADE_ACCOUNT_DELETED = 4,        // 账号被物理删除
    TRADE_ACCOUNT_ACCESS_ENTRY_UPDATE = 5, // 交易账户对接的券商接入信息变更
	TRADE_ACCOUNT_ACCESS_STATE_CHANGED = 6,  // 账号接入状态和接入信息发生变更
	TRADE_ACCOUNT_ALL_CLEARD = 7,   // 所有账户被清除
	TRADE_ACCOUNT_ACCESS_DESCRIPTION_CHANGED = 8, // 账号接入状态的描述信息发生变更(状态为不可用时，描述信息发生变化)
}

struct TradeAccountEvent {
    1:optional TradeAccountEventType type;
    2:optional i64 tradeAccountId;
    
    // 账号被物理删除时
    3:optional trade_hosting_basic.HostingTradeAccount deletedTradeAccount;
}


enum OrderRouteTreeEventType {
    ORDER_ROUTE_TREE_CHANGED = 1,  // 用户的订单路由配置发生变更
    ORDER_ROUTE_TREE_ALL_CLEARD = 2, // 用户的订单路由配置全部清空，托管机清理数据时发生
}

struct OrderRouteTreeEvent {
    1:optional OrderRouteTreeEventType type;
    2:optional i64 subAccountId;
}

enum SubAccountRelatedInfoChangedEventType {
    RELATED_INFO_ALL_CLEARED = 1,
    RELATED_INFO_CHANGED = 2,
}

struct SubAccountRelatedInfoChangedEvent {
    1:optional SubAccountRelatedInfoChangedEventType type;
    2:optional i64 subAccountId;
}


/**
  * 执行订单上手通知事件
  */
struct UpsideOrderInsertFailedEvent {
    1:optional i64 execOrderId;
    2:optional i32 upsideErrorCode; // 上手携带的错误码
    3:optional string upsideErrorMsg;
    4:optional i64 eventCreateTimestampMs; 
    5:optional i32 mappingErrorCode; // 映射成的雪橇对应的错误码
}

struct UpsideOrderDeleteFailedEvent {
    1:optional i64 execOrderId;
    2:optional i32 upsideErrorCode;   // 上手携带的错误码
    3:optional string upsideErrorMsg;
    4:optional i64 eventCreateTimestampMs;
    5:optional i32 mappingErrorCode;  // 映射成的雪橇对应的错误码
}
  
struct UpsideNotifyForwardStateEvent {
    1:optional i64 execOrderId;
    2:optional trade_hosting_basic.HostingUpsideNotifyStateInfo forwardStateInfo;
    3:optional i64 receivedTimestampMs;  // 从上手收到事件的时间
    4:optional i64 eventCreateTimestampMs;  // 创建并发送到MessageBus的时间
}
  
// 成交事件
struct UpsideNotifyForwardTradeEvent {
    1:optional i64 execOrderId; // 成交对应的订单ID
    2:optional trade_hosting_basic.HostingExecTradeLegInfo forwardTradeLegInfo;  // 成交条目信息
    3:optional i64 receivedTimestampMs; // 从上手收到事件的时间
    4:optional i64 eventCreateTimestampMs;   // 创建并发送到MessageBus的时间
    5:optional trade_hosting_basic.HostingExecOrderLegContractSummary forwardTradeLegContractSummary; // 腿合约详情
}

// 状态同步事件
struct UpsideNotifySyncStateEvent {
    1:optional i64 execOrderId;
    2:optional trade_hosting_basic.HostingUpsideNotifyStateInfo syncStateInfo; // 同步的状态信息
    3:optional i64 syncReqTimestampMs;                 // 同步状态发起的时间
    4:optional i64 syncRespTimestampMs;                // 同步状态响应的时间
    5:optional i64 eventCreateTimestampMs;             // 事件创建的时间
    6:optional i32 upsideErrorCode;
    7:optional string upsideErrorMsg;
    8:optional i32 mappingErrorCode;
}

// 成交同步事件
struct UpsideNotifySyncTradeEvent {
    1:optional i64 execOrderId;
    2:optional list<trade_hosting_basic.HostingExecTradeLegInfo> syncTradeLegInfos; // 订单成交信息, 一次可能并不会携带全部
    3:optional i64 syncReqTimestampMs;             // 同步交易发起的时间
    4:optional i64 syncRespTimestampMs;            // 同步交易完成的时间
    5:optional i64 eventCreateTimestampMs;         // 事件创建的时间
    6:optional i32 upsideErrorCode;
    7:optional string upsideErrorMsg;
    8:optional string mappingErrorCode;
    9:optional trade_hosting_basic.HostingExecOrderLegContractSummary syncTradeLegContractSummary; // 同步腿合约详情
}

// 订单创建时间
struct ExecOrderCreatedEvent {
    1:optional trade_hosting_basic.HostingExecOrder createdOrder;
}

// 已经废弃, 订单创建时直接进行审核, 并携带相关事件
// 订单审核成功事件
//struct ExecOrderVerifySuccessEvent {
//    1:optional trade_hosting_basic.HostingExecOrder verifySuccessOrder;
//}

// 已经废弃
// 订单审核失败事件
//struct ExecOrderVerifyFailedEvent {
//    1:optional trade_hosting_basic.HostingExecOrder verifyFailedOrder;
//}

// 订单信息发生变化
struct ExecOrderRunningEvent {
    1:optional trade_hosting_basic.HostingExecOrder runningOrder;
}

// 成交列表变更事件,会引发订单的成交信息变化
struct ExecTradeListChangedEvent {
    1:optional trade_hosting_basic.HostingExecOrder execOrder;
    2:optional list<trade_hosting_basic.HostingExecTrade> newTradeList;  // 新成交的订单列表
}

// 执行订单过期, 从在途订单中清除
struct ExecOrderExpiredEvent {
    1:optional trade_hosting_basic.HostingExecOrder expiredOrder;
}

// 订单撤单超时时间，内部产生
struct ExecOrderRevokeTimeoutEvent {
    1:optional i64 execOrderId;
}

enum ExecOrderGuardType {
    GUARD_ORDER_CREATED = 0,
    GUARD_ORDER_VERIFY_SUCCESS = 1,
    GUARD_ORDER_VERIFY_FAILED = 2,
    GUARD_ORDER_RUNNING = 3,
    GUARD_ORDER_EXPIRED = 4,
    GUARD_ORDER_TRADE_LIST_CHANGED = 5,
}

// 订单可能出现变化的守护消息
struct ExecOrderGuardEvent {
    1:optional i64 guardExecOrderId;
    2:optional ExecOrderGuardType guardType;
}

