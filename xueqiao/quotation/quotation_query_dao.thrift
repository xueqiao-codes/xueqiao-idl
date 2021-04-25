namespace * xueqiao.quotation.query.dao


include "../../comm.thrift"
include "quotation_item.thrift"

const i32 MAX_QUERYTICK_SECONDS = 900; // 一次性最多查询15分钟的tick数据
const i32 MAX_QUERYKLINE_COUNT = 1440; // 一次性最多获取分钟行情的个数限制

enum QuotationQueryDaoErrorCode {
    CONTRACT_NOT_FOUND = 3001,  // 合约未找到
    QUERY_LIMITED = 3002,    // 查询范围过大，被限制 
}

struct ContractBasicInfo {
    1:optional string platform; // 行情数据的平台
    2:optional string contractSymbols; // 行情数据的合约符号标识
}

struct QueryTickOption {
    1:required ContractBasicInfo contractBasic;
    2:optional i64    startTimestampS; // 查询周期的起始时间戳，以秒为单位
    3:optional i64    endTimestampS;   // 查询周期的终止时间戳，以秒为单位
}

struct QueryKLineMinuteOption {
    1:required ContractBasicInfo contractBasic;
    2:optional i64 startMinuteTimestampS; // 查询分钟K线的起始时间戳
    3:optional i64 endMinuteTimestampS;  // 查询分钟的终止时间戳
}

/**
  * 行情查询DAO
  */
service(890) QuotationQueryDao {
    /**
     * 获取原始TICK行情
     */
    list<quotation_item.QuotationItem> 1:getTicks(
            1:comm.PlatformArgs platformArgs, 2:QueryTickOption option) throws (1:comm.ErrorInfo err);
    
    /**
      * 获取单分钟行情
      */
    list<quotation_item.KLineQuotationMinuteItem> 2:getKLineMinutes(
            1:comm.PlatformArgs platformArgs, 2:QueryKLineMinuteOption option) throws(1:comm.ErrorInfo err);
}

