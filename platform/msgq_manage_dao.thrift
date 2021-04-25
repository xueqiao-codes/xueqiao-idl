/**
  * dao for msgq configuration manage
  */
namespace java org.soldier.platform.msgq.dao

include "../comm.thrift"

enum ConsumerMode {
    BROADCAST = 1,
    UNICAST = 2
}

struct MsgQCluster {
    1:optional string clusterName;
    2:optional string clusterType;
    3:optional string clusterBrokers;
    4:optional map<string, string> clusterProperties;
    5:optional string clusterDesc;
    
    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct MsgQTopic {
    1:optional string topicName;
    2:optional string topicCluster;
    3:optional string topicDesc;
    4:optional map<string, string> topicProperties;
    
    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct MsgQConsumer {
    1:optional string consumerKey;
    2:optional string topicName;
    3:optional ConsumerMode mode;
    4:optional map<string, string> consumerProperties;
    5:optional string consumerDesc;
    6:optional i16 hasSync;
    
    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct MsgQProducer {
    1:optional string producerKey;
    2:optional string topicName;
    3:optional map<string, string> producerProperties;
    4:optional string producerDesc;
    5:optional i16 hasSync;
    
    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct QueryMsgQClusterOption {
    1:optional string clusterName;
    2:optional string clusterType;
    3:optional string clusterBroker;
    4:optional string clusterPropertyExpression;
    5:optional string clusterDesc;
}

struct MsgQClusterList {
    1:required i32 totalNum;
    2:required list<MsgQCluster> clusterList;
}

struct QueryMsgQTopicOption {
    1:optional string topicName;
    2:optional string topicCluster;
    3:optional string topicDesc;
    4:optional string topicPropertyExpression;
}

struct MsgQTopicList {
    1:required i32 totalNum;
    2:required list<MsgQTopic> topicList;
}

struct QueryMsgQConsumerOption {
    1:optional string consumerKey;
    2:optional string topicName;
    3:optional ConsumerMode mode;
    4:optional string consumerPropertyExpression;
    5:optional string consumerDesc;
    6:optional i16 hasSync;
}

struct MsgQComsumerList {
    1:required i32 totalNum;
    2:required list<MsgQConsumer> consumerList;
}

struct QueryMsgQProducerOption {
    1:optional string producerKey;
    2:optional string topicName;
    3:optional string producerPropertyExpression;
    4:optional string producerDesc;
    5:optional i16 hasSync;
}

struct MsgQProducerList {
    1:required i32 totalNum;
    2:required list<MsgQProducer> producerList;
}

service(25) MsgQManageDao {
    MsgQClusterList 1:queryMsgQClusters(1:comm.PlatformArgs platformArgs
            , 2:i32 pageIndex, 3:i32 pageSize, 4:QueryMsgQClusterOption option) throws(1:comm.ErrorInfo err);
    void 2:addMsgQCluster(1:comm.PlatformArgs platformArgs, 2:MsgQCluster cluster) throws(1:comm.ErrorInfo err);
    void 3:updateMsgQCluster(1:comm.PlatformArgs platformArgs, 2:MsgQCluster cluster) throws(1:comm.ErrorInfo err);
    void 4:deleteMsgQCluster(1:comm.PlatformArgs platformArgs, 2:string clusterName) throws(1:comm.ErrorInfo err);
    
    MsgQTopicList 5:queryMsgQTopics(1:comm.PlatformArgs platformArgs
            , 2:i32 pageIndex, 3:i32 pageSize, 4:QueryMsgQTopicOption option) throws(1:comm.ErrorInfo err);
    void 6:addMsgQTopic(1:comm.PlatformArgs platformArgs, 2:MsgQTopic topic) throws(1:comm.ErrorInfo err);
    void 7:updateMsgQTopic(1:comm.PlatformArgs platformArgs, 2:MsgQTopic topic) throws(1:comm.ErrorInfo err);
    void 8:deleteMsgQTopic(1:comm.PlatformArgs platformArgs, 2:string topicName) throws(1:comm.ErrorInfo err);
    
    MsgQComsumerList 9:queryMsgQConsumers(1:comm.PlatformArgs platformArgs
            , 2:i32 pageIndex, 3:i32 pageSize, 4:QueryMsgQConsumerOption option) throws(1:comm.ErrorInfo err);
    void 10:addMsgQConsumer(1:comm.PlatformArgs platformArgs, 2:MsgQConsumer consumer) throws(1:comm.ErrorInfo err);
    void 11:updateMsgQConsumer(1:comm.PlatformArgs platformArgs, 2:MsgQConsumer consumer) throws(1:comm.ErrorInfo err);
    void 12:deleteMsgQConsumer(1:comm.PlatformArgs platformArgs, 2:string consumerKey) throws(1:comm.ErrorInfo err);
    
    MsgQProducerList 13:queryMsgQProducerList(1:comm.PlatformArgs platformArgs
            , 2:i32 pageIndex, 3:i32 pageSize, 4:QueryMsgQProducerOption option) throws(1:comm.ErrorInfo err);
    void 14:addMsgQProducer(1:comm.PlatformArgs platformArgs, 2:MsgQProducer producer) throws(1:comm.ErrorInfo err);
    void 15:updateMsgQProducer(1:comm.PlatformArgs platformArgs, 2:MsgQProducer producer) throws(1:comm.ErrorInfo err);
    void 16:deleteMsgQProducer(1:comm.PlatformArgs platformArgs, 2:string producerKey) throws(1:comm.ErrorInfo err);
}
