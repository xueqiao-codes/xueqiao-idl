/**
  * 为订单执行提供响应的风控接口
  */
namespace * xueqiao.trade.hosting.risk.dealing.thriftapi

include "../../comm.thrift"
include "trade_hosting_basic.thrift"

/**
  *  风控行为类型
  */
enum EHostingExecOrderRiskActionType {
    RISK_PASSED = 1,    // 风控通过
    RISK_FORBIDDEN = 2, // 风控禁止
}

struct HostingExecOrderRiskAction {
    1:optional EHostingExecOrderRiskActionType actionType;
    2:optional string actionMessage;
}


service(726) TradeHostingRiskDealing {
    HostingExecOrderRiskAction 1:riskCheck(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId
            , 3:trade_hosting_basic.HostingExecOrderContractSummary orderContractSummary
            , 4:trade_hosting_basic.HostingExecOrderDetail orderDetail) throws (1:comm.ErrorInfo err);
}