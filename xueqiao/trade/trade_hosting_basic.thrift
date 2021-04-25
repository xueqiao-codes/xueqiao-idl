/**
  * 存储托管机使用的公共数据类，更新后生成的代码统一放到trade_hosting_storage下
  *   其他项目采用maven的形式引用该公共代码
  */
namespace *  xueqiao.trade.hosting

enum HostingStatus {
    EMPTY = 0,   // 空机状态，等待初始化
    NORMAL = 1,  // 正常使用状态
    CLEARING = 2,  // 重置后，正在清理历史数据
}

// 托管机运行模式
enum HostingRunningMode {
    ALLDAY_HOSTING = 1,    // 全天行情模式机
	SIM_HOSTING = 2,       // 仿真模式
	REAL_HOSTING = 3      // 实盘模式
}

struct HostingInfo {
    1:optional HostingStatus status;               // 托管机状态
    2:optional i32           tableVersion;         // 托管机数据表版本号
    3:optional i32           subUserTotalCount;    // 托管机子用户总数
    4:optional i32           composeTotalCount;    // 组合订阅的总数
    5:optional i32           onlineUserTotalCount; // 在线用户总数
    6:optional i64           machineId;            // 托管机机器ID
    7:optional HostingRunningMode   runningMode;   // 托管机交易环境
	8:optional string        buildVersion;         // 编译运行版本
}


/**
  * 托管用户角色
  *   分成1000个权限登记，权限等级越高，值越大
  */
enum EHostingUserRole {
    AdminGroup = 1000,     // 托管机初始控制者，具备一切权限, 包括销毁托管机
    
    BossGroup = 500,       // 托管机管理者，未用
    
    TraderGroup = 200,    // 交易员组，主要是可以进行交易
}

const i32 MAX_LOGIN_NAME_LENGTH = 30;
const i32 MAX_LOGIN_PASSWD_LENGTH = 30;
const i32 MAX_PHONE_LENGTH = 20;
const i32 MAX_NICKNAME_LENGTH = 30;
const i32 MAX_EMAIL_LENGTH = 48;

enum HostingUserOrderType {
    OrderByCreateTimestampAsc = 1,
    OrderByCreateTimestampDesc = 2,
    OrderByLoginNameAsc = 3,
    OrderByLoginNameDesc = 4,
}

/**
  * 托管机用户状态
  */
enum HostingUserState {
    USER_NORMAL = 1,   // 正常用户
    USER_DISABLED = 2, // 用户被禁用
}

/**
  *   托管机用户
  */
struct HostingUser {
    2:optional i32 subUserId;        //托管机子用户ID
    3:optional string loginName;     //登陆用户名
    4:optional string loginPasswd;   //登陆密码 
    5:optional string phone;         //手机号
    6:optional string nickName;      //昵称
    7:optional i16 userRoleValue;   // 用户角色值
    8:optional string email;         //邮箱地址
    9:optional HostingUserState userState;  // 用户状态
    
    15:optional i32 createTimestamp;        // 创建时间
    16:optional i32 lastmodifyTimestamp;    // 最近修改时间
}

struct QueryHostingUserOption {
    2:optional i32 subUserId;
    3:optional string loginNamePartical;
    4:optional string nickNamePartical;
    5:optional string loginNameWhole;
    
    6:optional HostingUserOrderType orderType;
}

struct QueryHostingUserPage {
    1:optional i32 totalCount;
    2:optional list<HostingUser> resultList;
}


/**
  *  子用户Session
  */
struct HostingSession {
	1:optional i64 machineId; // 托管机用于关联的ID
    2:optional i32 subUserId;        // 托管机子用户ID
    3:optional string token;         // 唯一的验证的Token
    4:optional string loginIP;       // 用户登陆的IP地址
}


/**
  * 托管机子账户
  */
struct HostingSubAccount {
    1:optional i64 subAccountId;   // 托管机子账户ID
    2:optional string subAccountName;  // 托管机子账户名称
    3:optional i64  inAmount;   // 子账户入金总和, 以分为单位
    4:optional i64  outAmount;  // 子账户出金总和，以分为单位
    
    8:optional i32  createTimestamp;
    9:optional i32  lastmodifyTimestamp;
}

