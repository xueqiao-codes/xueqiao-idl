/**
  *  负责行情订阅规划
  */
namespace * xueqiao.quotation.plan.bo

include "../../comm.thrift"
include "../../page.thrift"
include "quotation_account.thrift"

enum EQuotationPlanBoErrorCode {
    ERROR_GENPREVIEW_ISHANDING = 1001,  // 正在生成预览规划中
    ERROR_PREVIEW_NOTEXIST = 1002,  // 预览规划不存在，无法提交和获取
}

/**
  *  订阅账号类
  */
struct SubscribeAccountClass {
    1:optional i32 subscribeNum;  // 订阅的个数
    2:optional i64 quotationAccountId;  // 行情账号ID
    3:optional quotation_account.DeploySet quotationDeploySet; // 规划时行情账号所处的部署区域
}

/**
  * 订阅商品订阅类， 订阅条目需要在每天具体实例化
  */
struct SubscribeCommodityClass {
    1:optional i64 classId;

    2:optional string sledExchangeMic;  //订阅商品交易所MIC
    3:optional i64 sledCommodityId; // 雪橇商品ID
    4:optional i16 sledCommodityType;    // 雪橇商品类型数值
    5:optional string sledCommodityCode; // 雪橇商品编码
    6:optional quotation_account.QuotationPlatformEnv platformEnv; 
    
    7:optional list<i32> activeMonths;  // 活跃月份
    8:optional list<i32> inactiveMonths; // 非活跃月份
    
    10:optional i32 activeSubscribeNum;  // 活跃合约需要订阅的数量
    11:optional i32 inActiveSubscribeNum; // 非活跃合约订阅的数量
    
    13:optional list<list<SubscribeAccountClass>> subscribeAccounts;  // 订阅的账号列表, 最外层表现备份数
    
    15:optional i64 createTimestampMs;  // 订阅类生成时间
    
    17:optional quotation_account.ContractActiveType activeType; // 活跃合约类型
    18:optional string fixedContractCode;  // 固定合约编码
}

/**
  * 实际每天产生的订阅条目
  */
struct SubscribeContractItem {
    1:optional i64 itemId;  // 订阅条目的ID
    2:optional i64 classId;  // 实例化条目的classId
    
    3:optional string sledExchangeMic;  //订阅商品交易所MIC
    4:optional i64 sledCommodityId;  // 雪橇商品ID
    5:optional i16 sledCommodityType; // 商品类型数值
    6:optional string sledCommodityCode; // 商品类型编码
    7:optional string sledContractCode;  // 订阅合约编码
    8:optional i64 sledContractId;  // 合约ID
    9:optional quotation_account.QuotationPlatformEnv platformEnv; // 行情订阅环境
    
    11:optional quotation_account.DeploySet quotationDeploySet; // 生成时，行情账号的部署区域
    12:optional i64 quotationAccountId;  // 订阅该合约的账号ID
    13:optional bool isForActive;  // 由活跃合约订阅规则衍生
    
    14:optional i64 createTimestampMs;  // 订阅条目生成时间
}

enum EGenPreviewStatus {
    PREVIEW_EMPTY = 0,  // 目前没有生成预览任务
    PREVIEW_GENTASK_RUNNING = 1,  // 目前生成预览任务正在执行
    PREVIEW_FINISHED = 2,  // 目前已经生成一个版本Preview，可以提交Preview来生效新的规划
    PREVIEW_GENFAILED = 3, // 生成预览失败
}

struct GenPreviewState {
    1:optional EGenPreviewStatus status;  // 状态定义
    2:optional string stateMsg; // 状态信息
    3:optional i64 lastUpdateTimestampMs; // 上次更新时间
}

struct QuerySubscribeContractItemOption {
    1:optional set<i64> quotationAccountIds;
    2:optional set<i64> sledCommodityIds;
    3:optional quotation_account.QuotationPlatformEnv platformEnv;
    4:optional quotation_account.DeploySet quotationDeploySet;
}

struct SubscribeContractItemPage {
    1:optional i32 totalCount;
    2:optional list<SubscribeContractItem> resultList;
}

service(888) QuotationPlanBo {
    /**
      *  启动生成预览类任务
      */
    GenPreviewState 1:startGenPreviewSCClasses(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      *  获取当前生成预览类任务状态
      */
    GenPreviewState 2:getGenPreviewState(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      * 提交预览商品订阅类
      */
    void 3:commitPreviewSCClasses(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    /**
      *  查询当前订阅合约列表项
      */
    SubscribeContractItemPage 4:querySubscribeContractItemPage(1:comm.PlatformArgs platformArgs
            , 2:QuerySubscribeContractItemOption queryOption
            , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
            
    /**
      *  获取当前正在使用的规划类
      */
    list<SubscribeCommodityClass> 5:getCurrentSCClasses(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    
    /**
      *  获取生成的预览规划类
      */
    list<SubscribeCommodityClass> 6:getPreviewSCClasses(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
} 