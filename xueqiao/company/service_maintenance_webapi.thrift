/**
  * 公司云服务维护管理
  */
namespace java xueqiao.company.service.maintenance.webapi.thriftapi
namespace py xueqiao.company.service.maintenance.webapi.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "service_maintenance.thrift"

//交易类型
enum TradeType {
    NONE = 0,   //未设定
    REAL = 1,   //实盘
    SIM = 2,    //模拟
}

//托管服务状态
enum HostingServiceState{
    WAITING = 0,        // 等待开通状态
    OPENING = 1,        // 开通中状态
    UPGRADING = 2,      // 升级中
    WORKING = 3,        // 已通状态
    EXPIRED = 4,        // 已过期
    RELEASED = 5,       // 已释放
    UNKNOWN = 6,		// 未知，查询不到状态
}

/**
  * 公司服务维护信息
  */
struct CompanyServiceMaintenance{
	1:optional i64 companyId;					// 公司id
	2:optional string companyName;
	3:optional string versionTag;				// 当前版本
	4:optional set<service_maintenance.MaintenanceTimeSpan> maintenanceTimeSpans;	// 维护时间段s
	5:optional service_maintenance.MaintenanceState maintenanceState;		// 维护状态
	6:optional bool versionDifferent;
	7:optional string companyCode;
	8:optional bool keepLatest;
}

/**
  * 公司服务详情
  */
struct CompanyGroupServiceDetail{
	1:optional i64 groupId;
	2:optional string groupName;
	3:optional TradeType tradeType; 	// 交易环境
	4:optional string versionTag;		// 版本
	5:optional HostingServiceState hostingServiceState;
}

/**
  * 维护计划详情
  */
struct MaintenanceScheduleDetail{
	1:optional i64 companyId;
	2:optional string companyName;
	3:optional service_maintenance.OperateType operateType;	// 操作类型
	4:optional string oldVersionTag;			// 原版本tag
	5:optional string targetVersionTag;			// 目标版本tag
	6:optional set<service_maintenance.MaintenanceTimeSpan> maintenanceTimeSpans;	// 维护时间段s
	7:optional i64 createScheduleTime;	 		// 计划提交时间
	8:optional i64 scheduleMaintenanceTime; 	// 计划执行时间
	9:optional string creater;					// 创建者
	10:optional string companyCode;
}

/**
  * 公司维护信息过滤条件
  */
struct CompanyServiceMaintenanceFilter{
	1:optional i64 companyId;					// 公司
	2:optional string companyNamePartical;		// 公司名称
	3:optional string versionTag; 				// 版本tag
	4:optional service_maintenance.MaintenanceTimeSpan maintenanceTimeSpan;		// 维护时间段
	5:optional service_maintenance.MaintenanceState maintenanceState; 	// 维护状态
}

struct NewUpgradeSchedule{
	1:optional set<i64> companyIds;
	2:optional i64 targetVersionId;
	4:optional string operator;
}

struct NewRollbackSchedule{
	1:optional i64 companyId;
	2:optional i64 targetVersionId;
	4:optional string operator;
}

struct CompanyServiceMaintenancePage{
	1:optional i32 total;
	2:optional list<CompanyServiceMaintenance> page;
}

struct ReqMaintenanceScheduleDetailFilter{
	1:optional i64 companyId;
	2:optional string companyNamePartical;		// 公司名称
	3:optional string versionTag; 				// 版本tag
}

struct VersionInfo{
	1:optional i64 versionId;
	2:optional string versionTag;
	3:optional i64 versionTimestamp;
}

service(752) CompanyServiceMaintenanceWebapi{

	/**
  	* 公司服务维护信息
 	*/
	CompanyServiceMaintenancePage 1:reqCompanyServiceMaintenance(1:comm.PlatformArgs platformArgs, 2:CompanyServiceMaintenanceFilter filter, 3:page.IndexedPageOption pageOption) throws(1:comm.ErrorInfo err);

	void 2:addUpgradeSchedule(1:comm.PlatformArgs platformArgs, 2:NewUpgradeSchedule upgradeSchedule) throws(1:comm.ErrorInfo err);

	void 3:addRollbackSchedule(1:comm.PlatformArgs platformArgs, 2:NewRollbackSchedule rollbackSchedule) throws(1:comm.ErrorInfo err);

	/**
  	* 计划明细信息
 	*/
	list<MaintenanceScheduleDetail> 4:reqMaintenanceScheduleDetail(1:comm.PlatformArgs platformArgs, 2:ReqMaintenanceScheduleDetailFilter filter) throws(1:comm.ErrorInfo err);

	void 5:cancelMaintenanceSchedule(1:comm.PlatformArgs platformArgs, 2:set<i64> companyIds) throws(1:comm.ErrorInfo err);
	
	/**
  	* 公司维护历史明细信息
 	*/
	list<service_maintenance.MaintenanceHistory> 6:reqMaintenanceHistory(1:comm.PlatformArgs platformArgs, 2:i64 companyId) throws(1:comm.ErrorInfo err);

	list<VersionInfo> 7:reqCompanyExistVersionTags(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);

	list<CompanyGroupServiceDetail> 8:reqCompanyServiceDetail(1:comm.PlatformArgs platformArgs, 2:i64 companyId) throws(1:comm.ErrorInfo err);

	list<VersionInfo> 9:reqCompanyUpgradeVersion(1:comm.PlatformArgs platformArgs, 2:set<i64> companyIds) throws(1:comm.ErrorInfo err);

	list<VersionInfo> 10:reqCompanyRollbackVersion(1:comm.PlatformArgs platformArgs, 2:i64 companyId) throws(1:comm.ErrorInfo err);

	void 11:initCompanyVersion(1:comm.PlatformArgs platformArgs, 2:i64 companyId, 3:i64 versionId) throws(1:comm.ErrorInfo err);

	list<VersionInfo> 12:reqServerVersions(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);

	void 13:updateKeepLatestTag(1:comm.PlatformArgs platformArgs,  2:i64 companyId, 3:bool keepLatest) throws(1:comm.ErrorInfo err);
}