/**
  * 托管机子账户关联条目
  */
struct HostingSubAccountRelatedItem {
    1:optional i64 subAccountId;   // 关联子账户ID
    2:optional i32 subUserId;      // 关联子用户ID
    3:optional i32 relatedTimestamp;  // 关联创建的时间
    
    // 关联简要信息
    4:optional string subAccountName; // 子账户的名称
    5:optional string subUserLoginName;  // 子用户的登陆名
    6:optional string subUserNickName;   // 子用户的别名
    
    7:optional i32 lastmodifyTimestamp;  //最近更新的时间戳
}


/**
  * 组合腿的买卖方向
  */
enum HostingComposeLegTradeDirection {
    COMPOSE_LEG_BUY = 0,
    COMPOSE_LEG_SELL = 1
}

/**
  * 组合腿
  */
const i32 MAX_VARIABLE_LENGTH = 10;
struct HostingComposeLeg {
    1:optional i64 sledContractId;      // 单元对应的雪橇合约ID
    2:optional string variableName;     // 对应的变量名称
    3:optional i32 quantity;            // 买卖手的数量
    5:optional HostingComposeLegTradeDirection legTradeDirection; // 腿的买卖的方向
    
    // 以下内容为创建组合后后台填充
    6:optional string sledContractCode;  // 雪橇合约月份编码
    7:optional i64 sledCommodityId;      // 雪橇商品ID
    8:optional i16 sledCommodityType;    // 雪橇商品类型数值
    9:optional string sledCommodityCode; // 雪橇商品编码
    10:optional string sledExchangeMic;   // 雪橇交易所编码
}

const i32 MAX_FORMULAR_LENGTH = 512;
const i32 MAX_SUBSCRIBE_COMPOSE_NUMBER = 50;
const i32 MAX_COMPOSE_LEG_COUNT = 8;

enum HostingComposeGraphEnv {
    COMPOSE_GRAPH_SIM = 1,  // 模拟环境
    COMPOSE_GRAPH_REAL = 2, // 实盘环境
}

struct HostingComposeGraph {
    1:optional i32 createSubUserId;  // 创建的子用户ID
    2:optional i64 composeGraphId;   // 组合图ID,后台生成
    3:optional string formular;      // 组合的公式
    4:optional map<string, HostingComposeLeg> legs; // 组合的各条腿, key对应变量的名称
    5:optional string composeGraphKey;  //组合认证的唯一Key, 后台生成
    6:optional HostingComposeGraphEnv composeGraphEnv; // 组合运行的环境, 后台生成
    
    11:optional i32 createTimestamp;           // 组合创建时间戳
    12:optional i32 lastmodifyTimestamp;       // 组合最近更改时间戳
}

// 组合视图来源
enum HostingComposeViewSource {
    USER_CREATED = 1,   // 用户创建
    USER_SEARCHED = 2,   // 用户通过相同配比检索到
    GRAPH_SHARED = 3,   // GRAPH在相同的共享视角中看见
}

// 组合视图行情订阅状态
enum HostingComposeViewSubscribeStatus {
    UNSUBSCRIBED = 0,
    SUBSCRIBED = 1
}

// 组合视图吱声的状态
enum HostingComposeViewStatus {
    VIEW_NORMAL = 0,  // 正常可见视图
    VIEW_DELETED = 1, // 已经被用户标记删除
}

// 托管机组合视图
struct HostingComposeView {
    1:optional i32 subUserId;     // 子用户ID
    2:optional i64 composeGraphId;  // 组合图ID
    3:optional string aliasName;  // 组合别名
    4:optional HostingComposeViewSource viewSource; // 视图分配来源
    5:optional HostingComposeViewSubscribeStatus subscribeStatus; // 行情订阅状态
    6:optional HostingComposeViewStatus viewStatus; // 视图状态
    7:optional i16 precisionNumber;  // 小数精确位数
    
    8:optional i32 createTimestamp;   // 创建时间
    9:optional i32 lastmodifyTimestamp; // 最近修改时间
    
}



/**
  * 交易账号相关
  */

