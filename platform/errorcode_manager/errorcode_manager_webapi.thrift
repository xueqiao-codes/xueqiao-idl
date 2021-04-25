namespace java org.soldier.platform.errorcode.manager.webapi.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "errorcode_manager.thrift"

service(93) ErrorCodeManagerWebApi {

	/**
	  * 添加错误领域
	  */
	void 1:addErrorCodeDomain(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ErrorCodeDomain errorCodeDomain) throws (1:comm.ErrorInfo err);

	/**
	  * 更新错误领域
	  */
	void 2:updateErrorCodeDomain(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ErrorCodeDomain errorCodeDomain) throws (1:comm.ErrorInfo err);

	void 3:removeErrorCodeDomain(1:comm.PlatformArgs platformArgs, 2:string name) throws (1:comm.ErrorInfo err);

	/**
	  * 查询领域
	  */
	errorcode_manager.ErrorCodeDomainPage 4:reqErrorCodeDomain(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ReqErrorCodeDomainOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	/**
	  * 添加错误信息
	  */
	void 6:addErrorCodeItem(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ErrorCodeItem errorCodeItem) throws (1:comm.ErrorInfo err);
	
	/**
	  * 根据错误信息(索引条件是domainName 和 code)
	  */
	void 7:updateErrorCodeItem(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ErrorCodeItem errorCodeItem) throws (1:comm.ErrorInfo err);

	void 8:removeErrorCodeItem(1:comm.PlatformArgs platformArgs, 2:string domainName, 3:i32 code) throws (1:comm.ErrorInfo err);

	/**
	  * 查询错误信息
	  */
	errorcode_manager.ErrorCodeItemPage 9:reqErrorCodeItem(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ReqErrorCodeItemOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	/**
	  * 查询版本信息
	  */
	errorcode_manager.ErrorCodeDataVersionPage 15:reqErrorCodeDataVersion(1:comm.PlatformArgs platformArgs, 2:errorcode_manager.ReqErrorCodeDataVersionOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	/**
	  * 生成新版本
	  */
	void 16:generateNewDataVersion(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}