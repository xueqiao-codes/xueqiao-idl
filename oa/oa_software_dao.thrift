 /**
 * oa software dao
 */
 namespace java org.soldier.platform.oa.software.dao
 
 include "../comm.thrift"
 include "oa_software.thrift" 
 
 service(999) OaSoftwareDao {
	
	/**
	  * 分页查询获取软件列表信息
	  */
	oa_software.SoftwarePage 1:querySoftwareByPage(1:comm.PlatformArgs platformArgs, 2:oa_software.QuerySoftwareOption option, 3:i32 index, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
								
	/**
	 * 添加新的软件信息
	 * Remark: 1.相同的 project, platform, bundleId, version 的软件信息不能被创建或修改成为
	 * 2.相同的project, platform, bundleId 软件信息不能都设置为 inUse
	 */
	i32 2:createSoftware(1:comm.PlatformArgs platformArgs, 2:oa_software.Tsoftware software) throws (1:comm.ErrorInfo err);
						
	/**
	 * 修改软件信息
	 * Remark: 1.相同的 project, platform, bundleId, version 的软件信息不能被创建或修改成为
	 * 2.相同的project, platform, bundleId 软件信息不能都设置为 inUse
	 */
	void 3:updateSoftware(1:comm.PlatformArgs platformArgs, 2:oa_software.Tsoftware software) throws (1:comm.ErrorInfo err);
	
	/**
	 * 删除软件信息
	 */
	void 4:deleteSoftware(1:comm.PlatformArgs platformArgs, 2:i32 softwareId) throws (1:comm.ErrorInfo err);

	/**
	 * 查询所有项目
	 */
	list<oa_software.TsoftwareProject> 5:queryAllSoftwareProject(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	/**
	 * 根据project_id查询project
	 */
	oa_software.TsoftwareProject 6:findSoftwareProjectById(1:comm.PlatformArgs platformArgs, 2:i32 projectId) throws (1:comm.ErrorInfo err);
    
    /**
	 * 添加新的软件所属项目
	 */
	i32 7:createSoftwareProject(1:comm.PlatformArgs platformArgs, 2:oa_software.TsoftwareProject project) throws (1:comm.ErrorInfo err);
	
	/**
	 * 修改软件所属项目信息
	 */
	void 8:updateSoftwareProject(1:comm.PlatformArgs platformArgs, 2:oa_software.TsoftwareProject project) throws (1:comm.ErrorInfo err);

	/**
	 * 删除软件所属项目信息
	 */ 
	void 9:deleteSoftwareProject(1:comm.PlatformArgs platformArgs, 2:i32 projectId) throws (1:comm.ErrorInfo err);

	/**
	 * 查询所有软件所属平台
	 */
	list<oa_software.TsoftwarePlatform> 10:queryAllSoftwarePlatform(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	/**
	 * 根据platformId查询软件所属平台
	 */
	oa_software.TsoftwarePlatform 11:findSoftwarePlatformById(1:comm.PlatformArgs platformArgs, 2:string platformId) throws (1:comm.ErrorInfo err);
	
	/**
	 * 添加新的软件所属平台
	 */
	void 12:createSoftwarePlatform(1:comm.PlatformArgs platformArgs, 2:oa_software.TsoftwarePlatform softwarePlatform) throws (1:comm.ErrorInfo err);

	/**
	 * 修改软件所属平台信息
	 */
	void 13:updateSoftwarePlatform(1:comm.PlatformArgs platformArgs, 2:string originalPlatformId, 3:oa_software.TsoftwarePlatform softwarePlatform) throws (1:comm.ErrorInfo err);

	/**
	 * 删除软件所属平台信息
	 */ 
	void 14:deleteSoftwarePlatform(1:comm.PlatformArgs platformArgs, 2:string platformId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询单个软件信息
	  */
	oa_software.Tsoftware 15:findSoftwareById(1:comm.PlatformArgs platformArgs, 2:i32 softwareId) throws (1:comm.ErrorInfo err);

 }
