/**
  * 资产相关错误码, 值必须在5001-5200之间
  */
namespace * xueqiao.trade.hosting.position.adjust.thriftapi

enum TradeHostingPositionAdjustErrorCode {
    ERROR_POSITION_NOT_FOUND = 5201,  //持仓信息不存在
    ERROR_POSITION_VOLUME_ERROR = 5202, //分配的持仓量与所存在的不匹对 
    ERROR_POSITION_TRADE_ACCOUNT_NOT_SUPPORT_CONTRACT = 5203, //资金账号不支持该合约
    ERROR_POSITION_ASSIGN_ERROR_IN_ASSET = 5204, //分配持仓调用asset服务失败
}