/**
  * 公司管理实体DAO
  */
namespace * xueqiao.company.dao

include "../../comm.thrift"
include "../../page.thrift"
include "company.thrift"
include "../sync_hosting_task/hosting_sync_task_queue.thrift"

/**
  * 公司相关管理的DAO
  */
service(750) CompanyDao {
    i32 1:addCompany(1:comm.PlatformArgs platformArgs, 2:company.CompanyEntry newCompany) 
        throws(1:comm.ErrorInfo err);
    
    void 2:updateCompany(1:comm.PlatformArgs platformArgs, 2:company.CompanyEntry updateCompany)
        throws(1:comm.ErrorInfo err);
    
    company.CompanyPageResult 3:queryCompanyPage(1:comm.PlatformArgs platformArgs
        , 2:company.QueryCompanyOption queryOption
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
        
    i32 4:addCompanyGroup(1:comm.PlatformArgs platformArgs
    	, 2:company.CompanyGroup newGroup) throws (1:comm.ErrorInfo err);
    
    void 5:updateCompanyGroup(1:comm.PlatformArgs platformArgs
    	, 2:company.CompanyGroup updateGroup) throws (1:comm.ErrorInfo err);
    
    void 6:deleteCompanyGroup(1:comm.PlatformArgs platformArgs
    	, 2:i32 companyId
    	, 3:i32 groupId) throws (1:comm.ErrorInfo err);
    
    company.CompanyGroupPageResult 7:queryCompanyGroupPage(
    	1:comm.PlatformArgs platformArgs
    	, 2:company.QueryCompanyGroupOption queryOption
    	, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    i32 8:addCompanyGroupAndSpec(1:comm.PlatformArgs platformArgs
        , 2:company.CompanyGroup newGroup, 3:company.CompanyGroupSpec newGroupSpec) throws (1:comm.ErrorInfo err);

    void 9:updateCompanyGroupSpec(1:comm.PlatformArgs platformArgs
        , 2:company.CompanyGroupSpec updateGroupSpec) throws (1:comm.ErrorInfo err);


    // 操作 CompanyUser
    i32 11:addCompanyUser(1:comm.PlatformArgs platformArgs, 2:company.CompanyUser companyUser) 
        throws(1:comm.ErrorInfo err);
    
    void 12:updateCompanyUser(1:comm.PlatformArgs platformArgs, 2:company.CompanyUser companyUser)
        throws(1:comm.ErrorInfo err);
    
    company.CompanySpecPage 13:queryCompanySpec(1:comm.PlatformArgs platformArgs
        , 2:company.QueryCompanySpecOption option
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    //分配用户到Company group
    void 14:addUser2Group(1:comm.PlatformArgs platformArgs, 2:company.GroupUser groupUser) 
        throws(1:comm.ErrorInfo err);

    void 15:removeGroupUser(1:comm.PlatformArgs platformArgs, 2:company.GroupUser groupUser) 
        throws(1:comm.ErrorInfo err);

    company.CompanyGroupSpecPage 16:queryCompanyGroupSpec(1:comm.PlatformArgs platformArgs
        , 2:company.QueryCompanyGroupSpecOption option
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    company.CompanyUserPage 17:queryCompanyUser(1:comm.PlatformArgs platformArgs
        , 2:company.QueryCompanyUserOption option
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    company.GroupUserPage 18:queryGroupUser(1:comm.PlatformArgs platformArgs
        , 2:company.QueryGroupUserOption option
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    void 19:updateGroupUser(1:comm.PlatformArgs platformArgs, 2:company.GroupUser groupUser) 
        throws(1:comm.ErrorInfo err);

    company.CompanyGroupSpecPage 20:queryExpiredCompanyGroupSpec(1:comm.PlatformArgs platformArgs
        , 2:company.QueryExpiredGroupSpecOption option
        , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

    // 添加 CompanyUser （带有 groupUser 信息）
    i32 21:addCompanyUserEx(1:comm.PlatformArgs platformArgs, 2:company.CompanyUserEx companyUserEx) 
        throws(1:comm.ErrorInfo err);

    // 修改密码
    void 22: updateCompanyUserPassword(1:comm.PlatformArgs platformArgs, 2:company.UpdateCompanyUserPasswordReq updateCompanyUserPasswordReq) throws(1:comm.ErrorInfo err);

    void 30: submitInitHosingTask(1:comm.PlatformArgs platformArgs, 2:company.InitHostingMachineReq initHostingMachineReq) 
        throws(1:comm.ErrorInfo err);

    void 31: doAfterInitHosting(1:comm.PlatformArgs platformArgs, 2:hosting_sync_task_queue.SyncInitHostingTask initHostingTask) 
        throws(1:comm.ErrorInfo err);

    void 32: doUpgradeGroupSpec(1:comm.PlatformArgs platformArgs, 2:i32 orderId, 3:string oaUserName) throws(1:comm.ErrorInfo err);

    /**
    * 查询group user 的扩展信息
    */
    company.GroupUserExPage 33:queryGroupUserEx(1:comm.PlatformArgs platformArgs, 2:company.QueryGroupUserExOption option, 3:page.IndexedPageOption pageOption) throws(1:comm.ErrorInfo err);

    /**
    * 获取个人用户集体挂靠公司
    */
    company.CompanyEntry 34:getCollectiveCompany(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
}
