/**
  * 雪橇持仓分配类型
  */
namespace * xueqiao.trade.hosting.position.adjust.assign.thriftapi

// 持仓方向
enum PositionDirection{
    POSITION_BUY = 0,
    POSITION_SELL = 1,
}

/**
  * 持仓分配明细
  */
struct PositionAssigned{
  1:optional i64 assignId;            // 分配id
  2:optional i64 subAccountId;        // 子账户id
  3:optional i64 inputSubUserId;      // 录入记录的用户id
  4:optional i64 assignSubUserId;     // 记录分配者userId
  5:optional i64 inputId;             // 录入明细id(内部生成,唯一)
  6:optional i64 tradeAccountId;      // 资金账户id
  7:optional i64 sledContractId;      // 雪橇合约id
  8:optional i64 sledCommodityId;     // 雪橇商品id

  10:optional double price;           // 价格
  11:optional i32 volume;             // 分配数量
  12:optional PositionDirection positionDirection; // 持仓方向
  13:optional i64 positionTimestampMs;// 持仓生效时间

  30:optional i64 createTimestampMs;
  31:optional i64 lastmodifyTimestampMs;
}

struct AssignPositionResp{
    1:optional bool success;
}