// 券商技术平台
enum BrokerTechPlatform {
    TECH_CTP = 1,               // CTP的技术平台
    TECH_ESUNNY_9 = 2,          // 易盛9.0的技术平台
    TECH_ESUNNY_3 = 3           // 易盛3.0的技术平台
}

/**
  * 账号本身的状态
  */
enum TradeAccountState {
    ACCOUNT_NORMAL = 1,                           // 账号正常
    ACCOUNT_REMOVED = 2,                          // 用户标记账户移除
    ACCOUNT_DISABLED = 3,                         // 账号禁用，但是不删除。
}

/**
  * 账号接入的状态
  */
enum TradeAccountAccessState {
	ACCOUNT_ACTIVE = 1,                         //  账号活跃可使用
	ACCOUNT_INVALID = 2,                        //  账号无效，接入出现问题
}


const i32 MAX_TRADE_ACCOUNT_LOGIN_USER_NAME_LENGTH = 100;
const i32 MAX_TRADE_ACCOUNT_LOGIN_PASSWD_LENGTH = 100;
const i32 MAX_TRADE_ACCOUNT_INVALID_REASON_LENGTH = 250;
const string ESUNNY3_APPID_PROPKEY = "ESUNNY3_APPID";
const string ESUNNY3_CERTINFO_PROPKEY = "ESUNNY3_CERTINFO";
const string ESUNNY9_AUTHCODE_PROPKEY = "ESUNNY9_AUTHCODE";
const string CTP_STS_APPID = "CTP_STS_APPID";
const string CTP_STS_AUTHCODE = "CTP_STS_AUTHCODE"

struct HostingTradeAccount {
    2:optional i64 tradeAccountId;                 // 交易账号唯一ID
    3:optional i32 tradeBrokerAccessId;            // 券商接入的ID
    4:optional string loginUserName;               // 登陆用户名
    5:optional string loginPassword;               // 登陆密码
    6:optional map<string, string> accountProperties; // 账户的扩展属性
    7:optional i32 tradeBrokerId;                     // 对接的券商ID
    8:optional BrokerTechPlatform brokerTechPlatform; // 券商对接技术平台
    9:optional string tradeAccountRemark;             // 账号备注
    
    // 对接账号交易对接模块
    11:optional TradeAccountState      accountState;          // 账号当前状态
    12:optional string                 invalidReason;         // 账号不可用原因
    13:optional i32                    invalidErrorCode;      // 不可用的原因, 内部定义的错误码
    14:optional i32                    apiRetCode;            // 接入API返回的错误码
	15:optional TradeAccountAccessState accountAccessState;   // 账号接入的状态
	16:optional bool                   hadBeenActived;        // 曾经是否被激活过
    
    21:optional i32 createTimestamp;                // 账户创建时间戳
    22:optional i32 lastmodifyTimestamp;            // 最近修改时间戳
}


/**
  * 账号路由信息, 主要是子用户关联账户
  */
struct HostingOrderRouteRelatedInfo {
    1:optional bool forbidden; // 禁用标识
    2:optional i64 mainTradeAccountId; // 关联主账户
}

struct HostingOrderRouteCommodityCodeNode {
    1:optional string sledCommodityCode;  // 雪橇商品编码
    2:optional HostingOrderRouteRelatedInfo relatedInfo; // 关联路由关联信息
}

struct HostingOrderRouteCommodityTypeNode {
    1:optional i16 sledCommodityType;   // 雪橇商品类型
    2:optional map<string, HostingOrderRouteCommodityCodeNode> subCommodityCodeNodes; // 商品编码对应的子节点
    3:optional HostingOrderRouteRelatedInfo relatedInfo; // 该节点上关联信息
}

struct HostingOrderRouteExchangeNode {
    1:optional string sledExchangeCode;   // 雪橇交易所代码
    2:optional map<i16, HostingOrderRouteCommodityTypeNode> subCommodityTypeNodes; // 商品类型对应的子节点配置
    3:optional HostingOrderRouteRelatedInfo relatedInfo;  // 该节点上管理信息
}

struct HostingOrderRouteTree {
    1:optional i32 configVersion;    // 配置版本号
    2:optional map<string, HostingOrderRouteExchangeNode> subExchangeNodes; // 交易所节点配置
}

