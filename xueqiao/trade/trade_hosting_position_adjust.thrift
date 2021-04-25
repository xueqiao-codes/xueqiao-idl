/**
  * 雪橇成交明细公共类型
  */
namespace * xueqiao.trade.hosting.position.adjust.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_position_adjust_assign.thrift"

/**
  * 持仓录入明细
  */
struct PositionManualInput{
  1:optional i64 inputId;             // 录入明细id(内部生成,唯一)
  2:optional i64 subUserId;           // 录入记录的用户id
  3:optional i64 tradeAccountId;      // 资金账户id
  4:optional i64 sledContractId;      // 雪橇合约id
  5:optional i64 sledCommodityId;     // 雪橇商品id(内部查询)

  10:optional double price;           // 价格
  11:optional i32 volume;        // 成交量
  12:optional trade_hosting_position_adjust_assign.PositionDirection
   positionDirection;             // 持仓方向
  13:optional i64 positionTimestampMs;// 持仓生效时间

  30:optional i64 createTimestampMs;
  31:optional i64 lastmodifyTimestampMs;
}

/**
  * 未分配持仓
  */
struct PositionUnassigned{
  1:optional i64 inputId;             // 录入明细id(内部生成,唯一)
  2:optional i64 inputSubUserId;      // 录入记录的用户id
  3:optional i64 tradeAccountId;      // 资金账户id
  4:optional i64 sledContractId;      // 雪橇合约id
  5:optional i64 sledCommodityId;     // 雪橇商品id

  10:optional double price;           // 价格
  11:optional i32 volume;             // 未分配数量
  12:optional trade_hosting_position_adjust_assign.PositionDirection
   positionDirection; // 持仓方向
  13:optional i64 positionTimestampMs;// 持仓生效时间

  30:optional i64 createTimestampMs;
  31:optional i64 lastmodifyTimestampMs;
}

/**
  * 分配持仓输入信息
  */
struct PositionAssignOption{
  1:optional i64 inputId;
  2:optional i64 subAccountId;
  3:optional i64 subUserId;
  4:optional i32 volume;
}

// PositionEditLock lock area
const string POSITION_EDIT_AREA_MANUAL_INPUT = "POSITION_MANUAL_INPUT";
const string POSITION_EDIT_AREA_ASSIGN = "POSITION_ASSIGN";

/**
  * 持仓编辑锁
  */
struct PositionEditLock{
  1:optional string lockArea; //使用定义的 PositionEditLock lock area
  2:optional i64 subUserId;
  3:optional i64 createTimestampMs;
  4:optional i64 lastmodifyTimestampMs;
}

/**
  * 资金账户持仓核对时间点
  */
struct PositionVerify{
  1:optional i64 verifyId;    // 核对时内部生成,唯一，用于关联持仓差异明细
  2:optional i64 tradeAccountId;
  3:optional i64 verifyTimestampMs;
  4:optional bool different;
  5:optional i64 createTimestampMs;
  6:optional i64 lastmodifyTimestampMs;
}

/**
  * 资金账户合约的总净持仓差异
  */
struct PositionDifference{
  1:optional i64 verifyId;    // 关联持仓核对历史时间点，描述实时净仓差异时，不设置
  2:optional i64 tradeAccountId;
  3:optional i64 sledContractId;
  4:optional i32 sledNetPosition;   // 雪橇系统内的净仓
  5:optional i32 upsideNetPosition; // 上手查询的净仓
}

/**
  * 资金账户上次打点的合约总净持仓差异
  */
struct PrePositionDifference{
  1:optional i64 dateSec;           // 该记录对应的日期，精确到秒
  2:optional i64 tradeAccountId;
  3:optional i64 sledContractId;
  4:optional i32 sledNetPosition;   // 雪橇系统内的净仓
  5:optional i32 upsideNetPosition; // 上手查询的净仓
  6:optional i64 dotTimestampMs;
  7:optional i64 createTimestampMs;
  8:optional i64 lastmodifyTimestampMs;
  9:optional i64 startTimestampMs;  // 持仓数据的开始时间
}

enum Milestone{
    DAILY = 0,
    INIT = 1,
    TODAY = 2
}

enum VerifyStatus{
    WAITING_VERIFY = 0;
    DOING_VERIFY = 1;
    VERIFY_COMPLETE = 2;
}

/**
  * 资金账户合约的每日净持仓差异
  */
