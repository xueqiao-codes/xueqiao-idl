 /**
 * oa software ao
 */
namespace csharp oa.software.ao
namespace * org.soldier.platform.oa.software.ao

include "../comm.thrift"

struct SoftwareVersion {
	1:optional i32 Major;		// 主版本号
	2:optional i32 Minor;		// 次版本号
	3:optional i32 Build;		// build 版本号
}

struct UpdateInfo {
	1:optional bool compareVersionInMaintain;		// 比较版本是否仍在维护。调用方据此判断是否要强制升级
	2:optional SoftwareVersion newestVersion;			// 最新版本信息
	3:optional string newVersionUpdateLinkURL; 		// 新版本的升级链接地址
	4:optional list<string> newVersionReleaseNotes; // 新版本的升级描述
}

enum OaSoftwareAoError {
	ParameterError = 100,
	SoftwareInfoNotFound = 101,
	ServerBusy = 102,
}

service(998) OaSoftwareAo {
	/**
	  *  查询软件升级信息
	  */
	UpdateInfo 1:queryUpdateInfo(1:comm.PlatformArgs platformArgs, 
								 2:string platform, 
								 3:string bundleId, 
								 4:SoftwareVersion compareVersion) throws(1:comm.ErrorInfo err);
	
}



