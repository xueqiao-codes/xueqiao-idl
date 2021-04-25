/**
  * 风险管理相关内容
  */
namespace * xueqiao.trade.hosting.risk.manager.thriftapi

include "../../comm.thrift"

const string PARAM_RISKITEM_COMMODITY_ID = "cmId";
const string PARAM_RISKITEM_CONTRACT_ID = "cnId";

// 风控维度级别
enum EHostingRiskLevel {
    OPERATION_ACCOUNT_GLOBAL = 1,  // 操作账户全局风控
    OPERATION_ACCOUNT_COMMODITY = 2, // 操作账户商品风控
}

// 风控项的值类型
enum EHostingRiskItemValueType {
    DOUBLE_VALUE = 1,  // 2位小数的浮点
    PERCENT_VALUE = 2,  // 2位小数的百分比
    LONG_VALUE = 3, // 整数数值
}

// 风控项的值级别
enum EHostingRiskItemValueLevel {
    OPERATION_ACCOUNT_GLOBAL_VALUE = 1,  // 操作账户全局风控指标
    OPERATION_ACCOUNT_COMMODITY_VALUE = 2, // 操作账户商品风控指标
    OPERATION_ACCOUNT_CONTRACT_VALUE = 3,  // 操作账户合约风控指标 
}

// 风险阶梯形状
enum EHostingRiskLadderType {
    HIGH_VALUE_HIGH_RISK = 1,  // 值越高，风险越高
    LOW_VALUE_HIGH_RISK = 2,   // 值越低，风险越高 
}

// 支持的风控项的定义
struct HostingRiskSupportedItem {
    1:optional string itemId;           // 风控支持项
    2:optional EHostingRiskLevel riskLevel;  // 风控级别
    3:optional string itemCnName;       // 分控项中文名称
    4:optional string itemDescription;  // 风控项描述
    5:optional EHostingRiskItemValueType itemValueType; // 风控项的值描述
    6:optional EHostingRiskLadderType riskLadderType;  // 风险阶梯
    7:optional EHostingRiskItemValueLevel itemValueLevel; // 指示风控项的值级别
    8:optional i32 orderNum;           // 指引客户端条目编排的排序值
}

struct HostingRiskRuleItemValue {
    1:optional i64 longValue;
    2:optional double doubeValue;
}

struct HostingRiskRuleItem {
    1:optional bool ruleEnabled;  // 是否启用规则
    2:optional HostingRiskRuleItemValue alarmValue;                  // 预警阈值
    3:optional HostingRiskRuleItemValue forbiddenOpenPositionValue;  // 禁止开仓域值
}

/**
  * 风控结构
  */
struct HostingRiskRuleJoint {
    1:optional i32 version;
    2:optional i64 subAccountId;   // 子账户ID
    3:optional bool riskEnabled;   // 是否启用风险管理
    4:optional set<string> globalOpenedItemIds;  // 全局关注的ItemIds
    5:optional map<string, HostingRiskRuleItem> globalRules; // 全局规则
    6:optional set<i64> tradedCommodityIds;  // 可交易的商品ID
    7:optional map<i64, map<string, HostingRiskRuleItem>> commodityRules; // 商品的规则
    8:optional set<string> commodityOpenedItemIds;
}

/**
  * 风控条目的数据信息
  */
struct HostingRiskItemDataInfo {
    1:optional string itemId;                           // 风控条目ID
    2:optional i64 sledCommodityId;                     
    3:optional i64 sledContractId;                      
    4:optional HostingRiskRuleItemValue itemValue;      // 对应的值
    5:optional bool alarmTriggered;                     // 对应的值是否触发了阈值预警
    6:optional bool forbiddenOpenPositionTriggered;     // 对应的值是否触发了禁止开仓
}

/**
  * 切面数据聚合
  */
struct HostingRiskFrameDataInfo {
    1:optional list<HostingRiskItemDataInfo> globalDataInfos;
    2:optional map<i64, list<HostingRiskItemDataInfo>> commodityDataInfos;
    3:optional map<i64, map<i64, list<HostingRiskItemDataInfo>>> contractDataInfos;
}

service(725) TradeHostingRiskManager {
    /**
      * 获取所有支持的风控项
      */
    list<HostingRiskSupportedItem> 1:getAllSupportedItems(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取风控结构的版本
      */
    i32 2:getRiskRuleJointVersion(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取风控结构
      */
    HostingRiskRuleJoint 3:getRiskRuleJoint(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId) throws (1:comm.ErrorInfo err);
    
    /**
      * 批量设置关注风控项
      */
    HostingRiskRuleJoint 4:batchSetSupportedItems(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId
            , 3:i32 version
            , 4:set<string> openedItemIds
            , 5:set<string> closedItemIds) throws (1:comm.ErrorInfo err);
            
    /**
      *  批量操作可交易商品, 禁用商品会导致商品上的规则禁用
      */
    HostingRiskRuleJoint 5:batchSetTradedCommodityItems(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId
            , 3:i32 version
            , 4:set<i64> enabledCommodityIds
            , 5:set<i64> disabledCommodityIds) throws (1:comm.ErrorInfo err);
            
    /**
      * 批量设置全局风控规则
      *   以全局开放指标为Key
      */        
    HostingRiskRuleJoint 6:batchSetGlobalRules(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId
            , 3:i32 version
            , 4:map<string, HostingRiskRuleItem> ruleItems) throws (1:comm.ErrorInfo err);  
            
    /**
      * 批量设置商品风控规则
      */
    HostingRiskRuleJoint 7:batchSetCommodityRules(1:comm.PlatformArgs platformArgs
           , 2:i64 subAccountId
           , 3:i32 version
           , 4:map<i64, map<string, HostingRiskRuleItem>> rules) throws (1:comm.ErrorInfo err);
           
    /**
      * 开启和关闭风控
      */
    HostingRiskRuleJoint 8:setRiskEnabled(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId
            , 3:i32 version
            , 4:bool riskEnabled) throws (1:comm.ErrorInfo err);
            
    /**
      * 获取风控数据
      */        
    HostingRiskFrameDataInfo 9:getRiskFrameDataInfo(1:comm.PlatformArgs platformArgs
            , 2:i64 subAccountId) throws (1:comm.ErrorInfo err);
           
}