struct DailyPositionDifference{
  1:optional i64 dateSec;           // 该记录对应的日期，精确到秒
  2:optional i64 tradeAccountId;
  3:optional i64 sledContractId;
  4:optional i32 sledNetPosition;   // 雪橇系统内的今日净仓
  5:optional i32 upsideNetPosition; // 上手查询的今日净仓
  6:optional i32 inputNetPosition;  // 今日录入净持仓
  7:optional i32 sumNetPosition;    // 今日雪橇汇总持仓
  8:optional bool persisted;        // 是否已经持久化
  9:optional i64 dotTimestampMs;    // 打点时间
  10:optional Milestone milestone;   // 记录时间点
  11:optional VerifyStatus verifyStatus; // 该核对记录的状态
  12:optional string note;          // 备注
  13:optional i64 createTimestampMs;
  14:optional i64 lastmodifyTimestampMs;
  15:optional i64 startTimestampMs;  // 持仓数据的开始时间
}

struct ReqDailyPositionDifferenceOption{
  1:optional i64 dateSec;           // 该记录对应的日期，精确到秒
  2:optional i64 tradeAccountId;    // 资金账户id
  3:optional i64 sledContractId;    // 雪橇合约id
  4:optional i64 startDateTimestampMs;// 起始记录时间
  5:optional i64 endDateTimestampMs;  // 结束记录时间
}

struct DailyPositionDifferencePage{
  1:optional i32 total;
  2:optional list<DailyPositionDifference> page;
}

/**
  * 持仓分配时，需要调用的其他服务ao类型
  */
enum AoType{
  ASSET = 0,
  STATIS = 1,
}

/**
  * 持仓分配时，需要添加同步调用任务，用于持仓分配影响到其他服务时，确保成功调用
  */
struct PositionAssignTask{
  1:optional i64 taskId;
  2:optional trade_hosting_position_adjust_assign.PositionAssigned positionAssigned;
  3:optional AoType aoType;
  5:optional i64 createTimestampMs;
  6:optional i64 lastmodifyTimestampMs;
}

/**
  * 查询持仓分配明细
  */
struct ReqPositionAssignedOption{
  1:optional i64 subAccountId;        // 记录分配至子账户id
  2:optional i64 inputId;             // 录入id(内部生成,唯一)
  3:optional i64 tradeAccountId;      // 资金账户id 
  4:optional i64 subUserId;           // 记录分配者userId
  5:optional i64 sledContractId;      // 雪橇合约id

  6:optional i64 assignStartTimestamp;  // 查询起始分配时间（秒）
  7:optional i64 assignEndTimestamp;    // 查询结束分配时间（秒）
}

struct PositionVerifyPage{
  1:optional i32 total;
  2:optional list<PositionVerify> page;
}

struct PositionUnassignedPage{
  1:optional i32 total;
  2:optional list<PositionUnassigned> page;
}

struct PositionManualInputPage{
  1:optional i32 total;
  2:optional list<PositionManualInput> page;
}

struct ManualInputPositionResp{
  1:optional bool success;
}

/**
  * 查询未分配持仓明细
  * 时间条件：大于 startTradeTimestamp, 小于 endTradeTimestamp
  * 所有option使用逻辑与(AND)操作
  */
struct ReqPositionUnassignedOption{
  1:optional i64 manualInputUserId;   // 录入记录的用户id
  2:optional i64 inputId;             // 录入id(内部生成,唯一)
  3:optional i64 tradeAccountId;      // 资金账户id 
  4:optional i64 sledContractId;      // 雪橇合约id
  5:optional trade_hosting_position_adjust_assign.PositionDirection positionDirection; // 持仓方向  

  6:optional i64 startTradeTimestampMs; // 起始交易时间
  7:optional i64 endTradeTimestampMs;   // 结束交易时间
  8:optional i64 startInputTimestampMs; // 起始录入时间
  9:optional i64 endInputTimestampMs;   // 结束录入时间
}

/**
  * 录入持仓明细查询条件
  * 时间条件：大于 startTradeTimestamp, 小于 endTradeTimestamp
  * 所有option使用逻辑与(AND)操作
  */
struct ReqPositionManualInputOption{
  1:optional i64 tradeAccountId;      // 资金账户id 
  2:optional i64 subUserId;           // 记录录入者userId
  3:optional i64 sledContractId;        // 雪橇合约id
  4:optional i64 startTradeTimestampMs; // 起始交易时间
  5:optional i64 endTradeTimestampMs;   // 结束交易时间
  6:optional i64 inputId;             // 录入id
  7:optional i64 subAccountId;        // 目标子账号Id
  8:optional i64 assignSubUserId;        // 持仓分配者userId
  9:optional trade_hosting_position_adjust_assign.PositionDirection positionDirection; // 持仓方向
  10:optional i64 startInputTimestampMs; // 起始录入时间
  11:optional i64 endInputTimestampMs;   // 结束录入时间
}

