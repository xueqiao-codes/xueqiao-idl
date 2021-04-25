/**
  * 风险管理错误码
  */
namespace * xueqiao.trade.hosting.risk.manager.thriftapi

enum TradeHostingRiskManagerErrorCode {
    ERROR_RISKRULE_JOINT_OPERATION_ERROR = 6000,  // 规则版本操作错误, 存在数据不同步的情况
}