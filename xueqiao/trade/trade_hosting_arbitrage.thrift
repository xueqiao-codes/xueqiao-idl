/**
  * 雪橇订单接口定义
  */
namespace * xueqiao.trade.hosting.arbitrage.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_basic.thrift"

// 雪橇标的类型
enum HostingXQTargetType {
    CONTRACT_TARGET = 1,  // 合约标的
    COMPOSE_TARGET = 2,   // 组合标的
}

// 雪橇标的定义
struct HostingXQTarget {
    1:optional HostingXQTargetType targetType;
    2:optional string targetKey;  // 区分相同类型标的唯一Key
}

// 雪橇订单买卖方向
enum HostingXQTradeDirection {
    XQ_BUY = 0,   // 雪橇买
    XQ_SELL = 1,  // 雪橇卖
}

// 雪橇订单类型
enum HostingXQOrderType {
    XQ_ORDER_CONTRACT_LIMIT = 1,      // 雪橇合约限价单
    XQ_ORDER_CONTRACT_PARKED  = 2,    // 雪橇合约预埋单
    XQ_ORDER_CONDITION = 20,          // 雪橇条件单
    XQ_ORDER_COMPOSE_LIMIT = 30,      // 雪橇组合限价单
}

// 有效期类型
enum HostingXQEffectDateType {
    XQ_EFFECT_TODAY = 1,  // 当日有效
    XQ_EFFECT_PERIOD = 2,  // 指定时间段有效
    XQ_EFFECT_FOREVER = 3,  // 长期有效
}

// 雪橇有效期定义
struct HostingXQEffectDate {
    1:optional HostingXQEffectDateType type;
    2:optional i64 startEffectTimestampS;  // 有效的开始时间戳
    3:optional i64 endEffectTimestampS;    // 有效的结束时间戳
}

// 订单价格类型
enum HostingXQOrderPriceType {
    ACTION_PRICE_LIMIT = 1,    // 限价, 指定价
    ACTION_PRICE_LATEST = 2,   // 最新价
    ACTION_PRICE_IN_LINE = 3,  // 排队价
    ACTION_PRICE_OPPONENT = 4, // 对手价
}

// 订单价格控制
struct HostingXQOrderPrice {
    1:optional HostingXQOrderPriceType priceType; // 价格类型
    2:optional double limitPrice;  // 限价类型时有效
    3:optional i32  chasePriceTicks;     // 追价的TICK, 适合于合约追价
    4:optional double chasePriceValue;   // 追价的价位值, 适合于组合追价
}


// 条件触发价格类型
enum HostingXQConditionTriggerPriceType {
    XQ_ASK_PRICE = 1,   // 卖价
    XQ_BID_PRICE = 2,   // 买价
    XQ_LASTEST_PRICE = 3,  // 最新价
}

// 条件触发操作符
enum HostingXQConditionTriggerOperator {
    XQ_OP_LT = 1,   // 小于
    XQ_OP_LE = 2,   // 小于等于
    XQ_OP_EQ = 3,   // 等于
    XQ_OP_NE = 4,   // 不等于
    XQ_OP_GT = 5,   // 大于
    XQ_OP_GE = 6,  //  大于等于
}

// 条件触发器
struct HostingXQConditionTrigger {
    1:optional HostingXQConditionTriggerPriceType triggerPriceType;  // 触发价格类型
    2:optional HostingXQConditionTriggerOperator  triggerOperator;   // 触发比较操作符号
    3:optional double conditionPrice;  // 条件比较价
}

// 合约限价单条件
struct HostingXQContractLimitOrderDetail {
    1:optional HostingXQTradeDirection direction;
    2:optional double limitPrice;
    3:optional i32 quantity;
    4:optional HostingXQEffectDate effectDate; 
}

// 执行类型
enum HostingXQComposeLimitOrderExecType {
    LEG_BY_LEG = 1,   // 逐腿执行
    PARALLEL_LEG = 2,   // 并发执行
}

// 每条腿的额外发单条件
struct HostingXQComposeOrderLimitLegSendOrderExtraParam {
    1:optional double quantityRatio;   // 盘口系数, 如果不设置，则表示不关心盘口量系数
    2:optional double impactCost;  // 冲击成本值, 如果不设置，则表示不关心冲击成本
}

