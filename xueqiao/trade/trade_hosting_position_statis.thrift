/**
  * 持仓统计
  */
namespace * xueqiao.trade.hosting.position.statis
  
include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_arbitrage.thrift"
include "trade_hosting_position_adjust_assign.thrift"

// （通用的）标的方向
enum StatDirection {
    STAT_BUY = 0,   // 买
    STAT_SELL = 1,  // 卖
}

// 统计数据来源渠道
enum DataSourceChannel {
    FROM_XQ_CONTRACT_TRADE = 1,                   // 合约标的成交
    FROM_XQ_COMPOSE_TRADE = 2,                    // 组合标的成交
    FROM_XQ_PARTIAL_COMPOSE_TRADE = 3,            // 组合标的部分成交（瘸腿）

    FROM_CONTRACT_ASSIGNATION = 10,               // 合约分配

    FROM_COMPOSE_CONSTRUCTION = 20,               // 组合构造  （废弃）
    FROM_COMPOSE_REVERSE_CONSTRUCTION = 21,       // 组合反向构造  （废弃）
    FROM_CONTRACT_MERGE = 22,                     // 合并合约

    FROM_COMPOSE_TRADE_DISASSEMBLY = 30,          // 成交的组合标的拆解 （废弃）
    FROM_COMPOSE_CONSTRUCTION_DISASSEMBLY = 31,   // 构造的组合拆解 （废弃）
	FROM_COMPOSE_DISASSEMBLY = 32,                // 组合的拆解
}

// 源数据类型
enum SourceType {
    ST_UNKNOWN = 0, // 未知（无效）
    ST_ASSIGN = 1,  // 录入分配
    ST_TRADE = 2,   // 成交
    ST_MERGE_TO_COMPOSE_NOT_TRADE = 3,  // 合并合约为组合时不参与交易的腿小单元数据
}

// 统计数据源
struct StatDataSource {
    1:optional DataSourceChannel sourceDataChannel;        // 数据渠道
    2:optional i64 sourceDataTimestampMs;                  // 数据时间
}

// （外部）数据源
struct ExternalDataSource {
    1:optional SourceType sourceType;               // 源数据类型
    2:optional i64 sourceId;                        // 对应的源数据ID(来源自哪条源数据记录)
}

// 统计标的对象（抽象组合与合约）
struct StatPositionItem {
    1:optional i64 positionItemId;                                            // 统计标的对象id
    2:optional i64 subAccountId;                                              // 子账户id
    3:optional string targetKey;                                              // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;        // 标的类型
    5:optional double price;                                                  // 价格
    6:optional i32 quantity;                                                  // 数量
    7:optional StatDirection direction;                                       // 方向
    8:optional StatDataSource source;                                         // 数据来源

    20:optional i64 createTimestampMs;                                        // 记录创建时间
    21:optional i64 lastmodifyTimestampMs;                                    // 记录最新修改时间
}

// 统计标的的基本单元（抽象组合腿与合约）
struct StatPositionUnit {
    1:optional i64 unitId;                           // 单元id
    2:optional i64 positionItemId;                   // 统计标的对象id (索引)
    3:optional i64 sledContractId;                   // 雪橇合约id
    4:optional double unitPrice;                     // 价格
    5:optional i32 unitQuantity;                     // 数量 （实际成交的数量）
    6:optional StatDirection direction;              // 方向 （实际成交的方向）
    7:optional i64 sourceDataTimestampMs;            // 数据时间

    10:optional i64 subAccountId;
    11:optional string targetKey;
    12:optional trade_hosting_arbitrage.HostingXQTargetType targetType;
    131:optional ExternalDataSource source;
}

// 平仓小单元
struct StatClosedUnit {
    1:optional i64 closedUnitId;                     // 平仓小单元id
    2:optional i64 closedItemId;                     // 平仓项id
    3:optional i64 positionUnitId;                   // 持仓小单元id
    4:optional i64 positionItemId;                   // 统计标的对象id
    5:optional i64 sledContractId;                   // 雪橇合约id
    6:optional double unitPrice;                     // 价格
    7:optional i32 unitQuantity;                     // 数量 （实际成交的数量）
    8:optional StatDirection direction;              // 方向 （实际成交的方向）
    9:optional i64 sourceDataTimestampMs;            // 数据时间

    15:optional i64 subAccountId;
    16:optional string targetKey;
    17:optional trade_hosting_arbitrage.HostingXQTargetType targetType;
    18:optional ExternalDataSource source;
}

