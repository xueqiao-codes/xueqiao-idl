/**
  * 托管机任务笔记
  *   记录用户需要处理的相关内容，用户可标记删除
  */
namespace * xueqiao.trade.hosting.tasknote.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

enum HostingTaskNoteType {
    XQ_TRADE_LAME = 1,  //瘸腿成交
}

/**
  * 对应的一个Key结构
  */
struct HostingTaskNoteKey {
    1:optional i64 key1;
    2:optional i64 key2;
    3:optional string key3;
}

struct HostingTaskNote {
    1:optional HostingTaskNoteType noteType;
    2:optional HostingTaskNoteKey noteKey;
    3:optional string noteContent;
    4:optional i64 createTimestampMs;
    5:optional i64 lastmodifyTimestampMs;
}

struct QueryTaskNoteOption {
    1:required HostingTaskNoteType noteType;
    
    // key的并列查询
    2:optional set<i64> key1;
    3:optional set<i64> key2;
    4:optional set<string> key3;
}

struct HostingTaskNotePage {
    1:optional i32 totalNum;
    2:optional list<HostingTaskNote> resultList;
}

service(721) TradeHostingTaskNote {
    /**
      * 查询Notes
      */
    HostingTaskNotePage 1:getTaskNotePage(1:comm.PlatformArgs platformArgs
                , 2:QueryTaskNoteOption qryOption
                , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
                
    /**
      * 按照Key删除Note
      */
    void 2:delTaskNote(1:comm.PlatformArgs platformArgs
                , 2:HostingTaskNoteType noteType
                , 3:HostingTaskNoteKey noteKey) throws (1:comm.ErrorInfo err);
    
}

/**
  * 以下为记录各种任务类型的实际结构分布
  *  瘸腿成交: 
  *     key1: 子账户ID(操作账户ID)
  *     key2: 雪橇成交ID
  *     content: HostingXQTrade的thrift的json的序列化形式
  */