// 每条腿追单参数
struct HostingXQComposeLimitOrderLegChaseParam {
    1:optional i32 ticks;   // 下单追价Ticks
    2:optional i32 times;   // 追单次数限制，限制了挂撤单次数
    3:optional double protectPriceRatio; // 保护价格比例，买家应该不超过  触发价*(1+protectedPriceRatio), 卖价应该不低于 触发价*(1-protectedPriceRatio)
}

// 并发执行参数
struct HostingXQComposeLimitOrderParallelParams {
    1:optional map<i64, HostingXQComposeLimitOrderLegChaseParam> legChaseParams;  // 不同的腿的追单参数，覆盖默认参数, Key为合约ID
    2:optional map<i64, HostingXQComposeOrderLimitLegSendOrderExtraParam> legSendOrderExtraParam; // 不同腿的额外发单条件，覆盖默认参数， Key为合约ID
}

// 逐腿执行触发方式
enum HostingXQComposeLimitOrderLegByTriggerType {
    PRICE_BEST = 1,   // 到价触发， 目标价优于市场价
    PRICE_TRYING = 2,  // 价格尝试，有排队价优势时触发尝试
}

// 价格尝试时指定的参数
struct HostingXQComposeLimitOrderLegByPriceTryingParam {
    1:optional i32 beyondInPriceTicks;  // 价格由于排队价多少个Tick时尝试发单
}

// 先手腿额外参数
struct HostingXQComposeLimitOrderLegByFirstLegExtraParam {
    1:optional i32 revokeDeviatePriceTicks; // 撤单偏离价格容忍度，当目标价偏离原有挂单价多少Tick时进行撤单
}

enum HostingXQComposeLimitOrderFirstLegChooseMode {
    FIRST_LEG_CHOOSE_MODE_DEFAULT = 0,  // 系统默认的选择模式
    FIRST_LEG_CHOOSE_MODE_APPOINT = 1,  // 指定先手腿模式
    FIRST_LEG_CHOOSE_MODE_OUTER_DISC = 2,  // 外盘优先先手腿模式
}

struct HostingXQComposeLimitOrderFirstLegChooseParam {
    1:optional HostingXQComposeLimitOrderFirstLegChooseMode mode; // 先手腿选择模式
    2:optional i64 appointSledContractId;  // 指定先手腿模式下指定的先手合约
}

// 逐腿执行参数
struct HostingXQComposeLimitOrderLegByParams {
    1:optional HostingXQComposeLimitOrderLegByTriggerType legByTriggerType;   // 价格触发方式
    2:optional map<i64, HostingXQComposeLimitOrderLegByPriceTryingParam> firstLegTryingParams; // 价格尝试时，各腿作为先手腿的参数设置
    3:optional map<i64, HostingXQComposeOrderLimitLegSendOrderExtraParam> legSendOrderExtraParam; // 不同腿的额外发单条件， Key为合约ID
    4:optional map<i64, HostingXQComposeLimitOrderLegChaseParam> legChaseParams;  // 先后手追单参数限制, Key为合约ID
    5:optional HostingXQComposeLimitOrderFirstLegChooseParam firstLegChooseParam;  // 先手腿选择参数
    6:optional map<i64, HostingXQComposeLimitOrderLegByFirstLegExtraParam> firstLegExtraParams; // 先手腿所需的额外参数
}


// 组合单执行参数
struct HostingXQComposeLimitOrderExecParams {
    1:optional HostingXQComposeLimitOrderExecType execType;
    2:optional i32 execEveryQty; // 每次执行套数, 至少设置为1, 但不应该大于订单的量
    3:optional HostingXQComposeLimitOrderParallelParams execParallelParams;  // 并发执行所需的参数
    4:optional HostingXQComposeLimitOrderLegByParams execLegByParams; // 逐腿执行所需的参数
    5:optional i32 earlySuspendedForMarketSeconds;  // 提前收市暂停时间的秒数
}

// 组合条件单参数
struct HostingXQComposeLimitOrderDetail {
    1:optional HostingXQTradeDirection direction;
    2:optional double limitPrice;
    3:optional i32 quantity;
    4:optional HostingXQEffectDate effectDate;
    5:optional HostingXQComposeLimitOrderExecParams execParams;
}

// 条件额外参数
struct HostingXQConditionActionExtra {
    1:optional HostingXQComposeLimitOrderExecParams composeLimitExecParams;  // 组合执行的额外参数
}

