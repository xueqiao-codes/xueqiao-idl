/**
  *  托管机终端接入
  */
namespace * xueqiao.trade.hosting.terminal.ao

include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_basic.thrift"
include "trade_hosting_arbitrage.thrift"
include "trade_hosting_asset.thrift"
include "trade_hosting_history.thrift"
include "trade_hosting_tradeaccount_data.thrift"
include "trade_hosting_position_adjust.thrift"
include "trade_hosting_position_adjust_assign.thrift"
include "trade_hosting_position_statis.thrift"
include "trade_hosting_tasknote.thrift"
include "../mailbox/user_message.thrift"
include "trade_hosting_risk_manager.thrift"
include "trade_hosting_position_fee.thrift"
include "../working_order/working_order.thrift"

const i32 MAX_QUERY_USER_PAGESIZE = 50;
const i32 MAX_QUERY_COMPOSEGRAPH_PAGESIZE = 50;
const i32 MAX_QUERY_TRADEACCOUNT_PAGESIZE = 50;

/**
  * 登陆信息
  */
struct LandingInfo {
	1:optional i64 machineId;
    2:optional i32 subUserId;
    3:optional string token;
}

struct QueryHostingComposeViewDetailOption {
    1:optional i32 subUserId; // 组合视图的用户ID
    2:optional i64 composeGraphId; // 组合图ID
    3:optional string aliasNamePartical; // 别名匹配
}

struct HostingComposeViewDetail {
    1:optional trade_hosting_basic.HostingComposeView viewDetail;
    2:optional trade_hosting_basic.HostingComposeGraph graphDetail;
}

struct QueryHostingComposeViewDetailPage {
    1:optional i32 totalCount;
    2:optional list<HostingComposeViewDetail> resultList;
}

struct QuerySameComposeGraphsPage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_basic.HostingComposeGraph> graphs;
}

struct QueryHostingTradeAccountOption {
    2:optional string loginUserNamePartical; // 登录名部分匹配
    3:optional string loginUserNameWhole;    // 登陆名全部匹配
    
    6:optional set<trade_hosting_basic.TradeAccountState> inAccountStates;
    7:optional set<trade_hosting_basic.TradeAccountState> notInAccountStates;
    8:optional i64  tradeAccountId;
    9:optional i32  brokerId;
}

struct QueryHostingTradeAccountPage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_basic.HostingTradeAccount> resultList;
}

struct HostingUserSetting {
    1:optional i32 version;
    2:optional string content;
}

struct QueryHostingSAWRUItemListOption {
    1:optional i64 subAccountId;
    2:optional string subAccountNameWhole;
    3:optional string subAccountNamePartical;
}

struct HostingSAWRUItemList {
    1:optional trade_hosting_basic.HostingSubAccount subAccount;
    2:optional list<trade_hosting_basic.HostingSubAccountRelatedItem> relatedItemList;
}

struct HostingSAWRUItemListPage {
    1:optional i32 totalCount;
    2:optional list<HostingSAWRUItemList> resultList;
}

struct HostingXQOrderPage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_arbitrage.HostingXQOrder> resultList;
}

struct HostingXQTradePage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_arbitrage.HostingXQTrade> resultList;
}

struct HostingXQOrderWithTradeListPage {
    1:optional i32 totalCount;
    2:optional list<trade_hosting_arbitrage.HostingXQOrderWithTradeList> resultList;
}

struct HostingTAFundCurrencyGroup {
    1:optional string currencyNo;
    2:optional list<trade_hosting_tradeaccount_data.TradeAccountFund> itemFunds;
    3:optional trade_hosting_tradeaccount_data.TradeAccountFund groupTotalFund; // 分组资金的总权益
}

struct HostingTAFundItem {
    1:optional i64 tradeAccountId;   // 资金账户ID
    2:optional i64 updateTimestampMs;  // 资金信息从上手更新的时间
    