/**
  * 执行子订单模块
  */
// 支持的执行子订单类型
enum HostingExecOrderType {
    ORDER_LIMIT_PRICE = 1,     // 限价单
    ORDER_WITH_CONDITION = 2,  // 条件单
}

//执行子订单买卖方向
enum HostingExecOrderTradeDirection {
    ORDER_BUY = 0,       
    ORDER_SELL = 1
}

//订单产生的方式
enum HostingExecOrderCreatorType {
	ORDER_ARTIFICAL = 1,   // 人工录入的报单
	ORDER_MACHINE = 2,     // 机器策略产生的订单
}

//订单委托模式
enum HostingExecOrderMode {
	ORDER_FOK = 1,  // FOK委托订单
	ORDER_FAK = 2,  // FAK委托订单
	ORDER_GFD = 3,  // GFD(当日有效)订单
	ORDER_GTC = 4,  // GTC(取消前有效)订单
	ORDER_GTD = 5,  // GTD(指定日期前有效)订单
}

// 条件单执行条件
enum HostingExecOrderCondition {
	LASTEST_PRICE_GT = 1,   // 最新价大于条件价
	LASTEST_PRICE_GE = 2,   // 最新价大于等于条件价
	LASTEST_PRICE_LT = 3,   // 最新价小于条件价
	LASTEST_PRICE_LE = 4,   // 最新价小于等于条件价
	SELLONE_PRICE_GT = 5,   // 卖一价大于条件价
	SELLONE_PRICE_GE = 6,   // 卖一价大于等于条件价
	SELLONE_PRICE_LT = 7,   // 卖一价小于条件价
	SELLONE_PRICE_LE = 8,   // 卖一价小于等于条件价
	BUYONE_PRICE_GT = 9,    // 买一价大于条件价
	BUYONE_PRICE_GE = 10,   // 买一价大于等于条件价
	BUYONE_PRICE_LT = 11,   // 买一价小于条加价
	BUYONE_PRICE_LE = 12,   // 买一价小于等于条件价
}

//执行订单详情
struct HostingExecOrderDetail {
	1:optional HostingExecOrderType orderType; // 订单类型
	2:optional double limitPrice;       // 限价单价
	3:optional i32 quantity;            // 买卖数量
	4:optional HostingExecOrderTradeDirection tradeDirection; // 买卖方向
	5:optional HostingExecOrderCreatorType orderCreatorType;      // 订单委托的模式
	6:optional HostingExecOrderMode orderMode;   // 订单委托模式
	7:optional string effectiveDateTime; // 订单有效日期时间(GTD模式订单有效)
	8:optional HostingExecOrderCondition condition;        // 条件单对应的条件
	9:optional double conditionPrice;               // 条件单对应的条件价
}

struct HostingExecOrderLegContractSummary {
    1:optional i64 legSledContractId;
    2:optional string legSledContractCode;
    3:optional i64 legSledCommodityId;
    4:optional i16 legSledCommodityType;
    5:optional string legSledCommodityCode;
    6:optional string legSledExchangeMic;
}

//合约简要信息
struct HostingExecOrderContractSummary {
	1:optional i64 sledContractId;       // 雪橇合约ID
	2:optional string sledContractCode;  // 雪橇合约月份编码
	3:optional i64 sledCommodityId;      // 雪橇商品ID
	4:optional i16 sledCommodityType;    // 雪橇商品类型数值
	5:optional string sledCommodityCode; // 雪橇商品编码
	6:optional string sledExchangeMic;   // 雪橇交易所编码
	
	7:optional list<HostingExecOrderLegContractSummary> relatedLegs; // 关联的合约腿
}

//执行订单账户简要信息  
struct HostingExecOrderTradeAccountSummary {
	1:optional i64 tradeAccountId;  // 账号ID
	2:optional i32 brokerId;         // 券商ID
	3:optional BrokerTechPlatform techPlatform; // 账号技术平台
}

