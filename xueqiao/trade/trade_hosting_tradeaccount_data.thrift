/**
  *  交易账号的数据
  */
 
namespace * xueqiao.trade.hosting.tradeaccount.data

include "../../comm.thrift"

// 资金信息
struct TradeAccountFund {
    1:optional i64 tradeAccountId;
    2:optional string currencyNo;    // 币种, CNY,USD...
    3:optional string currencyChannel; // 币种渠道, 无渠道为DEFAULT
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
    
    17:optional i64 updateTimestampMs;  // 资金信息更新时间
}

// 资金历史信息
struct TradeAccountFundHisItem {
    1:optional list<TradeAccountFund> funds;  // 资金信息
    2:optional string date;   // 历史日期, 格式为XXXX-XX-XX
    3:optional i64 createTimestampMs; // 历史创建时间
    4:optional i64 tradeAccountId; 
}

// 资金账号结算信息单
struct TradeAccountSettlementInfo {
    1:optional i64 tradeAccountId;
    2:optional string settlementDate;  // 结算日期，格式为XXXX-XX-XX
    3:optional string settlementContent;  // 结算单内容
    4:optional i64 createTimestampMs;     // 记录创建时间
}

// 资金账号净仓信息
struct TradeAccountNetPositionSummary {
    1:optional i64     tradeAccountId;   // 交易账户ID
    
    2:optional string  sledExchangeCode;  // 雪橇交易所编码           
    3:optional i16     sledCommodityType;  // 雪橇商品类型
    4:optional string  sledCommodityCode;  // 雪橇商品编码
    5:optional i64     sledCommodityId;    // 雪橇商品ID
    6:optional string  sledContractCode;   // 雪橇合约月份编码
    7:optional i64     netVolume;          // 净仓量
    8:optional double  averagePrice;       // 净仓均价
    
    10:optional i64    updateTimestampMs;  // 更新时间
}

service(705) TradeHostingTradeAccountData {
    /**
      * 清空全部数据
      */
    void 1:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取当前资金信息, 无资金信息时为空
      */
    list<TradeAccountFund> 2:getNowFund(1:comm.PlatformArgs platformArgs, 2:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
    
    
    /**
      * 获取历史资金信息
      */
    list<TradeAccountFundHisItem> 3:getHisFunds(1:comm.PlatformArgs platformArgs
            , 2:i64 tradeAccountId
            , 3:string fundDateBegin
            , 4:string fundDateEnd) throws (1:comm.ErrorInfo err);
    
    
    /**
      * 获取一段时间内的结算报告
      */
    list<TradeAccountSettlementInfo> 4:getSettlementInfos(1:comm.PlatformArgs platformArgs
            , 2:i64 tradeAccountId
            , 3:string settlementDateBegin
            , 4:string settlementDateEnd) throws (1:comm.ErrorInfo err);
            
    /**
      * 获取某个交易账号的所有净仓信息
      */
    list<TradeAccountNetPositionSummary> 5:getNetPositionSummaries(1:comm.PlatformArgs platformArgs
            , 2:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
}