// 条件触发后的下单动作
struct HostingXQConditionAction {
    1:optional HostingXQOrderType orderType;     // 订单类型
    2:optional HostingXQTradeDirection tradeDirection;  // 交易买卖方向
    3:optional HostingXQOrderPrice price;  // 下单价格
    4:optional i32 quantity;   // 下单量
    5:optional HostingXQConditionActionExtra extra;  // 额外参数
}

// 条件定义
struct HostingXQCondition {
    1:optional HostingXQConditionTrigger conditionTrigger;  // 条件触发器定义
    2:optional HostingXQConditionAction conditionAction;    // 条件触发后的下单行为
}

// 条件单标签
enum HostingXQConditionOrderLabel {
    LABEL_NONE = 0,  // 无标签
    LABEL_STOP_LOST_BUY = 1,  // 止损买入
    LABEL_STOP_LOST_SELL = 2,  // 止损卖出
    LABEL_STOP_PROFIT_BUY = 3, // 止盈买入
    LABEL_STOP_PROFIT_SELL = 4, // 止盈卖出
    LABEL_STOP_BUY = 5,  // 止损止盈买入
    LABEL_STOP_SELL = 6,  // 止损止盈卖出
}

// 雪橇条件单详情
struct HostingXQConditionOrderDetail {
    1:optional HostingXQEffectDate effectDate;       //有效期定义 
    2:optional list<HostingXQCondition> conditions;  //条件定义列表，优先级按照从前到后
    3:optional HostingXQConditionOrderLabel label;   //条件单的标签
}

// 雪橇合约预埋单详情
struct HostingXQContractParkedOrderDetail {
    1:optional HostingXQTradeDirection direction;
    2:optional HostingXQOrderPrice price;
    3:optional i32 quantity;
}


// 雪橇订单详情
struct HostingXQOrderDetail {
    1:optional HostingXQContractLimitOrderDetail contractLimitOrderDetail; // 雪橇合约限价单有效
    2:optional HostingXQComposeLimitOrderDetail composeLimitOrderDetail;   // 雪橇组合限价单有效
    3:optional HostingXQConditionOrderDetail conditionOrderDetail;        // 雪橇条件单有效
    4:optional HostingXQContractParkedOrderDetail contractParkedOrderDetail; // 雪橇合约预埋单有效
}

// 订单暂停的原因
enum HostingXQSuspendReason {
    SUSPENDED_REASON_NONE = 0, 
    SUSPENDED_BY_PERSON = 1,  // 人工暂停
    SUSPENDED_FUNCTIONAL = 2,     // 功能性暂停
    SUSPENDED_ERROR_OCCURS = 3,  // 异常发生导致暂停
}

// 雪橇订单状态
enum HostingXQOrderStateValue {
    XQ_ORDER_CREATED = 1,   // 雪橇订单被创建
    XQ_ORDER_CANCELLED = 2,  // 雪橇订单已撤单
    XQ_ORDER_CANCELLING = 3, // 雪橇订单撤单中
    XQ_ORDER_SUSPENDED = 4,  // 雪橇订单被暂停
    XQ_ORDER_SUSPENDING = 5, // 雪橇订单暂停中
    XQ_ORDER_RUNNING = 6,   // 雪橇订单运行中
    XQ_ORDER_STARTING = 7,  // 订单启动中
    XQ_ORDER_FINISHED = 8,   // 雪橇订单已完成
    XQ_ORDER_FINISHING = 9   // 雪橇订单完成中，主要是做订单的完成前工作
}

/**
  * 订单恢复运行的模式
  */
enum HostingXQOrderResumeMode {
    RESUME_MODE_NONE = 0,   // 无继续模式，默认行为
    RESUME_MODE_COMPOSE_CHASING_BY_PRICE = 1,  // 组合按照价差进行追单
    RESUME_MODE_COMPOSE_CHASING_WITHOUT_COST = 2,  // 组合不计成本进行追单
}

// 雪橇订单状态
struct HostingXQOrderState {
    1:optional HostingXQOrderStateValue stateValue;
    2:optional i64 stateTimestampMs;
    3:optional HostingXQSuspendReason suspendReason;
    5:optional i32 suspendedErrorCode; // 异常暂停的错误码
    6:optional i32 cancelledErrorCode;  // 导致订单撤单的错误码
    7:optional string stateMsg; // 状态描述消息
    8:optional string execUsefulMsg; // 执行有用信息
    9:optional bool effectIndexCleaned; // 有效索引已清理
    10:optional HostingXQOrderResumeMode resumeMode; // 订单下次恢复运行时的模式
}

