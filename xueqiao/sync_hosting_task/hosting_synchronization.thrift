namespace java xueqiao.hosting.machine

/**
  * 同步状态
  */
enum SyncStatus{
	NEW = 0,
	DONE = 1,
	ERROR = 2,
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

struct HostingInitialization{
	1:optional i32 companyId;
	2:optional i32 companyGroupId;
	3:optional string machineInnerIp;
	4:optional string aes16Key;
	20:optional SyncStatus status;
	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct SyncHostingUser{
	1:optional i32 companyId;
	2:optional i32 companyGroupId;
	3:optional i32 userId;
	4:optional string machineInnerIp;
	5:optional SyncOperation operation;
	6:optional string parameters;
	20:optional SyncStatus status;
	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct HostingInitializationPage{
	1:optional i32 totalNum;
	2:optional list<HostingInitialization> hostingInitializationList;
}

struct SyncHostingUserPage{
	1:optional i32 totalNum;
	2:optional list<SyncHostingUser> syncHostingUserList;
}

struct QueryHostingInitializationOption {
	1:optional i32 companyId;
	2:optional i32 companyGroupId;
	3:optional string machineInnerIp;
	4:optional SyncStatus status;
}

struct QuerySyncHostingUserOption {
	1:optional i32 companyId;
	2:optional i32 companyGroupId;
	3:optional i32 userId;
	4:optional SyncStatus status;
}
