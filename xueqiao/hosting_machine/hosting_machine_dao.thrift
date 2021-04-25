/**
  * 托管机实体机管理dao
  */
namespace * xueqiao.hosting.machine.dao

include "../../comm.thrift"
include "../../page.thrift"
include "hosting_machine.thrift"

service(760) HostingMachineDao {
	i64 1:addHostingMachine(1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.HostingMachine newMachine) throws (1:comm.ErrorInfo err);
			
	void 2:updateHostingMachine(1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.HostingMachine updateMachine) throws (1:comm.ErrorInfo err);
			
	void 3:deleteHostingMachine(1:comm.PlatformArgs platformArgs
			, 2:i64 machineId) throws (1:comm.ErrorInfo err);
			
	hosting_machine.HostingMachinePageResult 4:queryHostingMachinePage(
			1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.QueryHostingMachineOption queryOption
			, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
			
	i64 5:addRelatedInfo(1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.HostingRelatedInfo newRelatedInfo) throws (1:comm.ErrorInfo err);
	
	void 6:updateRelatedInfo(1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.HostingRelatedInfo updateRelatedInfo) throws (1:comm.ErrorInfo err);
	
	void 7:deleteRelatedInfo(1:comm.PlatformArgs platformArgs
			, 2:i64 relatedId) throws (1:comm.ErrorInfo err);
			
	hosting_machine.HostingRelatedInfoPageResult 8:queryRelatedInfoPage(
			1:comm.PlatformArgs platformArgs
			, 2:hosting_machine.QueryHostingRelatedInfoOption queryOption
			, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}