    3:optional trade_hosting_tradeaccount_data.TradeAccountFund totalFund;  // 总权益， 币种为转化币种，渠道为空
    4:optional map<string, HostingTAFundCurrencyGroup> groupFunds;  // 按照币种分组后信息
}

struct HostingTAFundHisItem {
    1:optional HostingTAFundItem item;   // 具体的资金信息
    2:optional string date;  // 历史资金的日期，形式为XXXX-XX-XX
}

/**
  * 资金持仓的明细查询条件
  * 时间条件：大于 startTradeTimestampMs, 小于 endTradeTimestampMs
  * 所有option使用逻辑与(AND)操作
  */
struct ReqTradeAccountPositionOption{
  1:optional i64 tradeAccountId;    // 资金账户id
  3:optional i64 sledContractId;      // 雪橇合约id
  4:optional i64 startTradeTimestampMs; // 起始交易时间
  5:optional i64 endTradeTimestampMs; // 结束交易时间
}

struct TradeAccountSettlementInfoWithRelatedTime{
  1:optional trade_hosting_tradeaccount_data.TradeAccountSettlementInfo tradeAccountSettlementInfo;
  2:optional trade_hosting_position_adjust.SettlementTimeRelateSledReqTime reqTime;
}

struct QueryXQTradeLameTaskNotePageOption {
  1:optional set<i64> subAccountIds;
  2:optional set<i64> xqTradeIds;
}

/*
 * 查询用户托管机消息的条件
*/
struct ReqMailBoxMessageOption{
  1:optional i64 messageId;
  2:optional user_message.MessageState state;
  3:optional i64 startTimestamp;
  4:optional i64 endTimstamp;
}

