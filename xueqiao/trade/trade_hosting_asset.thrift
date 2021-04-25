/**
  * 资产结算的服务入口
  */
namespace * xueqiao.trade.hosting.asset.thriftapi

include "../../comm.thrift"
include "trade_hosting_basic.thrift"
include "../../page.thrift"
include "trade_hosting_position_adjust_assign.thrift"

/**
  * 托管机子账户资金信息
  */
struct HostingSubAccountFund {
    1:optional i64 subAccountId;        // 托管机子账户ID
    2:optional string currency;         // 币种
    3:optional double balance;          // 余额
    6:optional double depositAmount;    // 子账户入金总和
    7:optional double withdrawAmount;   // 子账户出金总和
    8:optional double creditAmount;     // 信用额度[对应币种]
    
    10:optional i64 createTimestampMs;
    11:optional i64 lastModifyTimestampMs;
}

/**
  * 出入金方向
  */
enum HostingSubAccountMoneyRecordDirection {
    DEPOSIT = 1,   // 入金
    WITHDRAW = 2,  // 出金
}

/**
  * 托管机出入金记录
  */
struct HostingSubAccountMoneyRecord {
    1:optional i64 subAccountId;            // 子账户
    2:optional HostingSubAccountMoneyRecordDirection direction; // 出入金方向
    3:optional double totalAmount;          // 单次出入金金额
    5:optional double depositAmountBefore;  // 操作之前入金总和
    6:optional double depositAmountAfter;   // 操作之后入金总和
    7:optional double withdrawAmountBefore; // 操作之前出金总和
    8:optional double withdrawAmountAfter;  // 操作之后出金总和
    9:optional i64 recordTimestampMs;       // 记录发生时间
    10:optional string ticket;              // 票据, 避免多次操作
    11:optional string currency;            // 币种
    20:optional i64 createTimestampMs;
    21:optional i64 lastModifyTimestampMs;
}

/**
  * 手续费, 保证金的计算方式(来源: 商品信息或者用户设置)
  */
enum CalculateMode{
    PERCENTAGE = 1,     // 按比例
    QUOTA =2,           // 按固定值
    COMBINE = 3,        // 按固定值+比例
}

enum TradeDetailSource{
    XQ_TRADE = 0,   // 雪橇内部成交
    ASSIGN = 1,     // 成交分配
}

// 保证金
struct Margin {
    1:optional double longMarginRatioByMoney;    // 按金额多仓保证金
    2:optional double longMarginRatioByVolume;   // 按手数多仓保证金
    3:optional double shortMarginRatioByMoney;   // 按金额空仓保证金
    4:optional double shortMarginRatioByVolume;  // 按手数空仓保证金
    5:optional string currency;                  // 币种
    6:optional string currencyGroup;             // 币种组
    7:optional double currencyRate;              // 1手续费币种 兑换 雪橇商品币种
}

// 手续费
struct CommissionFee {
    1:optional double openRatioByMoney;              // 按金额开仓手续费费率
    2:optional double openRatioByVolume;             // 按手数开仓手续费费率
    3:optional double closeRatioByMoney;             // 按金额平昨手续费费率
    4:optional double closeRatioByVolume;            // 按手数平昨手续费费率
    5:optional double closeTodayRatioByMoney;        // 按金额平今手续费费率
    6:optional double closeTodayRatioByVolume;       // 按手数平今手续费费率
    7:optional string currency;                      // 币种
    8:optional string currencyGroup;                 // 币种组
    9:optional double currencyRate;                  // 1手续费币种 兑换 雪橇商品币种
}

/**
  * 计算参数
  * 成交时的商品设置信息, 做存档排查(来源: 商品信息或者用户设置) 
  */
struct AssetCalculateConfig{
    1:optional i64 sledCommodityId;      // 雪橇商品id
    2:optional string currency;          // 成交的币种
    3:optional double contractSize;      // 合约乘数
    4:optional double chargeUnit;        // 计价单位

    10:optional CommissionFee commissionFee;    // 手续费率
    11:optional Margin margin;            // 保证金费率
    12:optional i64 sledContractId;      // 雪橇合约id

    // *** 废弃，使用资金账户和用户设定的费率 ***
    5:optional double openCloseFee;      // 手续费计算因子 
    6:optional double initialMargin;     // 多头开仓保证金计算因子
    7:optional double sellInitialMargin; // 空头开仓保证金计算因子
    8:optional CalculateMode commissionCalculateMode;   // 手续费计算方式
    9:optional CalculateMode marginCalculateMode;       // 保证金计算方式
    // **** 废弃 ****
}

/**
  * 资源结算层面的成交明细（从成交列表中的成交明细转换成适合结算用的成交明细）
  */
