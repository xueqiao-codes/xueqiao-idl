/**
  * 公司云服务维护管理
  */
namespace java xueqiao.company.service.maintenance.dao.thriftapi
namespace py xueqiao.company.service.maintenance.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "service_maintenance.thrift"

struct ServiceMaintenancePage{
	1:optional i32 total;
	2:optional list<service_maintenance.ServiceMaintenance> page;
}

struct ReqServiceMaintenanceOption{
	1:optional set<i64> companyIds;
	2:optional service_maintenance.MaintenanceTimeSpan maintenanceTimeSpan;
	3:optional string versionTag;
	4:optional service_maintenance.MaintenanceState maintenanceState;
}

struct ReqScheduleOperateDetailOption{
	1:optional set<i64> companyIds;
	3:optional string targetVersionTag;
}

service(751) CompanyServiceMaintenanceDao{
	void 1:addServiceMaintenance(1:comm.PlatformArgs platformArgs, 2:service_maintenance.ServiceMaintenance serviceMaintenance) throws(1:comm.ErrorInfo err);

	void 2:updateServiceMaintenance(1:comm.PlatformArgs platformArgs, 2:service_maintenance.ServiceMaintenance serviceMaintenance) throws(1:comm.ErrorInfo err);

	ServiceMaintenancePage 3:reqServiceMaintenance(1:comm.PlatformArgs platformArgs, 2:ReqServiceMaintenanceOption option, 3:page.IndexedPageOption pageOption) throws(1:comm.ErrorInfo err);

	list<service_maintenance.MaintenanceHistory> 4:reqMaintenanceHistory(1:comm.PlatformArgs platformArgs, 2:set<i64> companyIds) throws(1:comm.ErrorInfo err);

	void 5:addScheduleOperateDetail(1:comm.PlatformArgs platformArgs, 2:list<service_maintenance.ScheduleOperateDetail> details) throws(1:comm.ErrorInfo err);

	void 6:updateScheduleOperateDetail(1:comm.PlatformArgs platformArgs, 2:service_maintenance.ScheduleOperateDetail scheduleOperateDetail) throws(1:comm.ErrorInfo err);

	list<service_maintenance.ScheduleOperateDetail> 7:reqScheduleOperateDetail(1:comm.PlatformArgs platformArgs, 2:ReqScheduleOperateDetailOption option) throws(1:comm.ErrorInfo err);

	void 8:removeScheduleOperateDetail(1:comm.PlatformArgs platformArgs, 2:i64 companyId) throws(1:comm.ErrorInfo err);
}
