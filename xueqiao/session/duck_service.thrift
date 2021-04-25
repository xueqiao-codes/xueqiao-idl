/**
 * for session query and update
 */

namespace java com.longsheng.xueqiao.duck.thriftapi
include "../../comm.thrift"


service(69) DuckService{
	binary 1:getSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey) 
		throws(1:comm.ErrorInfo err);
	
	void 2:updateSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey, 
		3:binary sessionValue, 4:i32 expireSeconds) throws(1:comm.ErrorInfo err);
		
	void 3:deleteSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey)
		throws(1:comm.ErrorInfo err);

	list<binary> 4:batchGetSession(1:comm.PlatformArgs platformArgs, 2:list<string> sessionKeyList) 
		throws(1:comm.ErrorInfo err);

	binary 5:getAppSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey, 3:string appId) 
		throws(1:comm.ErrorInfo err);

	void 6:updateAppSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey, 
		3:binary sessionValue, 4:i32 expireSeconds, 5:string appId) throws(1:comm.ErrorInfo err);
		
	void 7:deleteAppSession(1:comm.PlatformArgs platformArgs, 2:string sessionKey, 3:string appId)
		throws(1:comm.ErrorInfo err);


}

