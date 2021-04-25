namespace java xueqiao.hosting.taskqueue

enum TaskType{
    INIT_HOSTING = 1,
    OPERATE_COMPANY_USER = 2,
}

enum TaskStatus{
    NORMAL,
    ERROR,
}

enum UserRole{
    TRADER = 0,          // 交易员
    ADMIN = 1,          // 管理员
    OBSERVER = 2,       // 观察员
}

/**
  * 用户同步操作
  */
enum SyncOperation{
    REGISTER_USER,
    UPDATE_USER,
    ENABLE_USER,
    DISABLE_USER,
}

struct SyncInitHostingTask {
    1:optional i32 taskId;
    2:required TaskType taskType;
    3:optional string machineInnerIP;
    4:optional i32 companyId;
    5:optional i32 groupId;
    6:optional i32 orderId;
    7:optional string oaUserName;
    8:optional i64 machineId;
    9:optional string adminName;
    10:optional string adminPasswd;
    11:optional string hostingAES16Key;    // 用于授权验证
    12:optional string runningMode;
}

struct SyncOperateCompanyUserTask {
    1:optional i32 taskId;
    2:required TaskType taskType;
    3:optional i32 companyId;
    4:optional i32 groupId;
    6:optional string syncOperation;
    10:optional string loginName;
    11:optional string loginPasswd;
    12:optional string phone;
    13:optional string nickName;
    14:optional UserRole userRoleValue;
    15:optional string email;
    
}

struct TSyncTaskQueue {
    1:optional i32 taskId;
    2:optional i32 taskType;
    3:optional string queueMessage;
    4:optional i32 retryTimes;
    5:optional TaskStatus taskStatus;
    10:optional i32 createTimestamp;
    11:optional i32 lastModifyTimestamp;
}

struct QuerySyncTaskQueueOption {
    1:optional i32 taskId;
    2:optional i32 taskType;
}

struct SyncTaskQueuePage {
    1:required i32 totalRecord;
    2:required list<TSyncTaskQueue> recordPage;
}
