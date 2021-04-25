namespace java org.soldier.platform.app.manager.dao.thriftapi
namespace py org.soldier.platform.app.manager.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "app_manager.thrift"

struct ReqProjectOption{
	1:optional set<i64> projectIds;
	2:optional string projectName;
}

struct ReqAppOption{
	1:optional set<i64> appIds;
	2:optional string appKey;
	3:optional app_manager.AppType appType;
	4:optional i64 projectId;
	5:optional app_manager.OSPlatform osPlatform;
	6:optional string appNamePartical;
}

/**
  * 版本查询条件
  * start, end version num 可以根据版本号区间查询，结果包含区间边界
  */
struct ReqAppVersionOption{
	1:optional set<i64> versionIds;
	2:optional i64 appId;
	3:optional string appKey;
	4:optional string versionKey;

	5:optional app_manager.VersionNum startVersionNum;
	6:optional app_manager.VersionNum endVersionNum;
	7:optional app_manager.VersionState versionState;
}

struct ReqServerAppSupportOption{
	1:optional set<i64> serverVersionIds;
	2:optional i64 supportClientAppId;
	3:optional app_manager.VersionNum versionNum;
}

service(90) AppManagerDao{

	/**
	  * 查询项目信息
	  * 项目数量基本上是数量比较少，直接采用list返回而不分页
	  */	
	list<app_manager.Project> 1:reqProject(1:comm.PlatformArgs platformArgs, 2:ReqProjectOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 添加项目
	  * 返回项目id
	  */
	i64 2:addProject(1:comm.PlatformArgs platformArgs, 2:app_manager.Project project) throws (1:comm.ErrorInfo err);

	/**
	  * 更新项目信息
	  */
	void 3:updateProject(1:comm.PlatformArgs platformArgs, 2:app_manager.Project project) throws (1:comm.ErrorInfo err);

	void 4:removeProject(1:comm.PlatformArgs platformArgs, 2:i64 projectId) throws (1:comm.ErrorInfo err);


	/**
	  * 查询应用信息
	  * 应用数量基本上是数量比较少，直接采用list返回而不分页
	  */		
	list<app_manager.App> 5:reqApp(1:comm.PlatformArgs platformArgs, 2:ReqAppOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 添加应用信息
	  * 返回应用id
	  */
	i64 6:addApp(1:comm.PlatformArgs platformArgs, 2:app_manager.App app) throws (1:comm.ErrorInfo err);

	/**
	  * 根据appId更新应用信息
	  */
	void 7:updateApp(1:comm.PlatformArgs platformArgs, 2:app_manager.App app) throws (1:comm.ErrorInfo err);

	void 8:removeApp(1:comm.PlatformArgs platformArgs, 2:i64 appId) throws (1:comm.ErrorInfo err);

	/**
	  * 分页查询应用的版本信息
	  */		
	app_manager.AppVersionPage 9:reqAppVersion(1:comm.PlatformArgs platformArgs, 2:ReqAppVersionOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 添加应用版本信息
	  * 返回应用版本id
	  */
	i64 10:addAppVersion(1:comm.PlatformArgs platformArgs, 2:app_manager.AppVersion appVersion) throws (1:comm.ErrorInfo err);

	/**
	  * 更新应用信息
	  */
	void 11:updateAppVersion(1:comm.PlatformArgs platformArgs, 2:app_manager.AppVersion appVersion) throws (1:comm.ErrorInfo err);

	void 12:removeAppVersion(1:comm.PlatformArgs platformArgs, 2:i64 appVersionId) throws (1:comm.ErrorInfo err);


	/**
	  * 查询服务端应用支持的应用版本信息信息
	  */
	list<app_manager.ServerAppSupport> 13:reqServerAppSupport(1:comm.PlatformArgs platformArgs, 2:ReqServerAppSupportOption option) throws (1:comm.ErrorInfo err);

	void 14:addServerAppSupport(1:comm.PlatformArgs platformArgs, 2:app_manager.ServerAppSupport support) throws (1:comm.ErrorInfo err);

	void 15:updateServerAppSupport(1:comm.PlatformArgs platformArgs, 2:app_manager.ServerAppSupport support) throws (1:comm.ErrorInfo err);

	void 16:removeServerAppSupport(1:comm.PlatformArgs platformArgs, 2:i64 serverVersionId, 3:i64 supportClientId) throws (1:comm.ErrorInfo err);
}