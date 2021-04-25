/**
  * 短信验证dao
  */

namespace java com.longsheng.xueqiao.goose.dao.thriftapi

include "../../../comm.thrift"
include "goose_common.thrift"

/**
  * 短信验证dao
  */
service(83) GooseDao {
	/**
	  * 查询
	  */
	list<goose_common.TSmsVerify> 1:querySmsVerify(
		1:comm.PlatformArgs platformArgs, 2: goose_common.QuerySmsVerifyOption querySmsVerifyOption) throws (1:comm.ErrorInfo err);

	/**
	  * 添加
	  */
	i32 2:addSmsVerify(1:comm.PlatformArgs platformArgs, 2:goose_common.TSmsVerify smsVerify)throws (1:comm.ErrorInfo err);

	/**
	  * 修改
	  */
	void 3:updateSmsVerify(1:comm.PlatformArgs platformArgs, 2:goose_common.TSmsVerify smsVerify)throws (1:comm.ErrorInfo err);
	
	/**
	  * 查询
	  */
	goose_common.TSmsResendTaskPage 4:querySmsResendTask(
		1:comm.PlatformArgs platformArgs, 2:goose_common.QuerySmsResendTaskOption option, 3:i32 pageIndex, 4:i32 pageSize) 
		throws (1:comm.ErrorInfo err);

	/**
	  * 添加
	  */
	i32 5:addSmsResendTask(1:comm.PlatformArgs platformArgs, 2:goose_common.TSmsResendTask task)throws (1:comm.ErrorInfo err);

	/**
	  * 修改
	  */
	void 6:updateSmsResendTask(1:comm.PlatformArgs platformArgs, 2:goose_common.TSmsResendTask task)throws (1:comm.ErrorInfo err);
	
}