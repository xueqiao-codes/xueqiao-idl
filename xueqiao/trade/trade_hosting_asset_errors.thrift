/**
  * 资产相关错误码, 值必须在5001-5200之间
  */
namespace * xueqiao.trade.hosting.asset.thriftapi

enum TradeHostingAssetErrorCode {
    ERROR_ASSET_TRADE_DETAIL_COMMODITY_NOT_FOUND = 5001,  // 成交记录中的雪橇商品不存在
    ERROR_ASSET_TRADE_DETAIL_COMMODITY_CONFIG_NOT_FOUND = 5002,  // 成交记录中查询到雪橇商品的配置信息不存在
    ERROR_ASSET_TRADE_DETAIL_COMMODITY_CONFIG_ERROR = 5003,  // 成交记录中查询到雪橇商品的配置信息设置错误
    ERROR_ASSET_TRADE_DETAIL_CONTRACT_NOT_FOUND = 5004,  // 成交记录中的雪橇合约不存在
    ERROR_ASSET_FUND_CHANGE_DIRECTION_NOT_FOUND = 5005,  // 出入金类型不存在
    ERROR_ASSET_FUND_CHANGE_OP_MONEY_DUPLICATE_TICKET = 5006,  // 出入金重复票据，操作重复
    ERROR_ASSET_FUND_CHANGE_BALANCE_NOT_ENOUGH = 5007,  // 操作账户余额不足
    ERROR_ASSET_EXECUTOR_NOT_FOUND = 5008,  // 计算线程标记不存在
    ERROR_ASSET_CONTRACT_IS_NOT_EXPIRED = 5009,  // 合约并没过期
}