struct AssetTradeDetail{
    1:optional i64 execTradeId;         // 内部成交ID, 唯一
    2:optional i64 subAccountId;        // 子账户ID
    3:optional i64 sledContractId;      // 雪橇合约id
    4:optional i64 execOrderId;         // 成交对应的执行订单ID

    5:optional double tradePrice;       // 成交价
    6:optional i32 tradeVolume;         // 成交量
    7:optional trade_hosting_basic.HostingExecTradeDirection execTradeDirection; // 成交买卖方向
    8:optional i64 createTimestampMs;        
    9:optional i64 lastmodifyTimestampMs;
    
    10:optional i64 sledCommodityId;      // 雪橇商品id
    11:optional AssetCalculateConfig config;    // 计算参数设置信息
    12:optional i32 orderTotalVolume;           // 总下单量
    13:optional double limitPrice;              // 下单价（如果是组合合约，则是价差）
    14:optional string source;            // 成交来源

    15:optional i64 tradeAccountId;       // 资金账号id
    16:optional i64 tradeTimestampMs;     // 成交时间

    17:optional i64 assetTradeDetailId;   // 成交明细id(导入该明细时生成ID, 唯一)

    18:optional i32 subUserId;            // 子用户id
    19:optional string sledOrderId;       // 雪橇订单id
}

/**
  * 子账号合约持仓结算明细
  */
struct SettlementPositionDetail{
    1:optional i64 settlementId;        // 结算id
    2:optional i64 sledContractId;      // 雪橇合约id
    3:optional i64 subAccountId;        // 子账户ID
    4:optional i64 position;            // 持仓量
    5:optional double positionAvgPrice; // 持仓均价
    6:optional double positionProfit;   // 持仓盈亏
    7:optional double calculatePrice;   // 计算价格
    
    9:optional string currency;         // 币种
    11:optional i64 sledCommodityId;    // 雪橇商品id
    
    12:optional i64 prevPosition;        // 上日持仓量
    13:optional i64 longPosition;        // 多头仓量
    14:optional i64 shortPosition;       // 空头仓量
    15:optional double closeProfit;      // 平仓盈亏

    16:optional double goodsValue;              // 货值
    17:optional double leverage;                // 杠杆

    18:optional double useMargin;               // 占用保证金
    19:optional double useCommission;           // 占用手续费

    30:optional i64 createTimestampMs;
    31:optional i64 lastmodifyTimestampMs;
}

/**
  * 子账号资金结算时的资金明细
  */
struct SettlementFundDetail{
    1:optional i64 settlementId;                // 结算id
    2:optional i64 subAccountId;                // 子账户ID
    3:optional double preFund;                  // 上次结余资金
    4:optional string currency;                 // 币种
    5:optional i64 settlementTimestamp;         // 结算时间
    6:optional double depositAmount;            // 入金量
    7:optional double withdrawAmount;           // 出金量
    8:optional double closeProfit;              // 平仓盈亏
    9:optional double useMargin;                // 占用保证金
    10:optional double useCommission;           // 占用手续费
    11:optional i64 createTimestampMs;
    12:optional i64 lastModifyTimestampMs;
    13:optional double balance;                 // 本次结余资金
    14:optional i64 exchangeRateHistoryId;      // 汇率历史id

    16:optional double goodsValue;              // 货值
    17:optional double leverage;                // 杠杆
}

/**
  * 子账号实时某一时刻的资金
  */
struct HostingFund{
    1:optional i64 subAccountId;                // 子账户ID
    2:optional double preFund;                  // 上次结存资金
    3:optional double depositAmount;            // 入金总额
    4:optional double withdrawAmount;           // 出金总额
    5:optional double closeProfit;              // 平仓盈亏
    6:optional double positionProfit;           // 持仓盈亏
    7:optional double useMargin;                // 占用保证金
    8:optional double frozenMargin;             // 冻结保证金
    9:optional double useCommission;            // 手续费
    10:optional double frozenCommission;        // 冻结手续费
    11:optional double availableFund;           // 可用资金
    12:optional double dynamicBenefit;          // 动态权益
    13:optional double riskRate;                // 风险度
    14:optional string currency;                // 币种
    15:optional double creditAmount;            // 信用额度

    16:optional double goodsValue;              // 货值
    17:optional double leverage;                // 杠杆

    21:optional i64 createTimestampMs;
    22:optional i64 lastModifyTimestampMs; 
}

/**
  * 雪橇合约持仓量信息
  */
