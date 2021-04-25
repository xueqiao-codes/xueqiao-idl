namespace java org.soldier.platform.app.manager.thriftapi
namespace py org.soldier.platform.app.manager.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

/*
 * 应用类型：客户端，服务端
*/
enum AppType{
	CLIENT = 0,
	SERVER = 1,
}

/*
 * 操作系统平台
*/
enum OSPlatform{
	WINDOWS = 0,
	LINUX = 1,
}

/*
 * 项目
*/
struct Project{
	1:optional i64 projectId;
	2:optional string projectName;			// 项目名称
	3:optional string note;					// 备注
	4:optional i64 createTimestamp;
	5:optional i64 lastModifyTimestamp;
}

/*
 * 应用
*/
struct App{
	1:optional i64 appId;
	2:optional string appKey;			// 应用key，应用唯一, no change
	3:optional string appName;			// 应用名称
	4:optional AppType appType;			// 应用类型(客户端，服务端...)
	5:optional string iconUrl;			// 图标地址
	6:optional string note;				// 备注描述
	7:optional i64 projectId;			// 所属项目
	8:optional OSPlatform osPlatform;	// 操作系统
	9:optional i64 createTimestamp;
	10:optional i64 lastModifyTimestamp;
}

/*
 * 更新类型
*/
enum UpdateType{
	FREE_UPDATE = 0			// 自由更新
	FORCE_UPDATE = 1,		// 强制更新
}

/*
 * 描述一个应用的版本号
*/
struct VersionNum{
	1:optional i32 majorVersionNum;		// 主版本号
	2:optional i32 minorVersionNum;		// 小版本号
	3:optional i32 buildVersionNum;		// 编译版本号
	4:optional i32 reversionNum;		// 修正版本号
}

/*
 * 描述一个应用版本的启用状态
*/
enum VersionState{
	ENABLE = 0,		// 启用
	DISABLE = 1,	// 禁用，失效
}

/*
 * 描述一个应用的版本信息
 * 一个应用可以支持多个版本的其他多个应用
*/
struct AppVersion{
	1:optional i64 versionId;
	2:optional i64 appId;
	3:optional AppType appType;			// 应用类型(客户端，服务端...)
	4:optional string appKey;			// 应用key
	5:optional string versionKey;		// 版本key,由应用key和版本号标识字符串生成,唯一标识
	6:optional VersionNum versionNum;	// 版本号描述
	7:optional string versionNumTag;		// 版本号标识字符串

	8:optional string downloadUrlX32;		// 32位软件下载地址
	9:optional string downloadUrlX64;		// 64位软件下载地址
	10:optional UpdateType updateType;	// 更新类型
	
	11:optional map<string,string> extraInfo;	//预留额外信息
	13:optional string operator;		// 添加人员
	14:optional string note;			// 备注信息
	15:optional list<string> updateNotes;// 更新信息, 发布描述
	16:optional VersionState versionState;

	17:optional i64 createTimestamp;	// 创建时间
	18:optional i64 lastModifyTimestamp;
}


/*
 * 描述一个服务端应用版本的对应信息
*/
struct ServerAppSupport{
	1:optional i64 serverVersionId;
	2:optional i64 supportClientAppId;
	3:optional VersionNum minSupportVersion;		// 例如 1.0.1.0
	4:optional VersionNum maxSupportVersion;		// 0.0.0.0 或者null 表示无限大
	5:optional i64 createTimestamp;	// 创建时间
	6:optional i64 lastModifyTimestamp;
	7:optional string supportClientName;
}

struct AppVersionPage{
	1:optional i32 total;
	2:optional list<AppVersion> page;
}