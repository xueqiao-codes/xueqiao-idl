/**
  * 上手接入的接口描述
  */
namespace * xueqiao.trade.hosting.upside.entry

include "../../comm.thrift"

include "trade_hosting_basic.thrift"
include "trade_hosting_upside_position.thrift"

struct TSubProcessTimeInfo {
    1:optional i32 startTimestamp;
    2:optional i32 exitedTimestamp;
}

struct TSubProcessInfo {
    1:optional i64 tradeAccountId;
    2:optional i32 pid;
    3:optional list<TSubProcessTimeInfo> timeInfos;
}

struct TSyncOrderStateBatchReq {
    1:optional trade_hosting_basic.HostingExecOrderTradeAccountSummary accountSummary;
    2:optional trade_hosting_basic.CTPContractSummary ctpContractSummary;
    3:optional trade_hosting_basic.ESunny3ContractSummary esunny3ContractSummary;
    4:optional trade_hosting_basic.ESunny9ContractSummary esunny9ContractSummary;
}

// 资金信息
struct TFund {
    2:optional string currencyNo;      // 币种, CNY,USD...
    3:optional string currencyChannel; // 币种渠道, 默认渠道为DEFAULT
    4:optional double credit;      // 信用额度
    5:optional double preBalance;  // 上次结算准备金
    6:optional double deposit;     // 入金金额
    7:optional double withdraw;    // 出金金额
    8:optional double frozenMargin; // 冻结保证金
    9:optional double frozenCash;  // 冻结手续费
    10:optional double currMargin;  // 保证金
    11:optional double commission; // 手续费
    12:optional double closeProfit;  // 平仓盈亏
    13:optional double positionProfit;  // 持仓盈亏
    14:optional double available;    // 可用资金
    15:optional double dynamicBenefit;  // 动态权益
    16:optional double riskRate;        // 风险度
}

// 结算信息
struct TSettlementInfo {
    2:optional string settlementDate;  // 结算日期，格式为XXXX-XX-XX
    3:optional string settlementContent;  // 结算单内容
}

// 净仓信息
struct TNetPositionSummary {
    2:optional string  sledExchangeCode;  // 雪橇交易所编码           
    3:optional i16     sledCommodityType;  // 雪橇商品类型
    4:optional string  sledCommodityCode;  // 雪橇商品编码
    5:optional i64     sledCommodityId;    // 雪橇商品ID
    6:optional string  sledContractCode;   // 雪橇合约编码
    7:optional i64     netVolume;          // 净仓量
    8:optional double  averagePrice;       // 净仓均价
}

// 持仓信息
struct TPositionInfo {
    2:optional string  sledExchangeCode;  // 雪橇交易所编码           
    3:optional i16     sledCommodityType;  // 雪橇商品类型
    4:optional string  sledCommodityCode;  // 雪橇商品编码
    5:optional i64     sledCommodityId;    // 雪橇商品ID
    6:optional string  sledContractCode;   // 雪橇合约编码
    7:optional i64     netVolume;          // 净仓量
    8:optional double  averagePrice;       // 净仓均价

    9:optional i64     ydVolume;        // 上日持仓
    10:optional i64    tdBuyVolume;     // 今日长仓
    11:optional i64    tdSellVolume;    // 今日短仓
    12:optional double positionProfit;  // 持仓盈亏
    13:optional double closeProfit;     // 平仓盈亏
    14:optional double calculatePrice;  // 计算价, 也是最新价
    15:optional double useMargin;       // 持仓保证金
    16:optional double fronzenMargin;   // 冻结保证金
    17:optional double commission;      // 手续费
    18:optional double fronzenCommission; // 冻结手续费
    
    19:optional double goodsValue;    // 货值
    20:optional double leverage;      // 杠杆率
    21:optional string currencyNo;    // 币种
    
}

struct TPositionCTPExchangeMarginRate {
    1:optional double  longMarginRatioByMoney;
    2:optional double  longMarginRatioByVolume;
    3:optional double  shortMarginRatioByMoney;
    4:optional double  shortMarginRatioByVolume;
}

struct TPositionCTPInstrumentMarginRate {
    1:optional double  longMarginRatioByMoney;
    2:optional double  longMarginRatioByVolume;
    3:optional double  shortMarginRatioByMoney;
    4:optional double  shortMarginRatioByVolume;
    5:optional bool    isRelative;  // 是否相对交易所保证金收取
}

struct TPositionCTPMarginRate {
    1:optional TPositionCTPExchangeMarginRate exchangeMarginRate;
    2:optional TPositionCTPInstrumentMarginRate instrumentMarginRate;
}

struct TPositionCTPCommissionRate {
    1:optional double openRatioByMoney;
    2:optional double openRatioByVolume;
    3:optional double closeRatioByMoney;
    4:optional double closeRatioByVolume;
    5:optional double closeTodayRatioByMoney;
    6:optional double closeTodayRatioByVolume;
}