service(701) TradeHostingTerminalAo {
   //====================== 子用户相关API开始 ===================================== 
   /**
     * 子用户列表页查询
     */
   trade_hosting_basic.QueryHostingUserPage 4:getHostingUserPage(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.QueryHostingUserOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
   
   // 子用户的其他操作接口，全部转移到CloudAo中, 只保留子用户的查询接口给终端         
   
   //====================== 子用户相关API结束 ===================================== 
   
   //====================== 登录态相关API开始 =====================================        
   /**
     * 用户维持session心跳
     */
   void 6:heartBeat(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo)
            throws (1:comm.ErrorInfo err);
            
   void 7:logout(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo)
            throws (1:comm.ErrorInfo err);
   //====================== 登录态相关API结束 =====================================
            
    //====================== 组合相关API开始 ======================================= 

    /**
      * 根据子用户ID获取其视图详情(包括已经标记删除的), 最大同时获取50个
      */
    map<i64, HostingComposeViewDetail> 8:getComposeViewDetails(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 4:set<i64> composeGraphIds) throws (1:comm.ErrorInfo err);
    
    /**
      * 更改组合视图小数点精确位数
      */        
    void 9:changeComposeViewPrecisionNumber(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 4:i64 composeGraphId
            , 5:i16 precisionNumber) throws (1:comm.ErrorInfo err);
     
       
    // 子用户创建组合
    i64 10:createComposeGraph(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.HostingComposeGraph newGraph
            , 4:string aliasName
            , 5:i16 precisionNumber) throws(1:comm.ErrorInfo err); 
  
    // 子用户删除组合视图          
    void 11:delComposeView(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId) throws (1:comm.ErrorInfo err);
   
    // 子用户查询自身视图列表
    QueryHostingComposeViewDetailPage 12:getComposeViewDetailPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:QueryHostingComposeViewDetailOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
            
    // 检索相同组合视图 
    QuerySameComposeGraphsPage 13:getSameComposeGraphsPage(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.HostingComposeGraph graph
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
   
    // 用户添加组合视图，但是必须具备组合视图的Key       
    void 14:addComposeViewBySearch(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId
            , 4:string composeGraphKey
            , 5:string aliasName
            , 6:i16 precisionNumber) throws (1:comm.ErrorInfo err);
   
    // 订阅组合视图行情
    void 15:subscribeComposeViewQuotation(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId) throws (1:comm.ErrorInfo err);
   
    // 取消订阅组合视图行情
    void 16:unSubscribeComposeViewQuotation(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId) throws (1:comm.ErrorInfo err);
            
    // 修改组合视图别名
    void 17:changeComposeViewAliasName(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId
            , 4:string aliasName) throws (1:comm.ErrorInfo err);
            
    // 通过组合ID查询组合图
    map<i64, trade_hosting_basic.HostingComposeGraph> 18:getComposeGraphs(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<i64> composeGraphIds) throws (1:comm.ErrorInfo err);
            
    // 共享的方式获得的组合
    void 19:addComposeViewByShare(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 composeGraphId
            , 4:string aliasName
            , 5:i16 precisionNumber) throws (1:comm.ErrorInfo err);
            
   
    //====================== 组合相关API结束 ======================================= 
                  
    //====================== 交易账号相关API开始 ===================================  
    /**
      *  添加交易账号
      */
    i64 20:addTradeAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.HostingTradeAccount newAccount) throws (1:comm.ErrorInfo err);
            
    /**
      * 用户禁用账号，实际上是标记账号无效, 并不会一次性物理删除
      *  如果有关联的账号的订单，则账号会保留数据信息
      *  如果账号无关联订单信息，则账号会被移除
      */
    void 21:disableTradeAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
     
     /**
       * 查询交易账户页
       */
     QueryHostingTradeAccountPage 22:getTradeAccountPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:QueryHostingTradeAccountOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
      * 重新启用账户
      */
    void 23:enableTradeAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
            
    /**
      * 更新账号信息
      */
    void 24:updateTradeAccountInfo(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.HostingTradeAccount updateAccount) throws (1:comm.ErrorInfo err);
            
    
    /**
      * 删除账号
      */
    void 25:rmTradeAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId) throws (1:comm.ErrorInfo err);


     /**
       * 查询个人用户交易账户页
       */
     list<trade_hosting_basic.HostingTradeAccount> 26:getPersonalUserTradeAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);
            
    //====================== 交易账号相关API结束 ===================================
            
    //====================== 订单路由相关API开始===================================
    /**
      *  获取子账户订单路由配置树
      */
    trade_hosting_basic.HostingOrderRouteTree 27:getHostingOrderRouteTree(1:comm.PlatformArgs platformArgs
             , 2:LandingInfo landingInfo
             , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);
    
    /**
      * 更新用户订单路由配置树
      */         
    void 28:updateHostingOrderRouteTree(1:comm.PlatformArgs platformArgs
             , 2:LandingInfo landingInfo
             , 3:i64 subAccountId
             , 4:trade_hosting_basic.HostingOrderRouteTree routeTree) throws (1:comm.ErrorInfo err);
    
    
    /**
      * 获取用户订单路由配置树在服务端的版本
      */
    i32 29:getHostingOrderRouteTreeVersion(1:comm.PlatformArgs platformArgs
             , 2:LandingInfo landingInfo
             , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);

    /**
      *  获取个人用户的子账户订单路由配置树
      */
    trade_hosting_basic.HostingOrderRouteTree 30:getPersonalUserHostingOrderRouteTree(1:comm.PlatformArgs platformArgs
             , 2:LandingInfo landingInfo
             , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);
    //====================== 订单路由相关API结束===================================
   
    //====================== 雪橇订单相关API开始======================================
    
    /**
      * 雪橇订单格式为${MACHINEID}_${SUBACCOUNTID}_${SUBUSERID}_${LOGINTIMESTAMP}_{客户端自增}
      */
    void 35:createXQOrder(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:string orderId
            , 5:trade_hosting_arbitrage.HostingXQOrderType orderType
            , 6:trade_hosting_arbitrage.HostingXQTarget orderTarget
            , 7:trade_hosting_arbitrage.HostingXQOrderDetail orderDetail) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量暂停雪橇订单
      */        
    map<string, comm.ErrorInfo> 36:batchSuspendXQOrders(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<string> orderIds) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量恢复雪橇订单
      */        
    map<string, comm.ErrorInfo> 37:batchResumeXQOrders(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<string> orderIds
            , 4:map<string, trade_hosting_arbitrage.HostingXQOrderResumeMode> resumeModes) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量撤销雪橇订单
      */        
    map<string, comm.ErrorInfo> 38:batchCancelXQOrders(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<string> orderIds) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取未清理订单和成交信息
      */        
    HostingXQOrderWithTradeListPage 39:getEffectXQOrderWithTradeListPage(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_arbitrage.QueryEffectXQOrderIndexOption qryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量查询订单的信息和其成交信息
      */
    map<string, trade_hosting_arbitrage.HostingXQOrderWithTradeList> 40:getXQOrderWithTradeLists(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<string> orderIds) throws (1:comm.ErrorInfo err);
    
    /**
      * 查询订单的执行详情
      */
    trade_hosting_arbitrage.HostingXQOrderExecDetail 41:getXQOrderExecDetail(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:string orderId) throws (1:comm.ErrorInfo err);      
            
    
    //====================== 雪橇订单相关API结束======================================
    
    //====================== 订单历史相关API开始======================================
    
    HostingXQOrderPage 50:getXQOrderHisPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_history.QueryXQOrderHisIndexItemOption qryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
            
    HostingXQTradePage 51:getXQTradeHisPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_history.QueryXQTradeHisIndexItemOption qryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    
    //====================== 成交历史相关API开始======================================
    
   
    //====================== 用户Setting相关API开始===================================
    HostingUserSetting 60:getUserSetting(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:string key) throws (1:comm.ErrorInfo err);
            
    void 61:updateUserSetting(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:string key
            , 4:HostingUserSetting setting) throws (1:comm.ErrorInfo err);
            
    i32 62:getUserSettingVersion(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:string key) throws (1:comm.ErrorInfo err);
        
    //====================== 用户Setting相关API结束===================================
    
    //====================== 子账户相关API开始========================================
    /**
      * 获取子账户以及关联信息列表
      */
    HostingSAWRUItemListPage 65:getSAWRUTListPage(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:QueryHostingSAWRUItemListOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取子账户关联的列表
      */        
    map<i64, list<trade_hosting_basic.HostingSubAccountRelatedItem>> 66:getSARUTBySubAccountId(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<i64> subAccountIds) throws(1:comm.ErrorInfo err);
    
    /**
      * 获取用户的关联子账户列表
      */       
    map<i32, list<trade_hosting_basic.HostingSubAccountRelatedItem>> 67:getSARUTBySubUserId(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<i32> subUserIds) throws (1:comm.ErrorInfo err);
    
    /**
      * 分配子账户列表
      */        
    void 68:assignSubAccountRelatedUsers(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:set<i32> relatedSubUserIds
            , 5:set<i32> unRelatedSubUserIds) throws (1:comm.ErrorInfo err);
            
    /**
      * 子账户重命名
      */ 
    void 72:renameSubAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:string subAccountName) throws (1:comm.ErrorInfo err);
            
            
    /**
      * 创建子账户
      */
    i64 73:createSubAccount(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_basic.HostingSubAccount newSubAccount) throws (1:comm.ErrorInfo err);

    //======================= 子账户相关API结束=======================================
    
    //======================= 子账户资金与持仓相关API =======================================
    /**
     *  查询实时雪橇合约持仓, 查询实时数据不具备分页
     */
    trade_hosting_asset.HostingSledContractPositionPage 78:getHostingSledContractPosition(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_asset.ReqHostingSledContractPositionOption option) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询子账号实时资金, 查询实时数据不具备分页
     */
    trade_hosting_asset.HostingFundPage 79:getHostingSubAccountFund(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_asset.ReqHostingFundOption option) throws (1:comm.ErrorInfo err);

    /**
     *  子账号出入金
     */
    trade_hosting_asset.HostingSubAccountFund 80:changeSubAccountFund(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_asset.FundChange fundChange) throws (1:comm.ErrorInfo err);

    /**
     *  子账号设置信用额度
     */
    trade_hosting_asset.HostingSubAccountFund 81:setSubAccountCreditAmount(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_asset.CreditAmountChange amountChange) throws (1:comm.ErrorInfo err);

    /**
     *  查询实时雪橇合约持仓明细信息
     */
    trade_hosting_asset.AssetTradeDetailPage 82:getAssetPositionTradeDetail(1:comm.PlatformArgs platformArgs,2:LandingInfo landingInfo, 3:trade_hosting_asset.ReqHostingAssetTradeDetailOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号出入金记录
     */
    trade_hosting_asset.HostingSubAccountMoneyRecordPage 83:getHostingSubAccountMoneyRecord(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_asset.ReqMoneyRecordOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的历史资金信息
     */
    trade_hosting_asset.HostingFundPage 84:getSubAccountFundHistory(1:comm.PlatformArgs platformArgs,  2:LandingInfo landingInfo,3:trade_hosting_asset.ReqSubAccountFundHistoryOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的历史持仓信息
     */
    trade_hosting_asset.SettlementPositionDetailPage 85:getSubAccountPositionHistory(1:comm.PlatformArgs platformArgs,  2:LandingInfo landingInfo,3:trade_hosting_asset.ReqSettlementPositionDetailOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询子账号的历史持仓的持仓明细
     */
    trade_hosting_asset.AssetTradeDetailPage 86:getSubAccountPositionHistoryTradeDetail(1:comm.PlatformArgs platformArgs,  2:LandingInfo landingInfo,3:trade_hosting_asset.ReqSettlementPositionTradeDetailOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  删除操作账号中过期合约的持仓(合约已经过期，而持仓在其他地方平掉，但是在雪橇的操作账号中依然显示存在)
     */
    void 87:deleteExpiredContractPosition(1:comm.PlatformArgs platformArgs,2:LandingInfo landingInfo, 3:i64 subAccountId 4:i64 sledContractId) throws (1:comm.ErrorInfo err);


    //======================= 子账户资金与持仓相关API结束=======================================
    
    //======================= 交易账户相关接口 =================================================
    /**
      * 获取交易账户目前保留的最新的资金信息，如果查询不到，则list为空，否则list中会存在一个对应的资金信息
      */
    list<HostingTAFundItem> 90:getTradeAccountFundNow(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId) throws (1:comm.ErrorInfo err);
    
    /**
      * 查询资金历史条目, 最大可查一年内的资金变动每日变动
      */
    list<HostingTAFundHisItem> 91:getTradeAccountFundHis(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId
            , 4:string fundDateBegin
            , 5:string fundDateEnd) throws (1:comm.ErrorInfo err);
    
    /**
      * 查询历史结算信息， 最大可查询一个月内的所有结算单
      */        
    list<trade_hosting_tradeaccount_data.TradeAccountSettlementInfo> 92:getTradeAccountSettlementInfos(
            1:comm.PlatformArgs platformArgs
            2:LandingInfo landingInfo
            , 3:i64 tradeAccountId
            , 4:string settlementDateBegin
            , 5:string settlementDateEnd) throws (1:comm.ErrorInfo err)


    /**
      * 查询历史结算信息,包含雪橇成交建议查询时间， 最大可查询一个月内的所有结算单
      */        
    list<TradeAccountSettlementInfoWithRelatedTime> 95:getTradeAccountSettlementInfosWithRelatedTime(
            1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 tradeAccountId
            , 4:string settlementDateBegin
            , 5:string settlementDateEnd) throws (1:comm.ErrorInfo err)
    
    //======================= 交易账户相关接口结束==============================================

    //======================= 交易账户持仓核对接口 ==================================================
    /**
     *  查询资金账户持仓明细信息
     */
    trade_hosting_asset.AssetTradeDetailPage 101:getTradeAccountPositionTradeDetail(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:ReqTradeAccountPositionOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询资金账户持仓核对历史
     */
    trade_hosting_position_adjust.PositionVerifyPage 102:reqPositionVerify(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.ReqPositionVerifyOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);


    /**
     *  查询资金账户持仓核对明细
     */ 
    trade_hosting_position_adjust.PositionDifferencePage 103:reqPositionDifference(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.ReqPositionDifferenceOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  录入持仓明细信息
     * 
     */
    trade_hosting_position_adjust.ManualInputPositionResp 104:manualInputPosition(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:list<trade_hosting_position_adjust.PositionManualInput> positionManualInputs) throws (1:comm.ErrorInfo err);

    /**
     *  查询未分配的持仓明细信息
     */
    trade_hosting_position_adjust.PositionUnassignedPage 105:reqPositionUnassigned(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.ReqPositionUnassignedOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  分配持仓明细信息
     *  
     */
    trade_hosting_position_adjust_assign.AssignPositionResp 106:assignPosition(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:list<trade_hosting_position_adjust.PositionAssignOption> assignOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询持仓编辑锁信息
     */
    trade_hosting_position_adjust.PositionEditLock 107:reqPositionEditLock(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:string lockKey) throws (1:comm.ErrorInfo err);

    /**
     *  添加持仓编辑锁信息
     */
    void 108:addPositionEditLock(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.PositionEditLock positionEditLock) throws (1:comm.ErrorInfo err);

    /**
     *  删除持仓编辑锁信息
     */
    void 109:removePositionEditLock(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.PositionEditLock positionEditLock) throws (1:comm.ErrorInfo err);

    /** 
     *  查询日常持仓核对明细
     */ 
    trade_hosting_position_adjust.DailyPositionDifferencePage 110:reqDailyPositionDifference(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.ReqDailyPositionDifferenceOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /** 
     *  更新日常持仓核对的备注和核对状态信息
     */ 
    void 111:updateDailyPositionDifferenceNote(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.DailyPositionDifference difference) throws (1:comm.ErrorInfo err);

    /**
     *  查询已分配的持仓明细信息
     */
    trade_hosting_position_adjust.PositionAssignedPage 112:reqPositionAssigned(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_adjust.ReqPositionAssignedOption option
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    //======================= 交易账户持仓核对接口结束 ===============================================

    //====================== 持仓统计相关API开始===================================
    /**
     *  录入统计组合
     *  (过期废弃)
     */
    void 120:contructCompose(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.StatContructComposeReq contructComposeReq) throws (1:comm.ErrorInfo err);
    
    /**
     *  拆分统计组合
     */
    void 121:disassembleCompose(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.DisassembleComposePositionReq disassembleComposePositionReq) throws (1:comm.ErrorInfo err);
    
    /**
     *  批量平仓
     */
    void 122:batchClosePosition(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.BatchClosedPositionReq batchClosedPositionReq) throws (1:comm.ErrorInfo err);
    
    /**
     *  恢复当天平仓
     */
    void 123:recoverClosedPosition(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:string targetKey
            , 5:trade_hosting_arbitrage.HostingXQTargetType targetType) throws (1:comm.ErrorInfo err);

    /**
     *  合并合约为组合
     */
    void 124:mergeToCompose(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.StatMergeToComposeReq mergeToComposeReq) throws (1:comm.ErrorInfo err);

    /**
     *  删除过期合约持仓
     */
    void 125:deleteExpiredStatContractPosition(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i64 sledContractId) throws (1:comm.ErrorInfo err);

    /**
     *  查询统计持仓
     */
    trade_hosting_position_statis.StatPositionSummaryPage 130:queryStatPositionSummaryPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatPositionSummaryOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询持仓详情
     */
    trade_hosting_position_statis.StatPositionItemPage 131:queryStatPositionItemPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatPositionItemOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询当天平仓记录
     */
    trade_hosting_position_statis.StatClosedPositionDateSummaryPage 132:queryCurrentDayStatClosedPositionPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:string targetKey
            , 5:trade_hosting_arbitrage.HostingXQTargetType targetType) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询平仓明细
     */
    trade_hosting_position_statis.StatClosedPositionDetail 133:queryStatClosedPositionDetail(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatClosedPositionItemOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询归档记录
     */
    trade_hosting_position_statis.StatClosedPositionDateSummaryPage 134:queryArchivedClosedPositionPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatClosedPositionDateSummaryOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
     *  查询归档（平仓）明细
     */
    trade_hosting_position_statis.StatClosedPositionDetail 135:queryArchivedClosedPositionDetail(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatArchiveItemOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询统计汇总信息（包含动态计算部分）
    trade_hosting_position_statis.StatPositionSummaryExPage 136:queryStatPositionSummaryExPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatPositionSummaryOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询持仓明细
    trade_hosting_position_statis.StatPositionUnitPage 137:queryStatPositionUnitPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryStatPositionUnitOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询历史平仓记录
    trade_hosting_position_statis.StatClosedPositionDateSummaryPage 138:queryHistoryClosedPositionPage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryHistoryClosedPositionOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询历史平仓明细
    trade_hosting_position_statis.StatClosedPositionDetail 139:queryHistoryClosedPositionDetail(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:trade_hosting_position_statis.QueryHistoryClosedPositionOption queryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    //====================== 持仓统计相关API结束======================================
    
    //====================== TaskNote相关API开始=====================================
    
    /**
      * 查询相关子账户的所有瘸腿成交的TaskNote
      */
    trade_hosting_tasknote.HostingTaskNotePage 150:getXQTradeLameTaskNotePage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:QueryXQTradeLameTaskNotePageOption qryOption
            , 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量删除一个子账户下的TaskNote
      */        
    map<i64, comm.ErrorInfo> 151:batchDeleteXQTradeLameTaskNotes(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:set<i64> xqTradeIds) throws (1:comm.ErrorInfo err);
        
    //====================== TaskNote相关API结束=====================================


    //====================== 用户托管机消息相关API开始=====================================
    /**
      * 查询用户托管机消息的接口
      */
    user_message.UserMessagePage 160:queryMailBoxMessage(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:ReqMailBoxMessageOption option
            , 4:page.IndexedPageOption pageOption) throws(1:comm.ErrorInfo err);

    /**
      * 标记用户托管机消息为已读
      * hostingMessageIds empty 表示所有未读状态设置为已读
      */
    bool 161:markMessageAsRead(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:set<i64> hostingMessageIds) throws(1:comm.ErrorInfo err);

    //====================== 用户托管机消息相关API结束=====================================
    
    //====================== 风控相关API==================================================
    list<trade_hosting_risk_manager.HostingRiskSupportedItem> 170:getAllSupportedItems(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo) throws (1:comm.ErrorInfo err);
    
    i32 171:getRiskRuleJointVersion(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);
            
    trade_hosting_risk_manager.HostingRiskRuleJoint 172:getRiskRuleJoint(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);
            
    trade_hosting_risk_manager.HostingRiskRuleJoint 173:batchSetSupportedItems(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i32 version
            , 5:set<string> openedItemIds
            , 6:set<string> closedItemIds) throws (1:comm.ErrorInfo err);
            
    trade_hosting_risk_manager.HostingRiskRuleJoint 174:batchSetTradedCommodityItems(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i32 version
            , 5:set<i64> enabledCommodityIds
            , 6:set<i64> disabledCommodityIds) throws (1:comm.ErrorInfo err);
    
    trade_hosting_risk_manager.HostingRiskRuleJoint 175:batchSetGlobalRules(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i32 version
            , 5:map<string, trade_hosting_risk_manager.HostingRiskRuleItem> ruleItems) throws (1:comm.ErrorInfo err); 
            
    trade_hosting_risk_manager.HostingRiskRuleJoint 176:batchSetCommodityRules(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i32 version
            , 5:map<i64, map<string, trade_hosting_risk_manager.HostingRiskRuleItem>> rules) throws (1:comm.ErrorInfo err);   
            
    trade_hosting_risk_manager.HostingRiskRuleJoint 177:setRiskEnabled(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId
            , 4:i32 version
            , 5:bool riskEnabled) throws (1:comm.ErrorInfo err);
           
     trade_hosting_risk_manager.HostingRiskFrameDataInfo 178:getRiskFrameDataInfo(1:comm.PlatformArgs platformArgs
            , 2:LandingInfo landingInfo
            , 3:i64 subAccountId) throws (1:comm.ErrorInfo err);    
    
    //====================================================================================

    //====================== 持仓费率相关API开始=====================================
// 设置基础保证金费率设置项
    void 190:setGeneralMarginSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQGeneralMarginSettings marginSettings) throws (1:comm.ErrorInfo err);

    // 设置基础手续费费率设置项
    void 191:setGeneralCommissionSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQGeneralCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);

    // 添加特殊保证金费率设置项
    void 192:addSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQSpecMarginSettings marginSettings) throws (1:comm.ErrorInfo err);

    // 添加特殊手续费费率设置项
    void 193:addSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQSpecCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);

    // 编辑特殊保证金费率设置项
    void 194:updateSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQSpecMarginSettings marginSettings) throws (1:comm.ErrorInfo err);

    // 编辑特殊手续费费率设置项
    void 195:updateSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.XQSpecCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);

    // 删除特殊保证金费率设置项
    void 196:deleteSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:i64 subAccountId, 4:i64 commodityId) throws (1:comm.ErrorInfo err);

    // 删除特殊手续费费率设置项
    void 197:deleteSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:i64 subAccountId, 4:i64 commodityId) throws (1:comm.ErrorInfo err);

    //-----------------------------------------查询-----------------------------------------------
    // 查询基础保证金费率设置项
    trade_hosting_position_fee.XQGeneralMarginSettings 200:queryXQGeneralMarginSettings(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:i64 subAccountId) throws (1:comm.ErrorInfo err);

    // 查询基础手续费费率设置项
    trade_hosting_position_fee.XQGeneralCommissionSettings 201:queryXQGeneralCommissionSettings(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:i64 subAccountId) throws (1:comm.ErrorInfo err);

    // 查询特殊保证金费率设置页
    trade_hosting_position_fee.XQSpecMarginSettingPage 202:queryXQSpecMarginSettingPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryXQSpecSettingOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查贸易特殊手续费费率设置页
    trade_hosting_position_fee.XQSpecCommissionSettingPage 203:queryXQSpecCommissionSettingPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryXQSpecSettingOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询上手保证金费率
    trade_hosting_position_fee.UpsideContractMarginPage 204:queryUpsideContractMarginPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryUpsidePFeeOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询上手手续费费率
    trade_hosting_position_fee.UpsideContractCommissionPage 205:queryUpsideContractCommissionPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryUpsidePFeeOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询特殊保证金费率页
    trade_hosting_position_fee.XQContractMarginPage 206:queryXQContractMarginPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryXQPFeeOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查贸易特殊手续费费率页
    trade_hosting_position_fee.XQContractCommissionPage 207:queryXQContractCommissionPage(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:trade_hosting_position_fee.QueryXQPFeeOptions queryOptions, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    //====================== 持仓费率相关API结束=====================================


    //====================== 雪橇工单相关API开始=====================================
    i64 215:addAssetAccountWorkingOrder(1:comm.PlatformArgs platformArgs, 2:LandingInfo landingInfo, 3:working_order.AssetAccount assetAccount) throws (1:comm.ErrorInfo err);

    //====================== 雪橇工单相关API结束=====================================
}