// 雪橇子成交概要
struct HostingXQSubTradeSummary {
    1:optional HostingXQTarget subTarget;
    2:optional i32 subTradeVolume;
    3:optional double subTradeAveragePrice;
}

// 雪橇成交摘要
struct HostingXQTradeSummary {
    1:optional i32 totalVolume; // 成交列表成交总量
    2:optional double averagePrice; // 成交列表平均均价
    3:optional map<string, HostingXQSubTradeSummary> subTradeSummaries; // 子成交列表
}

// 雪橇订单
struct HostingXQOrder {
    1:optional string orderId;  // 雪橇订单ID
    2:optional i32 subUserId;   // 子用户
    3:optional i64 subAccountId; // 子账号
    4:optional HostingXQOrderType orderType;     // 订单类型
    5:optional HostingXQTarget orderTarget;      // 订单操作标的
    6:optional HostingXQOrderDetail orderDetail; // 订单详情
    7:optional HostingXQOrderState orderState;   // 订单状态
    8:optional HostingXQTradeSummary orderTradeSummary; // 订单成交摘要
    9:optional i32 version;
    10:optional i64 createTimestampMs;
    11:optional i64 lastmodifyTimestampMs;
    12:optional string sourceOrderId;   // 如果是条件触发产生的订单，则会具备该字段，表明引向的条件单
    13:optional string actionOrderId;   // 如果是条件单，则表示触发产生后的条件单
    14:optional i64 gfdOrderEndTimestampMs;  // 如果是当日有效的订单，则该值为计算订单过期结束的时间
}

// 雪橇成交
struct HostingXQTrade {
    1:optional string orderId;  // 雪橇成交所属雪橇订单
    2:optional i64 tradeId;  // 雪橇成交ID
    3:optional HostingXQTarget tradeTarget; // 成交的标的
    4:optional i32 tradeVolume; // 成交量
    5:optional double tradePrice; // 成交价
    6:optional i32 subUserId;  // 下单子用户
    7:optional i64 subAccountId; // 子账号
    9:optional HostingXQTradeDirection tradeDiretion; // 成交方向
    10:optional HostingXQTarget sourceOrderTarget;    // 原订单标的
    
    12:optional i64 createTimestampMs;
    13:optional i64 lastmodifyTimestampMs;
}

struct HostingEffectXQOrderIndexItem {
    1:optional string orderId;
    2:optional i32 subUserId;
    3:optional i64 subAccountId;
}

struct QueryEffectXQOrderIndexOption {
    1:optional set<i32> subUserIds;   // 创建的子用户列表
    2:optional set<i64> subAccountIds;  // 所属的子账户列表
    3:optional set<string> orderIds;  // 雪橇订单ID列表
}

struct QueryEffectXQOrderIndexPage {
    1:optional i32 totalNum;
    2:optional list<HostingEffectXQOrderIndexItem> resultIndexItems;
}

// 雪橇成交关联数据
struct HostingXQTradeRelatedItem {
    1:optional string orderId;  // 雪橇订单ID
    2:optional i64 tradeId;  // 雪橇成交ID
    3:optional i64 execOrderId;  // 关联执行成交的执行订单ID
    4:optional i64 execTradeId;  // 关联执行成交ID
    5:optional i64 execTradeLegId;  // 关联执行成交腿ID
    6:optional trade_hosting_basic.HostingExecTradeDirection execTradeLegDirection; // 执行成交腿的买卖方向
    7:optional i32 execTradeLegVolume;  // 执行成交腿的成交数量
    8:optional double execTradeLegPrice;  // 执行成交腿的成交价格
    9:optional i32 relatedTradeVolume;  // 关联实际使用的量
    10:optional i64 sledContractId;  // 对应的雪橇合约ID
    11:optional i64 createTimestampMs;  // 关联数据的创建时间
}

struct HostingXQOrderExecDetail {
    1:optional HostingXQOrder xqOrder;             // 雪橇订单详情
    2:optional list<HostingXQTrade> xqTrades;      // 雪橇成交列表
    3:optional list<trade_hosting_basic.HostingExecOrder> execOrders;  // 关联执行订单
    4:optional list<trade_hosting_basic.HostingExecTrade> execTrades;  // 关联执行成交
    5:optional map<i64, list<HostingXQTradeRelatedItem>> xqTradeRelatedItems; // 雪橇成交关联条目信息
}

