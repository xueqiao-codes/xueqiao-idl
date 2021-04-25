namespace java org.soldier.platform.app.manager.webapi.thriftapi
namespace py org.soldier.platform.app.manager.webapi.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "app_manager.thrift"

/**
  * 预留filter做为筛选的条件
  */	
struct AppFilter{
	1:optional app_manager.AppType appType;
	2:optional i64 projectId;
	3:optional app_manager.OSPlatform osPlatform;
	4:optional string appNamePartical;
}

/**
  * 预留filter做为筛选的条件
  */	
struct AppVersionFilter{
	1:optional i64 appId;
	2:optional string appKey;
	3:optional string versionKey;
	4:optional app_manager.VersionState versionState;
	5:optional app_manager.VersionNum startVersionNum;
	6:optional app_manager.VersionNum endVersionNum;
}

struct ClientAppVersionReference{
	1:optional i64 appVersionId;
	2:optional i64 refAppVersionId;
	3:optional string refAppName;
	4:optional list<string> appVersionTag;
}

enum SystemType{
	X32 = 0,
	X64 = 1,
}

struct AppFileUploadInfo{
	1:optional i64 appVersionId;
	2:optional SystemType systemType;
	3:optional binary content;
	4:optional string extendFileName;		// 扩展名
}

service(91) AppManagerWebApi {
	list<app_manager.Project> 1:reqProject(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	void 2:addProject(1:comm.PlatformArgs platformArgs, 2:app_manager.Project project) throws (1:comm.ErrorInfo err);

	void 3:updateProject(1:comm.PlatformArgs platformArgs, 2:app_manager.Project project) throws (1:comm.ErrorInfo err);

	void 4:removeProject(1:comm.PlatformArgs platformArgs, 2:i64 projectId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询应用信息
	  * 应用数量基本上是数量比较少，直接采用list返回而不分页
	  */		
	list<app_manager.App> 5:reqApp(1:comm.PlatformArgs platformArgs, 2:AppFilter filter) throws (1:comm.ErrorInfo err);

	void 6:addApp(1:comm.PlatformArgs platformArgs, 2:app_manager.App app) throws (1:comm.ErrorInfo err);

	/**
	  * 更新应用信息
	  * 根据业务，部分字段可以更新
	  */
	void 7:updateApp(1:comm.PlatformArgs platformArgs, 2:app_manager.App app) throws (1:comm.ErrorInfo err);

	/**
	  * 删除应用信息
	  */
	void 8:removeApp(1:comm.PlatformArgs platformArgs, 2:i64 appId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询应用版本信息
	  */		
	app_manager.AppVersionPage 9:reqAppVersion(1:comm.PlatformArgs platformArgs, 2:AppVersionFilter filter, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	void 10:addAppVersion(1:comm.PlatformArgs platformArgs, 2:app_manager.AppVersion appVersion) throws (1:comm.ErrorInfo err);

	/**
	  * 更新应用信息
	  * 根据业务，部分字段可以更新
	  */
	void 11:updateAppVersion(1:comm.PlatformArgs platformArgs, 2:app_manager.AppVersion appVersion) throws (1:comm.ErrorInfo err);

	void 12:removeAppVersion(1:comm.PlatformArgs platformArgs, 2:i64 appVersionId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询服务端应用支持的应用版本信息信息
	  */
	list<app_manager.ServerAppSupport> 13:reqServerAppSupport(1:comm.PlatformArgs platformArgs, 2:i64 serverAppVersionId) throws (1:comm.ErrorInfo err);

	void 14:addServerAppSupport(1:comm.PlatformArgs platformArgs, 2:app_manager.ServerAppSupport support) throws (1:comm.ErrorInfo err);

	/**
	  * 更新服务端应用支持的应用版本信息信息
	  * 根据业务，部分字段可以更新
	  */
	void 15:updateServerAppSupport(1:comm.PlatformArgs platformArgs, 2:app_manager.ServerAppSupport support) throws (1:comm.ErrorInfo err);

	list<ClientAppVersionReference> 16:reqClientAppVersionReference(1:comm.PlatformArgs platformArgs, 2:i64 appVersionId) throws (1:comm.ErrorInfo err);

	/**
	  * 上传对应版本的应用安装文件， extendFileName 表示文件所用的扩展名
	  */
	void 17:uploadAppFile(1:comm.PlatformArgs platformArgs, 2:AppFileUploadInfo appFileUploadInfo)throws (1:comm.ErrorInfo err);

	void 18:removeServerAppSupport(1:comm.PlatformArgs platformArgs, 2:i64 serverVersionId, 3:i64 supportClientAppId) throws (1:comm.ErrorInfo err);
}