/**
  * 存储层部分接口暴露
  */

namespace * xueqiao.trade.hosting.storage.thriftapi

include "../../comm.thrift"
include "trade_hosting_basic.thrift"
include "../broker/broker.thrift"

struct TradeAccountInvalidDescription {
    1:optional i32 invalidErrorCode;
    2:optional i32 apiRetCode;
    3:optional string invalidReason;
}

struct UpdateConfigDescription {
    1:optional string configArea;
    2:optional string configKey;
    3:optional i32 configVersion;
    4:optional binary configContent;
    5:optional string notifyEventClassName;
    6:optional binary notifyEventBinary;
}

service(708) TradeHostingStorage {
    // 获取指定的账号，由于IDL不能返回空，所以采用list的结构
    list<trade_hosting_basic.HostingTradeAccount> 1:getTraddeAccount(
        1:comm.PlatformArgs platformArgs
        , 2:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
        
    list<broker.BrokerAccessEntry> 2:getBrokerAccessEntry(
        1:comm.PlatformArgs platformArgs
        , 2:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
        
    void 3:setTradeAccountInvalid(
        1:comm.PlatformArgs platformArgs
        , 2:i64 tradeAccountId
        , 3:TradeAccountInvalidDescription invalidDescription) throws (1:comm.ErrorInfo err);
         
    void 4:setTradeAccountActive(1:comm.PlatformArgs platformArgs
        , 2:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
        
    list<trade_hosting_basic.HostingTradeAccount> 5:getAllTradeAccounts(
        1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
        
    // 从云端获取接入地址
    list<broker.BrokerAccessEntry> 6:getBrokerAccessEntryFromCloud(
        1:comm.PlatformArgs platformArgs
        , 2:i64 tradeBrokerId
        , 3:i64 tradeBrokerAccessId) throws (1:comm.ErrorInfo err);    
        
        
    /**
      * 创建组合ID
      */
    i64 8:createComposeGraphId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建交易账户ID
      */
    i64 9:createTradeAccountId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
        
    /**
      * 创建一个唯一的执行订单ID(已废弃)
      */
    //i64 10:createExecOrderId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建一个唯一的成交ID(已废弃)
      */
    //i64 11:createExecTradeId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建一个唯一的成交腿ID(已废弃)
      */
    //i64 12:createExecTradeLegId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建一个唯一的子账户ID
      */
    i64 13:createSubAccountId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    // 查询在途订单映射(已废弃)
    //i64 18:getRunningExecOrderIdByOrderRef(1:comm.PlatformArgs platformArgs
    //        , 2:trade_hosting_basic.HostingExecOrderTradeAccountSummary accountSummary
    //        , 3:trade_hosting_basic.HostingExecOrderRef orderRef) throws (1:comm.ErrorInfo err);
            
    //i64 19:getRunningExecOrderIdByOrderDealID(1:comm.PlatformArgs platformArgs
    //        , 2:trade_hosting_basic.HostingExecOrderTradeAccountSummary accountSummary
    //        , 3:trade_hosting_basic.HostingExecOrderDealID dealID) throws (1:comm.ErrorInfo err);
    
    
    // 更新配置, 在存储进程中，更加方便处理冲突编辑
    void 22:updateConfig(1:comm.PlatformArgs platformArgs
            , 2:UpdateConfigDescription configDescription) throws (1:comm.ErrorInfo err);
            
    // 主要为ThriftProxy服务
    i64 24:getMachineId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);      
    list<trade_hosting_basic.HostingSession> 25:getHostingSession(1:comm.PlatformArgs platformArgs
            , 2:i32 subUserId) throws (1:comm.ErrorInfo err);        
}