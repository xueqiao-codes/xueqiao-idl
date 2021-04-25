namespace * xueqiao.hosting.machine

/**
  * 机器规格
  */
struct HostingMachineSpec {
	1:optional i32 memoryGB;   // 内存多少GB
	2:optional i32 cpuCount;   // 核多少个
	3:optional i32 outIfBandMB;  // 出口网络宽带
}

enum HostingMachineRunningStatus {	//运行状态
	RUNNING = 0,
	STARTING = 1,
	STOPPING = 2,
	STOPPED = 3,
	UNKNOWN = 4,
	DELETED = 5
}

enum HostingMachineAssignStatus {	//分配状态
	RAW = 0,						//新机器，尚未标准化(只有新开的机器应有此状态)
	NOT_ASSIGNED = 1,				//已标准化，未分配(新机标准化后，或旧机回收reset后)
	ASSIGNED_UNINITED = 2,			//已分配关联，尚未初始化
	ASSIGNED = 3,					//已分配关联，并完成初始化，可以使用
}

/**
  * 托管机机器实体的描述
  */
struct HostingMachine {
	1:optional i64 machineId;   // 机器ID
	2:optional string machineInnerIP; // 机器内网IP	
	3:optional string machineOuterIP; // 机器外网IP
	4:optional string machineHostname; // 机器
	5:optional HostingMachineSpec machineSpec;  // 机器规格
	6:optional HostingMachineRunningStatus machineRunningStatus;
	7:optional HostingMachineAssignStatus machineAssignStatus;

	
	13:optional i32 createTimestamp;             // 记录创建时间
	14:optional i32 lastmodifyTimestamp;         // 记录最近修改时间

	21:optional string instanceId;			// 阿里云ECS实例id
	22:optional string regionId;			// 地域id
}

struct QueryHostingMachineOption {
	1:optional i64 machineId;
	2:optional string machineInnerIPPartical;
	3:optional string machineInnerIPWhole;
	4:optional string machineOuterIPPartical;
	5:optional string machineOuterIPWhole;
	6:optional string machineHostnamePartical;
	7:optional string machineHostnameWhole;
	8:optional HostingMachineAssignStatus machineAssignStatus;
}

struct HostingMachinePageResult {
	1:optional i32 totalNum;
	2:optional list<HostingMachine> resultList;
}


/**
  * 托管机机器实体关联信息
  */
struct HostingRelatedInfo {
	1:optional i64 relatedId;           // 关联信息ID
	2:optional i32 companyId;
	3:optional i32 companyGroupId;
	4:optional i64 machineId;
	
	5:optional i32 activeStartTimestamp;     // 关联有效开始时间
	6:optional i32 activedEndTimestamp;      // 关联有效结束时间
	
	7:optional string machineInnerIP;         // 从机器表中拷贝过来，加快访问速度
	8:optional string machineOuterIP;      
	
	10:optional i32 createTimestamp;
	11:optional i32 lastmodifyTimestamp;
}

struct QueryHostingRelatedInfoOption {
	1:optional i64 relatedId;
	2:optional i32 companyId;
	3:optional i32 companyGroupId;
	4:optional i64 machineId;
}

struct HostingRelatedInfoPageResult {
	1:optional i32 totalNum;
	2:optional list<HostingRelatedInfo> resultList;
}

enum HostingMachineErrorCode {
	HOSTING_NAME_ALREADY_EXISTED = 1001,   // 机器域名已经存在一台相同机器
	HOSTING_INNERIP_ALREADY_EXISTED = 1002, // 机器内网IP已经存在一台相同机器
	HOSTING_OUTERIP_ALREADY_EXISTED = 1003, // 机器外网IP已经存在一台相同机器
	HOSTING_MACHINE_NOT_EXISTED = 1004,     // 机器不存在
	HOSTING_MACHINE_HAS_RELARED_INFO = 1005, // 机器有关联信息，无法删除
	HOSTING_RELATED_INFO_NOT_EXISTED = 1006, // 机器关联信息不存在
	HOSTING_RELATED_INFO_EXISTED = 1007,     // 重复的关联信息
}