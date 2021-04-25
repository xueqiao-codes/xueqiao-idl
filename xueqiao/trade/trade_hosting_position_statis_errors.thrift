/**
  * 持仓统计模块错误码，取值区间是[5500, 5600]
  */
namespace * xueqiao.trade.hosting.position.statis.thriftapi

enum StatPositionErrorCode {

    ERROR_STAT_POSITION_INNER_ERROR = 5500,                        // 内部错误

    ERROR_STAT_POSITION_IDMAKER = 5501,                        // IdMaker异常
    ERROR_STAT_POSITION_XQTRADE_RELATED_ITEMS_EMPTY = 5502,    // 成交关联数据为空
    ERROR_STAT_POSITION_ITEM_NOT_EXIST = 5510,                 // 持仓明细项不存在
    ERROR_STAT_POSITION_CLOSED_ITEMS_NOT_MATCH = 5511,         // 平仓的买卖双方数量不匹配
    ERROR_STAT_POSITION_CLOSED_QUANTITY_TOO_LARGE = 5512,      // 平仓的数量过大，超过持仓的数量
    ERROR_STAT_CLOSED_POSITION_ITEM_NOT_EXIST = 5513,          // 平仓明细项不存在
    ERROR_STAT_POSITION_UNIT_NOT_EXIST = 5514,                 // 持仓小单元不存在
    ERROR_STAT_POSITION_DISASSEMABLE_CONTACT = 5515,           // 拆分约合（合约不能拆分）
    
    ERROR_STAT_POSITION_COMMODITY_CONFIG_NOT_FOUND = 5516,     // 雪橇商品的配置信息不存在
    
    ERROR_STAT_POSITION_FAIL_TO_FIND_COMPOSE_BASE_CURRENCY_IN_QCONF = 5517,     // qconf中找不到套利计算的基币币种
    ERROR_STAT_POSITION_FAIL_TO_FIND_EXCHANGERATE_IN_QCONF = 5518,              // qconf中找不到汇率信息

    ERROR_STAT_POSITION_CONTRACT_NOT_EXPIRED = 5519,              // 合约未过期，删除合约持仓失败
    ERROR_STAT_POSITION_POSITION_NOT_CLOSED = 5520,               // 合约过期后，买入量==0 || 卖出量==0 才可以删除，否则提示用户，先做完平仓配对
}