struct HostingXQOrderWithTradeList {
    1:optional HostingXQOrder order;
    2:optional list<HostingXQTrade> tradeList;
}

const string SYSTEM_SETTING_KEY = "SYS"

/**
  * 针对组合限价单的设置
  */
struct HostingXQComposeLimitOrderSettings {
    1:optional i32 defaultChaseTicks;   // 默认的追价点数
    2:optional i32 maxChaseTicks;  // 最大的追价点数(用户订单中设置的追加点数不能高于此)
    
    3:optional i32 maxInvolRevokeLimitNum; // 最大内盘的撤单次数限制(用户订单中设置的内盘撤单次数不能大于此)
    4:optional i32 defaultInvolRevokeLimitNum; // 默认内盘撤单次数限制
    
    5:optional double defaultQuantityRatio;   // 默认发单盘口设置
    6:optional double minQuantityRatio;       // 最小的发单盘口设置(用户订单中设置的盘口比例不得低于此)
    
    7:optional double defaultPriceProtectRatio;  // 默认追价保护的比例
    8:optional double maxPriceProtectRatio;  // 最大的追价保护比例(用户订单中设置的价格保护比例不得高于此)
}


/*
 * 套利服务
 */
service(713) TradeHostingArbitrage {
    // 创建雪橇订单
    void 1:createXQOrder(1:comm.PlatformArgs platformArgs
            , 2:HostingXQOrder order) throws (1:comm.ErrorInfo err);
    
    // 撤销雪橇订单
    void 2:cancelXQOrder(1:comm.PlatformArgs platformArgs, 2:string orderId) throws (1:comm.ErrorInfo err);
    
    // 暂停雪橇订单
    void 3:suspendXQOrder(1:comm.PlatformArgs platformArgs
            , 2:string orderId) throws (1:comm.ErrorInfo err);
    
    // 恢复雪橇订单        
    void 4:resumeXQOrder(1:comm.PlatformArgs platformArgs
            , 2:string orderId
            , 3:HostingXQOrderResumeMode resumeMode) throws (1:comm.ErrorInfo err);
    
    // 查询未清理的有效订单
    QueryEffectXQOrderIndexPage 5:getEffectXQOrderIndexPage(1:comm.PlatformArgs platformArgs
            , 2:QueryEffectXQOrderIndexOption qryOption
            , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    // 批量查询订单       
    map<string, HostingXQOrder> 6:getXQOrders(1:comm.PlatformArgs platformArgs
            , 2:set<string> orderIds) throws (1:comm.ErrorInfo err);
            
    // 根据订单ID批量查询订单成交列表
    map<string, list<HostingXQTrade>> 7:getXQTrades(1:comm.PlatformArgs platformArgs
            , 2:set<string> orderIds) throws (1:comm.ErrorInfo err);
            
    // 批量查询订单和成交内容
    map<string, HostingXQOrderWithTradeList> 8:getXQOrderWithTradeLists(
            1:comm.PlatformArgs platformArgs
            , 2:set<string> orderIds) throws (1:comm.ErrorInfo err);
    
    // 查询订单执行详情
    HostingXQOrderExecDetail 9:getXQOrderExecDetail(1:comm.PlatformArgs platformArgs
            , 2:string orderId) throws (1:comm.ErrorInfo err);
    
    // 清空所有数据, 托管机重置
    void 10:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    // 查询成交,同时采用成交ID过滤
    map<i64, HostingXQTrade> 11:filterXQTrades(1:comm.PlatformArgs platformArgs
            , 2:set<string> orderIds
            , 3:set<i64> tradeIds) throws (1:comm.ErrorInfo err);
            
    // 查询成交关联数据信息
    list<HostingXQTradeRelatedItem> 12:getXQTradeRelatedItems(1:comm.PlatformArgs platformArgs
            , 2:string orderId
            , 3:i64 tradeId) throws (1:comm.ErrorInfo err);
            
    // 获取系统组合限价单设置
    HostingXQComposeLimitOrderSettings 13:getSystemXQComposeLimitOrderSettings(
            1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
            
    // 更新系统组合限价单设置
    void 14:setSystemXQComposeLimitOrderSettings(
            1:comm.PlatformArgs platformArgs
            , 2:HostingXQComposeLimitOrderSettings settings) throws (1:comm.ErrorInfo err);        
}



