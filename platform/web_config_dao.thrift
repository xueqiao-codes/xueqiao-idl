/**
  * web config dao
  */
namespace java org.soldier.platform.web.config.dao

include "../comm.thrift"

enum DeployType {
	Mitty = 1,
	Apache = 2,
	Jetty = 4,
	Nginx = 8
}

struct WebConfig {
	1:optional string webProjectName;
	2:optional DeployType deployType;
	3:optional list<i64> ipList;  //deprecated, use backendList
	4:optional i32 port;
	5:optional list<string> domainList;
	6:optional string indexPath;
	7:optional string desc;
	8:optional string serverOptions;
	9:optional string locationOptions;
	
	10:optional list<string> backendList; # 后端列表
	11:optional string httpsCertName;  # https证书名称
	12:optional bool disableHttp;   # 禁用Http，全部转向https 
	
	15:optional i32 createTimestamp;
	16:optional i32 lastmodifyTimestamp;
}

struct WebConfigList {
	1:required i32 totalCount;
	2:required list<WebConfig> configList;
}

struct QueryWebConfigOption {
	1:optional string webProjectName;
	2:optional string backend;
	3:optional string desc;
	4:optional DeployType type;
	5:optional i32 port;
	6:optional string domain;
}

enum ConfigType {
	AllConfig = 1,
	HttpConfig = 2
}

service(28) WebConfigDao {
	WebConfigList 1:queryConfigByPage(1:comm.PlatformArgs platformArgs,
		2:QueryWebConfigOption option, 3:i32 pageIndex, 4:i32 pageSize) throws (1:comm.ErrorInfo err);
	
	list<WebConfig> 2:queryConfig(1:comm.PlatformArgs platformArgs, 
		2:QueryWebConfigOption option) throws (1:comm.ErrorInfo err);
	
	void 3:addWebConfig(1:comm.PlatformArgs platformArgs, 2:WebConfig config) throws (1:comm.ErrorInfo err);
	
	void 4:deleteWebConfig(1:comm.PlatformArgs platformArgs, 2:string webProjectName) throws (1:comm.ErrorInfo err);
	
	void 5:updateWebConfig(1:comm.PlatformArgs platformArgs, 2:WebConfig config) throws (1:comm.ErrorInfo err);

	void 6:updateNginxConfig(1:comm.PlatformArgs platformArgs, 2:string config, 3:ConfigType type) throws (1:comm.ErrorInfo err);
	i32 7:getLastVersion(1:comm.PlatformArgs platformArgs, 2:ConfigType type) throws (1:comm.ErrorInfo err);
	string 8:getLastestNginxConfig(1:comm.PlatformArgs platformArgs, 2:ConfigType type) throws (1:comm.ErrorInfo err);
}