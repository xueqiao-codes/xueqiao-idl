/**
  * 执行订单服务进程
  */
namespace * xueqiao.trade.hosting.dealing.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_basic.thrift"

struct HostingExecOrderPage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_basic.HostingExecOrder> resultList;
}

service(709) TradeHostingDealing {
    void 1:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err)
    
    /**
      * 增加执行订单
      */
    void 2:createUserDeal(1:comm.PlatformArgs platformArgs
           , 2:i32 subUserId
           , 3:i64 subAccountId
           , 4:i64 execOrderId
           , 5:trade_hosting_basic.HostingExecOrderContractSummary contractSummary
           , 6:trade_hosting_basic.HostingExecOrderDetail orderDetail
           , 7:string source) throws (1:comm.ErrorInfo err);
    
    /**
      * 撤销执行订单
      */       
    void 3:revokeDeal(1:comm.PlatformArgs platformArgs, 2:i64 execOrderId) throws (1:comm.ErrorInfo err);
           
    /**
      * 获取订单
      */       
    list<trade_hosting_basic.HostingExecOrder> 4:getOrder(1:comm.PlatformArgs platformArgs, 2:i64 execOrderId) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取订单成交列表
      */
    list<trade_hosting_basic.HostingExecTrade> 5:getOrderTrades(1:comm.PlatformArgs platformArgs, 2:i64 execOrderId)
        throws (1:comm.ErrorInfo err);
    
    /**
      * 获取订单成交列表
      */
    list<trade_hosting_basic.HostingExecTradeLeg> 6:getTradeRelatedLegs(1:comm.PlatformArgs platformArgs
           , 2:i64 execTradeId) throws (1:comm.ErrorInfo err);
           
    
    /**
      * 查询订单引用
      */
    i64 7:getRunningExecOrderIdByOrderRef(1:comm.PlatformArgs platformArgs
          , 2:trade_hosting_basic.HostingExecOrderTradeAccountSummary accountSummary
          , 3:trade_hosting_basic.HostingExecOrderRef orderRef) throws (1:comm.ErrorInfo err);
          
    /**
      * 根据订单ID查询
      */
    i64 8:getRunningExecOrderIdByOrderDealID(1:comm.PlatformArgs platformArgs
         , 2:trade_hosting_basic.HostingExecOrderTradeAccountSummary accountSummary
         , 3:trade_hosting_basic.HostingExecOrderDealID dealId) throws (1:comm.ErrorInfo err);
         
         
    /**
      * 获取有效期订单列表
      */
    HostingExecOrderPage 9:getInDealingOrderPage(1:comm.PlatformArgs platformArgs
         , 2:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
         
    /**
      * 创建执行订单ID
      */
    i64 10:createExecOrderId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建执行成交ID
      */
    i64 11:createExecTradeId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 创建执行成交腿ID
      */
    i64 12:createExecTradeLegId(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}