struct ReqPositionVerifyOption{
  1:optional i64 verifyId;              // 核对id
  2:optional i64 tradeAccountId;        // 资金账户id 
  3:optional i64 startVerifyTimestampMs;// 起始核对时间
  4:optional i64 endVerifyTimestampMs;  // 结束核对时间
  5:optional bool latest;               // 最新核对记录
  6:optional i64 sledContractId;        // 雪橇合约id
}

struct ReqPositionDifferenceOption{
  1:optional i64 verifyId;          // 查询历史核对差异明细
  2:optional i64 tradeAccountId;    // 查询资金账户当前差异明细
  3:optional i64 sledContractId;    // 雪橇合约id
  4:optional i64 startVerifyTimestampMs;// 起始核对时间
  5:optional i64 endVerifyTimestampMs;  // 结束核对时间
}

struct PositionDifferencePage{
  1:optional i32 total;
  2:optional list<PositionDifference> page;
}

struct PositionAssignedPage{
  1:optional i32 total;
  2:optional list<trade_hosting_position_adjust_assign.PositionAssigned> page;
}

struct SettlementTimeRelateSledReqTime{
  1:optional i64 tradeAccountId;
  2:optional string settlementDate;  // 结算日期，格式为yyyy-mm-dd
  3:optional i64 startTimestampMs;  // 建议雪橇记录时间区间开始时间戳(毫秒)
  4:optional i64 endTimestampMs;    // 建议雪橇记录时间区间结束时间戳(毫秒)
}

service(718) TradeHostingPositionAdjust {

  /**
     *  录入持仓明细信息
     * 
     */
    ManualInputPositionResp 1:manualInputPosition(1:comm.PlatformArgs platformArgs, 2:list<PositionManualInput> positionManualInputs) throws (1:comm.ErrorInfo err);

    /**
     *  查询录入的持仓明细信息
     */
    PositionManualInputPage 3:reqManualInputPosition(1:comm.PlatformArgs platformArgs, 2:ReqPositionManualInputOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询未分配的持仓明细信息
     */
    PositionUnassignedPage 4:reqPositionUnassigned(1:comm.PlatformArgs platformArgs, 2:ReqPositionUnassignedOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询已分配的持仓明细信息
     */
    PositionAssignedPage 5:reqPositionAssigned(1:comm.PlatformArgs platformArgs, 2:ReqPositionAssignedOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

  /**
     *  分配持仓明细信息
     *  
     */
    trade_hosting_position_adjust_assign.AssignPositionResp 6:assignPosition(1:comm.PlatformArgs platformArgs, 2:list<PositionAssignOption> assignOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询持仓编辑锁信息
     *  
     */
    PositionEditLock 7:reqPositionEditLock(1:comm.PlatformArgs platformArgs, 2:string lockKey) throws (1:comm.ErrorInfo err);

    /**
     *  申请持仓编辑加锁
     *  
     */
    void 8:addPositionEditLock(1:comm.PlatformArgs platformArgs, 2:PositionEditLock positionEditLock) throws (1:comm.ErrorInfo err);

    /**
     *  释放持仓编辑锁
     *  
     */
    void 9:removePositionEditLock(1:comm.PlatformArgs platformArgs, 2:PositionEditLock positionEditLock) throws (1:comm.ErrorInfo err);

    /**
     *  查询持仓核对历史
     */ 
    PositionVerifyPage 10:reqPositionVerify(1:comm.PlatformArgs platformArgs, 2:ReqPositionVerifyOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  查询持仓核对明细
     */ 
    PositionDifferencePage 11:reqPositionDifference(1:comm.PlatformArgs platformArgs, 2:ReqPositionDifferenceOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /**
     *  结算日期，格式为XXXX-XX-XX
     */ 
    SettlementTimeRelateSledReqTime 12:reqSettlementTimeRelateSledReqTime(1:comm.PlatformArgs platformArgs, 2:i64 tradeAccountId, 3:string settlementDate) throws (1:comm.ErrorInfo err);


    /** 
     *  查询日常持仓核对明细
     */ 
    DailyPositionDifferencePage 13:reqDailyPositionDifference(1:comm.PlatformArgs platformArgs, 2:ReqDailyPositionDifferenceOption option,3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    /** 
     *  更新日常持仓核对的备注和核对状态信息
     */ 
    void 14:updateDailyPositionDifferenceNote(1:comm.PlatformArgs platformArgs, 2:DailyPositionDifference difference) throws (1:comm.ErrorInfo err);

    // ======================== 重置数据 =============================
    /**
     *  移除托管机上持仓资金的所有数据记录
     */
    void 99:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}