/**
  * 公司云服务维护管理
  */
namespace java xueqiao.company.service.maintenance
namespace py xueqiao.company.service.maintenance

/**
  * 操作类型
  */
enum OperateType{
	UPGRADE = 0,
	ROLLBACK = 1
}

/**
  * 维护状态
  */
enum MaintenanceState{
	EMPTY = 0, 			// 空闲中
	SCHEDULED = 1;		// 计划中
}

/**
  * 维护时间段
  */
enum MaintenanceTimeSpan{
	WEEKEND = 0,		// 周末 周六 6:00 - 周日 20:00
	WORKING_DAY = 1,	// 周一至周五 早上6：00 - 7：00
}

/**
  * 公司服务维护信息
  */
struct ServiceMaintenance{
	1:optional i64 companyId;			// 公司id
	2:optional set<MaintenanceTimeSpan> maintenanceTimeSpans;	// 维护时间段s
	3:optional MaintenanceState maintenanceState; // 维护状态
	4:optional i64 versionId;
	5:optional string versionTag;
	6:optional i64 createTimestamp;
	7:optional i64 lastModifyTimestamp;
	8:optional bool keepLatest;
}

/**
  * 维护历史
  */
struct MaintenanceHistory{
	1:optional i64 historyId;
	2:optional i64 companyId;
	3:optional i64 createScheduleTimestamp; // 计划提交时间
	4:optional string oldVersionTag;		// 旧版本tag
	5:optional i64 oldVersionId;			// 旧版本id
	6:optional string targetVersionTag;		// 目标版本tag
	7:optional i64 targetVersionId;			// 目标版本id
	8:optional OperateType operateType;		// 操作类型
	9:optional i64 scheduledTimestamp;		// 计划执行时间点
	10:optional set<MaintenanceTimeSpan> maintenanceTimeSpans;	// 维护时间段s
	11:optional string creater;				// 创建人
	12:optional i64 createTimestamp;
	13:optional i64 lastModifyTimestamp;
}

/**
  * 维护计划详情
  */
struct ScheduleOperateDetail{
	1:optional i64 companyId;				// 公司id
	2:optional string oldVersionTag;		// 旧版本tag
	3:optional i64 oldVersionId;			// 旧版本id
	4:optional string targetVersionTag;		// 目标版本tag
	5:optional i64 targetVersionId;			// 目标版本id
	6:optional OperateType operateType;		// 操作类型
	7:optional i64 scheduledTimestamp;		// 计划执行时间点
	8:optional set<MaintenanceTimeSpan> maintenanceTimeSpans;	// 维护时间段s
	9:optional string creater;				// 创建人
	10:optional i64 createTimestamp;
	11:optional i64 lastModifyTimestamp;
}