// 执行订单状态
enum HostingExecOrderStateValue {
    ORDER_WAITING_VERIFY = 1,       // 等待审核, 合规审查和参数填充
    ORDER_VERIFY_FAILED = 2,        // 订单审核失败
    ORDER_WAITING_SLED_SEND = 3, // 订单审核成功，等待雪橇下单，调用发送API
    ORDER_SLED_SEND_FAILED = 4,     // 雪橇下单提交失败
    ORDER_SLED_SEND_UNKOWN = 5,     // 雪橇已经调用了API，但是上手状态未知
    ORDER_UPSIDE_REJECTED = 6,      // 上手拒绝
    ORDER_UPSIDE_RECEIVED = 7,      // 上手已接收
    ORDER_UPSIDE_RESTING = 8,       // 上手已挂单
    ORDER_UPSIDE_PARTFINISHED = 9,   // 上手已部分成交
    ORDER_UPSIDE_FINISHED = 11,      // 上手全部成交
    ORDER_UPSIDE_RECEIVED_WAITING_REVOKE = 12,    // 上手已接受，等待撤单
    ORDER_UPSIDE_RESTING_WAITING_REVOKE = 13,     // 上手已挂单，等待撤单
    ORDER_UPSIDE_PARTFINISHED_WAITING_REVOKE = 14, // 上手部分成交，等待撤单
    ORDER_UPSIDE_RECEIVED_REVOKE_SEND_UNKOWN = 15,      // 上手已接受，并且已发送撤单, 但是上手撤单状况未知
    ORDER_UPSIDE_RESTING_REVOKE_SEND_UNKOWN = 16,       // 上手已挂单，并且已发送撤单, 但是上手撤单状况未知
    ORDER_UPSIDE_PARTFINISHED_REVOKE_SEND_UNKOWN = 17,  // 上手部分成交，并且已发送撤单， 但是上手撤单状况未知
    ORDER_UPSIDE_REVOKE_RECEIVED = 18,             // 上手已接受撤单
    ORDER_UPSIDE_DELETED = 20,                     // 上手已撤单
    ORDER_CONDITION_NOT_TRIGGER = 23,              // 上手条件单未触发
    ORDER_CONDITION_TRIGGEDED = 24,                // 上手条件单已触发
    ORDER_CONDITION_NOT_TRIGGER_WAITING_REVOKE = 25,  // 上手条件单未触发，等待撤单
    ORDER_CONDITION_NOT_TRIGGER_REVOKE_SEND_UNKOWN = 26,   // 上手条件单未出发，并且已经发送撤单, 但是上手撤单状况未知
    
    ORDER_SLED_ALLOC_REF_FINISHED = 30,              // 订单分配引用完成
    ORDER_EXPIRED = 31,                              // 订单过期，未完成的订单过了交易时间
}

// 单个状态的描述
struct HostingExecOrderState {
    1:optional HostingExecOrderStateValue value;  // 状态值
    2:optional i64 timestampMs;      // 状态流转的时间
}

// 状态信息合集
struct HostingExecOrderStateInfo {
	1:optional HostingExecOrderState currentState; // 当前状态
    2:optional list<HostingExecOrderState> historyStates; // 历史状态
    3:optional string statusMsg;       // 状态描述，中文
    4:optional i32 failedErrorCode;    // 失败错误码
    5:optional i32 upsideErrorCode;    // 上手错误码
    6:optional string upsideUsefulMsg; // 上手携带有用信息
}

// 订单撤单信息
struct HostingExecOrderRevokeInfo {
    1:optional i64 lastRevokeTimestampMs;      // 上次撤单发生的时间
    2:optional i32 lastRevokeFailedErrorCode;  // 撤单失败错误码
    3:optional i32 lastRevokeUpsideErrorCode;  // 上手返回的错误码
    4:optional string lastRevokeUpsideRejectReason;  // 上手拒绝的原因
}

//描述CTP的引用, 从CTP账户进程分配的引用
struct CTPOrderRef {
	1:optional i32    frontID;
	2:optional i32    sessionID;
	3:optional string orderRef;  
}

//描述易胜3.0的引用
struct ESunny3OrderRef {
    1:optional string saveString;
}

//描述易胜9.0的引用
struct ESunny9OrderRef {
    1:optional string refString;
}

struct HostingExecOrderRef {
	1:optional CTPOrderRef ctpRef;
	2:optional ESunny3OrderRef esunny3Ref;
	3:optional ESunny9OrderRef esunny9Ref;
}