struct HostingPositionVolume{
    1:optional i64 sledContractId;      // 雪橇合约id
    2:optional i64 subAccountId;        // 子账户ID
    3:optional i64 prevPosition;        // 上日持仓量
    4:optional i64 longPosition;        // 多头仓量
    5:optional i64 shortPosition;       // 空头仓量
    6:optional i64 netPosition;         // 净仓量
    7:optional double useCommission;    // 手续费
    8:optional double closeProfit;      // 平仓盈亏
    10:optional double positionAvgPrice;// 持仓均价
    11:optional string currency;         // 币种

    29:optional i64 createTimestampMs;
    30:optional i64 lastModifyTimestampMs;
}

/**
  * 雪橇合约资金根据不同价格计算变动信息
  */
struct HostingPositionFund{
    1:optional i64 sledContractId;      // 雪橇合约id
    2:optional i64 subAccountId;        // 子账户ID
    9:optional double positionProfit;   // 持仓盈亏
    11:optional double calculatePrice;   // 计算价格
    12:optional double useMargin;        // 占用保证金
    13:optional double frozenMargin;     // 冻结保证金
    15:optional double frozenCommission; // 冻结手续费
    16:optional string currency;         // 币种

    17:optional double goodsValue;       // 货值
    18:optional double leverage;         // 杠杆
}

/**
  * 实时某一时刻雪橇合约持仓
  */
struct HostingSledContractPosition{
    1:optional i64 sledContractId;      // 雪橇合约id
    2:optional i64 subAccountId;        // 子账户ID
    3:optional i64 sledCommodityId;     // 雪橇商品id
    4:optional string currency;         // 币种
    5:optional HostingPositionVolume positionVolume;
    6:optional HostingPositionFund positionFund;
}

struct ReqMoneyRecordOption{
    1:optional i64 subAccountId;
    2:optional i64 startTimestampMs;        // 在这个时间点之后的记录
    3:optional i64 endTimestampMs;          // 在这个时间段之前的记录
    4:optional string currency;             // 币种
}

struct ReqSubAccountFundOption{
    1:optional i64 subAccountId;
    2:optional string currency;             // 币种
}

struct ReqSettlementPositionDetailOption{
    1:optional i64 sledContractId;
    2:optional i64 subAccountId;
    3:optional i64 startTimestampMs;
    4:optional i64 endTimestampMs;
}

struct ReqHostingSledContractPositionOption{
    1:optional i64 subAccountId;
    2:optional set<i64> sledContractIds;
}

struct ReqHostingFundOption{
    1:optional set<i64> subAccountIds;
    2:optional bool baseCurrency;
}

struct FundChange{
    1:optional i64 subAccountId;
    2:optional string currency;
    3:optional double amount;
    4:optional HostingSubAccountMoneyRecordDirection direction;
    5:optional string ticket;
}

struct HostingSledContractPositionPage{
    1:optional i32 total;
    2:optional list<HostingSledContractPosition> page;
}

struct HostingFundPage{
    1:optional i32 total;
    2:optional list<HostingFund> page;
}

struct CreditAmountChange{
    1:optional i64 subAccount;
    2:optional string currency;
    3:optional double totalAmount;
}

struct SettlementFundDetailPage{
    1:optional i32 total;
    2:optional list<SettlementFundDetail> page;
}

struct HostingSubAccountMoneyRecordPage{
    1:optional i32 total;
    2:optional list<HostingSubAccountMoneyRecord> page;
}

struct SettlementPositionDetailPage{
    1:optional i32 total;
    2:optional list<SettlementPositionDetail> page;
}

struct ReqHostingAssetTradeDetailOption{
    1:optional i64 subAccountId;
    2:optional i64 sledContractId;
}

struct ReqSettlementPositionTradeDetailOption{
    1:optional i64 settlementId;
    2:optional i64 sledContractId;
}

struct AssetTradeDetailPage{
    1:optional i32 total;
    2:optional list<AssetTradeDetail> page;
}

struct ReqHostingPositionVolumeOption{
    1:optional i64 subAccountId;
    2:optional set<i64> sledContractId;
}

struct HostingPositionVolumePage{
    1:optional i32 total;
    2:optional list<HostingPositionVolume> page;
}

struct ReqHostingPositionFundOption{
    1:optional i64 subAccountId;
    2:optional set<i64> sledContractId;
}

struct HostingPositionFundPage{
    1:optional i32 total;
    2:optional list<HostingPositionFund> page;
}


/* ====资金账户==== */

/* 资金账户的雪橇持仓 */
struct TradeAccountPosition{
    1:optional i64 tradeAccountId;
    2:optional map<i64,i32> sledContractNetPositionMap;
    20:optional i64 createTimestampMs;
    21:optional i64 lastModifyTimestampMs;
}