// 持仓统计
struct StatPositionSummary {
    2:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional i64 subAccountId;                                            // 子账户id
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
    5:optional i64 longPosition;                                            // 多头仓量
    6:optional i64 shortPosition;                                           // 空头仓量
    7:optional i64 netPosition;                                             // 净仓量
    8:optional double positionAvgPrice;                                     // 持仓均价

    20:optional i64 createTimestampMs;
    21:optional i64 lastmodifyTimestampMs;
}

// 持仓统计 根据行情计算持仓动态信息
struct StatPositionDynamicInfo {
    1:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    2:optional i64 subAccountId;                                            // 子账户id
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型

    5:optional double lastPrice;         // 最新成交价
    6:optional double positionProfit;    // 持仓盈亏
    7:optional double closedProfit;      // 平仓盈亏
    8:optional double totalProfit;       // 总盈亏
    9:optional double positionValue;     // 持仓货值
    10:optional double leverage;         // 杠杆
	13:optional map<string, double> positionValueMap;  // map<currency, positionValue> 各币种下的货值

    15:optional string currency;         // 币种

    20:optional i64 modifyTimestampMs;   // 更新时间
}

// 持仓统计汇总信息
struct StatPositionSummaryEx {
    1:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    2:optional i64 subAccountId;                                            // 子账户id
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型

    5:optional StatPositionSummary positionSummary;
    6:optional StatPositionDynamicInfo positionDynamicInfo;
}

// 平仓收益
struct ClosedProfit {
    2:optional string tradeCurrency;         // 交易币种
    3:optional double closedProfitValue;     // 平仓收益
}

// 平仓记录 (临时平仓表 和 归档表)
struct StatClosedPositionSummary {
    1:optional i64 closedId;                                                // 平仓id
    2:optional i64 subAccountId;                                            // 子账户id
    3:optional string targetKey;                                            // 标的唯一Key
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
    5:optional i64 closedPosition;                                          // 平仓量
    8:optional list<ClosedProfit> closedProfits;                            // 平仓收益（所有的币种下的平仓收益，key为币种，value为对应币种的平仓收益）
    9:optional double spreadProfit;                                         // 价差收益

    20:optional i64 closedTimestampMs;                                      // 平仓时间
    21:optional i64 archivedDateTimestampMs;                                // 归档日期
}

// 按天记录的平仓记录 (一天内的所有的平仓记录的汇总)
struct StatClosedPositionDateSummary {
    1:optional i64 dateSummaryId;
    2:optional i64 subAccountId;                                            // 子账户id
    3:optional string targetKey;                                            // 标的唯一Key
    4:optional i64 archivedDateTimestampMs;                                 // 归档日期
    5:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
    6:optional i64 closedPosition;                                          // 平仓量
    9:optional list<ClosedProfit> closedProfits;                            // 平仓收益（所有的币种下的平仓收益，key为币种，value为对应币种的平仓收益）
    10:optional double spreadProfit;                                        // 价差收益
}

// 平仓明细记录 (对应两张数据表，临时平仓明细数据表 和 归档平仓明细数据表)
struct StatClosedPositionItem {
    1:optional i64 closedItemId;                                              // 平仓明细项id
    2:optional i64 closedId;                                                  // 对应的平仓id
    6:optional i64 positionItemId;                                            // 原持仓明细id
    7:optional i64 subAccountId;                                              // 子账户id
    8:optional string targetKey;                                              // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    9:optional trade_hosting_arbitrage.HostingXQTargetType targetType;        // 标的类型
    10:optional double price;                                                 // 价格
    11:optional i32 closedQuantity;                                           // 平仓数量
    12:optional StatDirection direction;                                      // 方向
    13:optional StatDataSource source;                                        // 数据来源
    14:optional i64 positionCreateTimestampMs;                                // 持仓记录创建时间

    20:optional i64 closedTimestampMs;                                        // 平仓时间
    21:optional i64 archivedDateTimestampMs;                                  // 归档日期
}

//****************************************************************************************
// 接口强相关数据结构
//****************************************************************************************

// 统计组合腿
struct StatComposeLeg {
    1:optional i64 sledContractId;                                                     // 雪橇合约ID
    3:optional double legTradePrice;                                                   // 价格
}

// 录入统计组合
struct StatContructComposeReq {
    1:optional i64 subAccountId;                                                // 子账户id
    2:optional i64 composeGraphId;                                              // 组合图ID
    3:optional StatDirection diretion;                                          // 方向
    4:optional i32 volume;                                                      // 数量
    5:optional double composePrice;                                             // 组合价差
    10:optional list<StatComposeLeg> composeLegs;                               // 组合腿列表
}