// CTP的开平标志
enum CTPCombOffsetFlagType {
	THOST_FTDC_OF_OPEN = 1, // 开仓
	THOST_FTDC_OF_ClOSE = 2, // 平仓，实际上雪橇并不使用
	THOST_FTDC_OF_FORCECLOSE = 3, // 强平, 实际雪橇不使用
	THOST_FTDC_OF_CLOSETODAY = 4, // 平今
	THOST_FTDC_OF_CLOSEYESTERDAY = 5, // 平昨
	THOST_FTDC_OF_LOCALFORCECLOSE = 6, // 本地强平，实际不使用
}

// CTP组合投机套保标志
enum CTPCombHedgeFlagType {
    THOST_FTDC_HF_SPECULATION = 1,  // 投机
    THOST_FTDC_HF_ARBITRAGE = 2,    // 套利
    THOST_FTDC_HF_HEDGE = 3,        // 套保
    THOST_FTDC_HF_MARKETMAKER = 4   // 做市商
}

enum CTPTradeDirection {
    CTP_BUY = 0,        // 买
    CTP_SELL = 1,       // 卖
}

// CTP合约概要
struct CTPContractSummary {
	1:optional string ctpExchangeCode;   // ctp交易所代码
	2:optional string ctpCommodityCode;  // ctp商品代码
	3:optional i16    ctpCommodityType;  // ctp商品类型值
	4:optional string ctpContractCode;   // ctp合约编码
}

struct CTPOrderInputExt {
	1:optional CTPContractSummary contractSummary;
	2:optional CTPCombOffsetFlagType combOffsetFlag; // 开平标志
	3:optional i32 minVolume; // 最小下单量, 实际上没有什么用
	4:optional CTPCombHedgeFlagType combHedgeFlag;
	5:optional CTPTradeDirection tradeDirection;
}

// 易胜3.0合约
struct ESunny3ContractSummary {
    1:optional string esunny3ExchangeCode;    // 易胜3.0交易所编码
    2:optional i16    esunny3CommodityType;   // 易胜3.0商品类型值
    3:optional string esunny3CommodityCode;   // 易胜3.0商品编码
    4:optional string esunny3ContractCode;    // 易胜3.0合约编码
}

struct ESunny3OrderInputExt {
    1:optional ESunny3ContractSummary contractSummary; 
}

// 易胜9.0合约
struct ESunny9ContractSummary {
    1:optional string esunny9ExchangeNo;
    2:optional i16    esunny9CommodityType;
    3:optional string esunny9CommodityNo;
    4:optional string esunny9ContractNo;
    5:optional string esunny9ContractNo2;
}

struct ESunny9OrderInputExt {
    1:optional ESunny9ContractSummary contractSummary;
}

// 订单执行输入扩展
struct HostingExecOrderInputExt {
	1:optional CTPOrderInputExt ctpInputExt;           // CTP的订单扩展信息
	2:optional ESunny3OrderInputExt esunny3InputExt;   // 易胜3.0的订单扩展信息
	3:optional ESunny9OrderInputExt esunny9InputExt;   // 易胜9.0的订单扩展信息
}

struct CTPDealID {
    1:optional string orderSysId;
    2:optional string exchangeId;
}

struct ESunny3DealID {
    1:optional i32 orderId;
}

struct ESunny9DealID {
    1:optional string orderNo;
}

// 交易所接受的订单ID
struct HostingExecOrderDealID {
    1:optional CTPDealID ctpDealId;
    2:optional ESunny3DealID esunny3DealId;
    3:optional ESunny9DealID esunny9DealId;
}

struct HostingExecOrderDealCTPInfo {
    1:optional CTPCombOffsetFlagType offsetFlag; // CTP订单携带的开平标志
    2:optional CTPTradeDirection tradeDirection; // CTP订单携带的买卖方向
}

struct HostingExecOrderDealESunny9Info {
    1:optional byte serverFlag;
    2:optional byte isAddOne;
}

