/*
 *  dao for route operations, information query
 */
namespace java org.soldier.platform.route.dao
namespace cpp platform.route_dao

include "../comm.thrift"

const i32 MAX_SERVICE_KEY_VALUE = 2000;

enum RouteType {
	Mod = 1,  // 按模
	RR = 2,   // 轮询
	XL = 3    // 最小心跳连接 
	K8SSrv = 4, // K8S的无状态服务路由
	K8SMod = 5, // K8S的按摩路由，适合有状态的服务
}

struct RouteInfo {
	1:required i32 serviceKey,
	2:optional string serviceName,
	3:optional list<i64> ipList;
	4:optional string desc;
	5:optional i32 createTimestamp;
	6:optional i32 lastmodifyTimestamp;
	7:optional RouteType routeType;
	8:optional list<string> serviceAdminList;
	9:optional string idlRelativePath;
	10:optional string relatedScreenId;
}

struct QueryRouteOption {
	1:optional i32 serviceKey;
	2:optional string serviceName;
	3:optional string ip;
	4:optional string desc;
	5:optional string serviceAdmin;
}

struct RouteInfoList {
	1:optional i32 totalCount;
	2:optional list<RouteInfo> resultList;
}

struct SimpleRouteInfo {
	1:required i32 serviceKey;
	2:required list<i64> ipList;
}

service(20) RouteDao {
	void 1:addRoute(1:comm.PlatformArgs platformArgs, 2:RouteInfo route) 
		throws (1:comm.ErrorInfo err);
	
	void 2:updateRoute(1:comm.PlatformArgs platformArgs, 2:RouteInfo route)
		throws (1:comm.ErrorInfo err);
		
	void 3:deleteRoute(1:comm.PlatformArgs platformArgs, 3:i32 serviceKey)
		throws (1:comm.ErrorInfo err);
	
	RouteInfoList 4:queryRouteInfoList(1:comm.PlatformArgs platformArgs, 2:i32 pageIndex,
		3:i32 pageSize, 4:QueryRouteOption option) throws (1:comm.ErrorInfo err);
		
	void 5:syncRoute(1:comm.PlatformArgs platformArgs, 2:string config) throws (1:comm.ErrorInfo err);
	
	i32 6:getLastRouteVersion(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
	
	list<SimpleRouteInfo> 7:getAllSimpleRouteInfo(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
	string 8:getLastestRouteConfig(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}