struct TradeAccountPositionTable{
    1:optional i64 tradeAccount;
    2:optional i64 sledContractId;
    3:optional i32 netPosition;
    4:optional i64 createTimestampMs;
    5:optional i64 lastModifyTimestampMs;
}

struct ReqTradeAccountPositionTradeDetailOption{
    1:optional i64 tradeAccountId;
    2:optional i64 sledContractId;

    10:optional i64 startTradeTimestampMs;
    11:optional i64 endTradeTimestampMs;
}

struct ReqTradeAccountPositionOption{
    1:optional i64 tradeAccountId;
}

struct TradeAccountPositionPage{
    1:optional i32 total;
    2:optional list<TradeAccountPosition> page;
}

struct ReqSubAccountFundHistoryOption{
	1:optional i64 subAccountId;
	2:optional i64 startTimestampMs;
	3:optional i64 endTimestampMs;
	4:optional bool baseCurrency;
}

struct PositionAssignHistory{
    1:optional i64 assignId;
    2:optional string content;
    3:optional i64 createTimestampMs;
    4:optional i64 lastModifyTimestampMs;
}

service(714) TradeHostingAsset {
    
    /**
     *  查询实时雪橇合约持仓信息
     */
    HostingSledContractPositionPage 1:getHostingSledContractPosition(1:comm.PlatformArgs platformArgs, 2:ReqHostingSledContractPositionOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询子账号实时资金
     */
    HostingFundPage 2:getHostingSubAccountFund(1:comm.PlatformArgs platformArgs, 2:ReqHostingFundOption option) throws (1:comm.ErrorInfo err);

    /**
     *  子账号出入金
     */
    HostingSubAccountFund 3:changeSubAccountFund(1:comm.PlatformArgs platformArgs, 2:FundChange fundChange) throws (1:comm.ErrorInfo err);

    /**
     *  子账号设置信用额度
     */
    HostingSubAccountFund 4:setSubAccountCreditAmount(1:comm.PlatformArgs platformArgs, 2:CreditAmountChange amountChange) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号持仓结算信息
     */
    SettlementPositionDetailPage 5:getSettlementPositionDetail(1:comm.PlatformArgs platformArgs, 2:ReqSettlementPositionDetailOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号出入金记录
     */
    HostingSubAccountMoneyRecordPage 6:getHostingSubAccountMoneyRecord(1:comm.PlatformArgs platformArgs, 2:ReqMoneyRecordOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询实时雪橇合约持仓明细信息
     */
    AssetTradeDetailPage 8:getAssetPositionTradeDetail(1:comm.PlatformArgs platformArgs, 2:ReqHostingAssetTradeDetailOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号持仓结算的成交明细信息
     */
    AssetTradeDetailPage 9:getSettlementPositionTradeDetail(1:comm.PlatformArgs platformArgs, 2:ReqSettlementPositionTradeDetailOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的雪橇合约持仓量
     */
    HostingPositionVolumePage 10:getHostingPositionVolume(1:comm.PlatformArgs platformArgs, 2:ReqHostingPositionVolumeOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的雪橇合约实时持仓资金
     */
    HostingPositionFundPage 11:getHostingPositionFund(1:comm.PlatformArgs platformArgs, 2:ReqHostingPositionFundOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的历史资金信息
     */
    HostingFundPage 12:getSubAccountFundHistory(1:comm.PlatformArgs platformArgs, 2:ReqSubAccountFundHistoryOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  删除操作账号中过期合约的持仓(合约已经过期，而持仓在其他地方平掉，但是在雪橇的操作账号中依然显示存在)
     */
    void 13:deleteExpiredContractPosition(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId 3:i64 sledContractId) throws (1:comm.ErrorInfo err);

    // ======================== 资金账户 =============================
    /**
     *  查询雪橇合约资金账户持仓的成交明细信息
     */
    AssetTradeDetailPage 20:getTradeAccountPositionTradeDetail(1:comm.PlatformArgs platformArgs, 2:ReqTradeAccountPositionTradeDetailOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询资金账户实时持仓
    TradeAccountPositionPage 21:getTradeAccountPosition(1:comm.PlatformArgs platformArgs, 2:ReqTradeAccountPositionOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 分配持仓给子账户
    trade_hosting_position_adjust_assign.AssignPositionResp 22:assignPosition(1:comm.PlatformArgs platformArgs, 2:list<trade_hosting_position_adjust_assign.PositionAssigned> positonAssigneds) throws (1:comm.ErrorInfo err);

    // ======================== 重置数据 =============================
    /**
     *  移除托管机上持仓资金的所有数据记录
     */
    void 99:removeAllAssetData(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}