// 订单被接受后产生的订单信息
struct HostingExecOrderDealInfo {
    1:optional HostingExecOrderDealID dealId;
    2:optional string orderInsertDateTime;   // 订单插入的时间，上手状态中返回，可用于对单子
    3:optional HostingExecOrderDealCTPInfo ctpDealInfo; // CTP携带的订单信息
    4:optional HostingExecOrderDealESunny9Info esunny9DealInfo; // 易胜9.0携带的订单信息
}

// 上手通知的报单状态
enum HostingUpsideNotifyStateType {
    NOTIFY_UPSIDE_RECIVED = 1, // 上手已接收
    NOTIFY_CONDITION_NOT_TRIGGERED = 2,  // 条件单，尚未触发
    NOTIFY_CONDITION_TRIGGERED = 3,      // 条件单触发
    NOTIFY_ORDER_RESTING = 4,            // 已挂单
    NOTIFY_ORDER_CANCELLED = 5,          // 已撤单
    NOTIFY_ORDER_PARTFINISHED = 6,       // 部分成交
    NOTIFY_ORDER_FINISHED = 7,        // 全部成交
    NOTIFY_ORDER_REJECTED = 8,        // 上手指令失败，拒绝
    NOTIFY_ORDER_CANCEL_RECEIVED = 9, // 上手已接受撤单
}

// 上手通知的状态信息
struct HostingUpsideNotifyStateInfo {
    1:optional HostingUpsideNotifyStateType state;   // 当前订单的状态
    2:optional HostingExecOrderDealInfo dealInfo; // 订单交易必要信息
    6:optional i32 volumeTraded;       // 成交数
    7:optional i32 volumeResting;      // 未成交数
    8:optional double tradeAveragePrice;   // 上手返回成交均价
    9:optional string statusUsefulMsg;     // 状态中携带的有用消息，不要状态的表示
}

enum HostingUpsideNotifyStateSource {
    UPSIDE_FORWARD = 0,  // 上手主动通知
    UPSIDE_SYNC = 1,     // 订单同步请求产生
}

// 上手通知的状态事件的处理情况
struct HostingUpsideNotifyStateHandleInfo {
    1:optional HostingUpsideNotifyStateInfo stateInfo; 
    2:optional i64 eventCreateTimestampMs;
    3:optional i64 handledTimestampMs;
    4:optional HostingUpsideNotifyStateSource source;  
}

// 成交概要信息
struct HostingExecOrderTradeSummary {
    1:optional i32    upsideTradeTotalVolume;   // 上手给出成交总量
    2:optional double upsideTradeAveragePrice;  // 上手给出的成交均价
    3:optional i32    upsideTradeRestingVolume; // 上手给出的未成交总量
    
    6:optional i32    tradeListTotalVolume;  // 成交列表中包含包含的成交总量
    7:optional double tradeListAveragePrice; // 成交列表中计算的成交均价
}

struct HostingExecOrder {
    1:optional i64 execOrderId;    // 执行子订单ID
    2:optional i32 subUserId;      // 创建执行子订单的子用户ID， 别的渠道下单无此ID
    
    // 订单执行前需要准备的信息
    3:optional HostingExecOrderDetail orderDetail;     // 订单详情
    4:optional HostingExecOrderContractSummary contractSummary; // 合约摘要 
    5:optional HostingExecOrderTradeAccountSummary accountSummary;   // 下单账号摘要
    6:optional HostingExecOrderRef upsideOrderRef;     // 上手的订单引用信息
    7:optional HostingExecOrderInputExt orderInputExt; // 订单执行扩展信息, 可以控制不同平台执行参数
    8:optional i64 subAccountId;   // 创建执行子订单的子账户ID
    
    // 订单执行的状态信息, 驱动状态机的流转
    11:optional HostingExecOrderStateInfo stateInfo;  
    
    // 撤单执行信息
    12:optional HostingExecOrderRevokeInfo revokeInfo;
  
    // 订单执行过程中产生的输出信息
    15:optional HostingExecOrderDealInfo  dealInfo;     // 在上手和交易所产生的订单记录信息
    16:optional HostingExecOrderTradeSummary tradeSummary;     // 成交概要信息
    17:optional list<HostingUpsideNotifyStateHandleInfo> notifyStateHandleInfos; // 有效处理的上手历史通知
    18:optional i64 relateExecOrderId;                 // 创建时关联的订单(例如条件单等)
    