struct TPositionES9MarginRate {
    1:optional i16     calculateMode;
    2:optional string  currencyGroupNo;
    3:optional string  currencyNo;
    4:optional double  initialMargin;
    5:optional double  maintenanceMargin;
    6:optional double  sellInitialMargin;
    7:optional double  sellMaintenanceMargin;
    8:optional double  lockMargin;
}

struct TPositionEs9CommissionRate {
    1:optional i16     calculateMode;
    2:optional string  currencyGroupNo;
    3:optional string  currencyNo;
    4:optional double  openCloseFee;
    5:optional double  closeTodayFee;
}


// 持仓保证金
struct TPositionMarginRate {
    1:optional TPositionCTPMarginRate ctpMarginRate;
    2:optional TPositionES9MarginRate es9MarginRate;
}

struct TPositionCommissionRate {
    1:optional TPositionCTPCommissionRate ctpCommissionRate;
    2:optional TPositionEs9CommissionRate es9CommissionRate;
}

struct TPositionContractRate {
    1:optional string sledContractCode; // 雪橇合约编码
    
    3:optional TPositionMarginRate marginRate; // 合约上的保证金费率情况
    4:optional TPositionCommissionRate commissionRate; // 合约上的手续费率
}

struct TPositionCommodityRate {
    1:optional i64 sledCommodityId;      // 雪橇商品ID
    2:optional i16 sledCommodityType;    // 雪橇商品类型数值
    3:optional string sledCommodityCode; // 雪橇商品编码
    4:optional string sledExchangeMic;   // 雪橇交易所编码
    
    5:optional TPositionMarginRate marginRate; // 商品持仓手续费信息
    6:optional TPositionCommissionRate commissionRate; // 商品上的持仓保证金
    
    7:optional map<string, TPositionContractRate> contractRates; // 商品子类下的合约费率情况
}

/**
  * 交易账号的持仓费率详情
  */
struct TPositionRateDetails {
    1:optional i64 tradeAccountId;
    2:optional trade_hosting_basic.BrokerTechPlatform techPlatform; // 交易账号对应的技术平台
    
    3:optional list<TPositionCommodityRate> commodityRates;  // 商品的持仓费率
}


/**
  * 上手接入的入口
  */
service(710) TradeHostingUpsideEntry{
    /**
      * 获取子进程的信息
      */
    list<TSubProcessInfo> 1:getSubProcessInfos(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 重启交易子进程
      */
    void 2:restartSubProcess(1:comm.PlatformArgs platformArgs, 2:i64 trade_account_id) throws (1:comm.ErrorInfo err);

    /**
      * 分配一个唯一的订单应用
      */
    trade_hosting_basic.HostingExecOrderRef 10:allocOrderRef(1:comm.PlatformArgs platformArgs) 
        throws (1:comm.ErrorInfo err)
    
    /**
      * 插入订单
      */
    void 11:orderInsert(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingExecOrder insertOrder) 
        throws (1:comm.ErrorInfo err);
    
    /**
      * 撤销订单
      *  主要是需要填充账号信息，订单引用信息
      */
    void 12:orderDelete(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingExecOrder deleteOrder)
         throws (1:comm.ErrorInfo err)
         
    /**
      * 同步特定订单的状态
      */
    void 13:syncOrderState(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingExecOrder syncOrder)
        throws (1:comm.ErrorInfo err)
    
    /**
      * 同步订单交易列表
      */
    void 14:syncOrderTrades(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingExecOrder syncOrder)
        throws (1:comm.ErrorInfo err)
        
    /**
      * 批量同步订单的状态
      */
    void 15:syncOrderStateBatch(1:comm.PlatformArgs platformArgs, 2:TSyncOrderStateBatchReq batchReq)
        throws (1:comm.ErrorInfo err)
        
        
    /**
      *  获取与上手通信的有效时间戳
      */
    i64 20:getLastUpsideEffectiveTimestamp(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    /**
      *  向上手发送心跳, 检测活性
      */
    void 21:sendUpsideHeartBeat(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    /**
      *  输出所有的持仓信息(计算综合所得), 目前主要用于调试
      */
    list<trade_hosting_upside_position.PositionSummary> 
        22:dumpPositionSummaries(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
        
        
    /**
      *  获取资金信息
      */
    list<TFund> 23:getFunds(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    /**
      * 获取结算单信息
      */
    TSettlementInfo 24:getSettlementInfo(1:comm.PlatformArgs platformArgs
                , 2:string settlementDate) throws(1:comm.ErrorInfo err);
                
    /**
      * 获取当前净仓信息列表， 从接口获得，非计算所得
      */
    list<TNetPositionSummary> 25:getNetPositionSummaries(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取当前持仓信息，包括持仓明细, 从接口整理所得
      */
    list<TPositionInfo> 26:getPositionInfos(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);  
    
    /**
      * 获取持仓相关的费率详情
      */
    TPositionRateDetails 30:getPositionRateDetails(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);          
}