// 持仓信息
struct PositionItemData {
    1:optional i64 positionItemId;
    2:optional i32 quantity;
}

// 合并合约为组合 腿数据
struct MergeComposeLegData {
    1:optional i64 positionItemId; // 当腿参与交易时，才需要输入positionItemId
    2:optional i64 sledContractId; // 必填
    3:optional i32 quantity;       // 当腿为不参与交易时，quantity为0
    4:optional double price;       // 当腿为不参与交易时，才需要输入price，则否被忽略
    5:optional StatDirection diretion;  // 方向
}

// 合并合约为组合请求结构
struct StatMergeToComposeReq {
    1:optional i64 subAccountId;                                                // 子账户id
    2:optional i64 composeGraphId;                                              // 组合图ID
    3:optional double composePrice;                                             // 组合价差
    4:optional i32 volume;                                                      // 组合数量
    5:optional StatDirection diretion;                                          // 方向
    10:optional list<MergeComposeLegData> mergeComposeLegDataList;              // 组合腿列表
}

// 拆组合信息
struct DisassembleComposePositionReq {
    1:optional i64 subAccountId;                                              // 子账户id
    2:optional string targetKey;                                              // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional list<PositionItemData> positionItemDataList;
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;        // 标的类型
}

// 要平仓的持仓明细项
struct ClosedPositionDetailItem {
    1:optional i64 positionItemId;        // 统计持仓明细id
    2:optional i32 closedVolume;          // 平仓量
} 

// 批量平仓信息
struct BatchClosedPositionReq {
    1:optional i64 subAccountId;                                            // 子账户id
    2:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional list<ClosedPositionDetailItem> closedPositionDetailItems     // 平仓信息列表
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
}

// 持仓记录页
struct StatPositionSummaryPage {
    1:optional i32 totalNum;
    2:optional list<StatPositionSummary> statPositionSummaryList;
}

// 持仓汇总记录页
struct StatPositionSummaryExPage {
    1:optional i32 totalNum;
    2:optional list<StatPositionSummaryEx> statPositionSummaryExList;
}

// 查持仓记录条件
struct QueryStatPositionSummaryOption {
    1:required i64 subAccountId;                                            // 子账户id
    2:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
}

// 持仓详情页
struct StatPositionItemPage {
    1:optional i32 totalNum;
    2:optional list<StatPositionItem> statPositionItemList;
}

// 查询持仓详情条件
struct QueryStatPositionItemOption {
    1:optional i64 subAccountId;                                           // 子账户id
    2:optional i64 positionItemId;                                         // 统计持仓明细id
    3:optional string targetKey;                                           // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;     // 标的类型
}

// 平仓记录页
struct StatClosedPositionDateSummaryPage {
    1:optional i32 totalNum;
    2:optional list<StatClosedPositionDateSummary> statClosedPositionDateSummaryList;
}

// 查询平仓记录条件(平仓 + 归档)
struct QueryStatClosedPositionDateSummaryOption {
    1:optional i64 subAccountId;                                           // 子账户id
    2:optional string targetKey;                                           // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;     // 标的类型
    7:optional i64 archiveStartDateTimestampMs;                            // 开始时间（开始天内的时间缀）
    8:optional i64 archiveEndDateTimestampMs;                              // 结束时间（结束天内的时间缀）
    9:optional i64 archivedDateTimestampMs;                                // 归档时间
}

// 平仓明细
struct StatClosedPositionDetail {
    1:optional i32 totalNum;
    2:optional list<StatClosedPositionItem> statClosedPositionItemList;
}

// 查询平仓明细条件
struct QueryStatClosedPositionItemOption {
    1:optional i64 closedId;                                                // 平仓id
    2:optional i64 subAccountId;                                            // 子账户id
    3:optional string targetKey;                                            // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    4:optional trade_hosting_arbitrage.HostingXQTargetType targetType;      // 标的类型
}

// 查询归档明细条件
struct QueryStatArchiveItemOption {
    1:optional i64 closedId;                                             // 平仓id
    3:optional i64 subAccountId;                                         // 子账户id
    4:optional string targetKey;                                         // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    5:optional trade_hosting_arbitrage.HostingXQTargetType targetType;   // 标的类型
    10:optional i64 archiveStartDateTimestampMs;                         // 开始时间（开始天内的时间缀）
    11:optional i64 archiveEndDateTimestampMs;                           // 结束时间（结束天内的时间缀）
    12:optional i64 archivedDateTimestampMs;                             // 归档时间
}