    // 记录通用信息
    20:optional i64 createTimestampMs;                 // 记录创建的时间
    21:optional i64 lastmodifyTimestampMs;             // 记录最近修改的时间
    
    22:optional i32 version;                          // 订单记录版本号
    23:optional string source;                        // 订单来源信息
    24:optional i64 ttlTimestampMs;                   // 订单有效期时间戳
    25:optional i64 verifyTimestampMs;                // 订单开始审核时间戳
}

// CTP成交ID描述
struct CTPTradeID {
    1:optional string tradeId;   
}

// 易胜3.0成交ID描述
struct ESunny3TradeID {
    1:optional string matchNo;  
}

struct ESunny9TradeID {
    1:optional string matchNo;
}

// 成交ID表示
struct HostingExecUpsideTradeID {
    1:optional CTPTradeID ctpTradeId;
    2:optional ESunny3TradeID esunny3TradeId;
    3:optional ESunny9TradeID esunny9TradeId;
}

// 成交的买卖方向, 对于组合来说，成交的买卖方向的意义和订单的买卖方向不一致
enum HostingExecTradeDirection {
    TRADE_BUY = 0,
    TRADE_SELL = 1
}

// 成交记录(和合约对应)
struct HostingExecTrade {
    1:optional i64 execTradeId;      // 内部成交ID, 唯一
    2:optional i64 execOrderId;       // 成交对应的订单ID
    3:optional i32 subUserId;         // 订单所属的子用户
    4:optional i64 subAccountId;      // 订单所属的子账户
    
    5:optional HostingExecOrderContractSummary contractSummary; // 合约摘要
    6:optional HostingExecOrderTradeAccountSummary accountSummary; // 账户摘要
    7:optional list<i64> relatedTradeLegIds;     // 关联的成交腿ID, 在relatedTradeLegCount为1的情况下，会填充该值
    8:optional double tradePrice;  // 成交价
    9:optional i32 tradeVolume;    // 成交量
    10:optional i64 createTimestampMs;        
    11:optional i64 lastmodifyTimestampMs;
    12:optional list<double> relatedTradeLegPrices;  // 每条腿的成交价(废弃)
    13:optional HostingExecOrderTradeDirection orderTradeDirection; // 订单买卖方向
    14:optional list<HostingExecTradeDirection> relatedTradeLegTradeDirections; // 每条腿的成交方向(废弃)
    15:optional list<HostingExecOrderLegContractSummary> relatedTradeLegContractSummaries; // 每条腿关联的合约(废弃)
    16:optional list<i32> relatedTradeLegVolumes; // 每条腿关联的成交量(废弃)
    
    17:optional i32 relatedTradeLegCount;  // 指示有多少条关联腿
}

// 成交腿信息
struct HostingExecTradeLegInfo {
    1:optional double legTradePrice;     // 成交价格
    2:optional i32    legTradeVolume;    // 成交量
    3:optional string legTradeDateTime;  // 成交时间, 日期和时间类型(格式 yyyy-MM-dd hh:nn:ss)
    4:optional HostingExecUpsideTradeID legUpsideTradeId; // 上手给出的成交ID
    5:optional HostingExecTradeDirection    legUpsideTradeDirection;  // 上手给出的成交方向
}

// 成交腿
struct HostingExecTradeLeg {
    1:optional i64 execTradeLegId;     // 成交腿ID
    2:optional i64 execOrderId;        // 成交关联的订单ID
    3:optional i64 relatedExecTradeId; // 成交ID, 对应的成交ID
    4:optional i16 legIndex;           // 腿的位置
    5:optional HostingExecOrderLegContractSummary legContractSummary;  // 合约腿摘要
    6:optional HostingExecTradeLegInfo tradeLegInfo;  // 合约腿成交信息
    7:optional HostingExecOrderTradeAccountSummary accountSummary;   // 成交腿账号信息
    8:optional i32 subUserId;         // 成交腿属于的子用户

    9:optional i64 createTimestampMs;
    10:optional i64 lastmodifyTimestampMs;
    11:optional i64 subAccountId;    // 成交腿所属子账户ID
}