// 查询持仓明细条件
struct QueryStatPositionUnitOption {
    1:optional i64 subAccountId;                                            // 子账户id
    2:optional i64 positionItemId;
}

// 持仓明细页
struct StatPositionUnitPage {
    1:optional i32 totalNum;
    2:optional list<StatPositionUnit> statPositionUnitList;
}

// 查询平仓历史记录条件
struct QueryHistoryClosedPositionOption {
    1:optional i64 subAccountId;                                           // 子账户id
    2:optional string targetKey;                                           // 雪橇标的(同种标的类型下)唯一Key（注：不同类型的标的，targetKey不保证唯一性）
    3:optional trade_hosting_arbitrage.HostingXQTargetType targetType;     // 标的类型
    6:optional i64 closedDateTimestampMs;                                  // 平仓时间
}


//******************************************************************************************
// 服务接口
//******************************************************************************************

service(717) TradeHostingPositionStatis {
    void 1:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /*       用户操作        */
    // 录入统计组合(过期废弃接口)
    void 2:contructCompose(1:comm.PlatformArgs platformArgs, 2:StatContructComposeReq contructComposeReq) throws (1:comm.ErrorInfo err);
    
    // 拆分统计组合
    void 3:disassembleCompose(1:comm.PlatformArgs platformArgs, 2:DisassembleComposePositionReq disassembleComposePositionReq) throws (1:comm.ErrorInfo err);
    
    // 批量平仓
    void 4:batchClosePosition(1:comm.PlatformArgs platformArgs, 2:BatchClosedPositionReq batchClosedPositionReq) throws (1:comm.ErrorInfo err);
    
    // 恢复当天平仓
    void 5:recoverClosedPosition(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:string targetKey, 4:trade_hosting_arbitrage.HostingXQTargetType targetType) throws (1:comm.ErrorInfo err);
    
    /*       其他模块导入数据      */
    // 导入分配数据
    void 6:assignPosition(1:comm.PlatformArgs platformArgs, 2:trade_hosting_position_adjust_assign.PositionAssigned positionAssigned) throws (1:comm.ErrorInfo err);

    // 合并合约为组合
    void 7:mergeToCompose(1:comm.PlatformArgs platformArgs, 2:StatMergeToComposeReq mergeToComposeReq) throws (1:comm.ErrorInfo err);

    // 删除过期合约持仓
    void 8:deleteExpiredStatContractPosition(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:i64 sledContractId) throws (1:comm.ErrorInfo err);

    /*       查询        */
    // 查询统计持仓
    StatPositionSummaryPage 10:queryStatPositionSummaryPage(1:comm.PlatformArgs platformArgs, 2:QueryStatPositionSummaryOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    // 查询持仓详情
    StatPositionItemPage 11:queryStatPositionItemPage(1:comm.PlatformArgs platformArgs, 2:QueryStatPositionItemOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    // 查询当天平仓记录
    StatClosedPositionDateSummaryPage 12:queryCurrentDayStatClosedPositionPage(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:string targetKey, 4:trade_hosting_arbitrage.HostingXQTargetType targetType) throws (1:comm.ErrorInfo err);
    
    // 查询平仓明细
    StatClosedPositionDetail 13:queryStatClosedPositionDetail(1:comm.PlatformArgs platformArgs, 2:QueryStatClosedPositionItemOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询归档记录
    StatClosedPositionDateSummaryPage 14:queryArchivedClosedPositionPage(1:comm.PlatformArgs platformArgs, 2:QueryStatClosedPositionDateSummaryOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
    
    // 查询归档（平仓）明细
    StatClosedPositionDetail 15:queryArchivedClosedPositionDetail(1:comm.PlatformArgs platformArgs, 2:QueryStatArchiveItemOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询统计汇总信息（包含动态计算部分）
    StatPositionSummaryExPage 16:queryStatPositionSummaryExPage(1:comm.PlatformArgs platformArgs, 2:QueryStatPositionSummaryOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询持仓明细
    StatPositionUnitPage 17:queryStatPositionUnitPage(1:comm.PlatformArgs platformArgs, 2:QueryStatPositionUnitOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询历史平仓记录
    StatClosedPositionDateSummaryPage 18:queryHistoryClosedPositionPage(1:comm.PlatformArgs platformArgs, 2:QueryHistoryClosedPositionOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 查询历史平仓明细
    StatClosedPositionDetail 19:queryHistoryClosedPositionDetail(1:comm.PlatformArgs platformArgs, 2:QueryHistoryClosedPositionOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}