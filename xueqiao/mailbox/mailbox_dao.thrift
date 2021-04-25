/**
  * 信箱消息系统dao
  */

namespace * xueqiao.mailbox.dao.thriftapi

include "./mailbox.thrift"
include "./mailbox_dao_req.thrift"
include "../../comm.thrift"
include "../../page.thrift"

/**
  * 信箱消息系统dao
  */
service(360) MailboxDao {

	/**
	  * 提交信箱消息
	  */
	void 1:addMBMessage(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessage message) throws (1:comm.ErrorInfo err);

	/**
	  * 修改信箱消息状态
	  */
	void 2:modifyMBMessageStatus(1:comm.PlatformArgs platformArgs, 2:i64 mbmId, 3:mailbox.MStatus status) throws (1:comm.ErrorInfo err);

	/**
	* 查询消息列表
	*/
	mailbox_dao_req.MBMessagePage 3:queryMBMessagePage(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 提交信箱消息模板
	  */
	void 6:addMBMessageTemplate(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessageTemplate template) throws (1:comm.ErrorInfo err);

	/**
	  * 修改信箱消息模板
	  */
	void 7:modifyMBMessageTemplate(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessageTemplate template) throws (1:comm.ErrorInfo err);

	/**
	  * 删除信箱消息模板
	  */
	void 8:deleteMBMessageTemplate(1:comm.PlatformArgs platformArgs, 2:i64 templateId) throws (1:comm.ErrorInfo err);
	
	/**
	* 查询信箱消息模板列表
	*/
	mailbox_dao_req.MBMessageTemplatePage 9:queryMBMessageTemplatePage(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageTemplateOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	/**
	  * 开始发送信箱消息实例
	  * 生成messageJob，返回jobId
	  */
	i64 10:startSendMBMessage(1:comm.PlatformArgs platformArgs, 2:i64 mbmId, 3:bool isMessageCompleted) throws (1:comm.ErrorInfo err);
	
	/**
	  * 设置发送信箱消息实例成功状态
	  * 废弃
	  */
	//void 11:sendMBMessageSuccess(1:comm.PlatformArgs platformArgs, 2:i64 jobId, 3:bool isMessageCompleted) throws (1:comm.ErrorInfo err);
	
	/**
	  * 修改信箱消息状态
	  */
	void 12:modifyMBMessageJobStatus(1:comm.PlatformArgs platformArgs, 2:i64 jobId, 3:mailbox.MJStatus status, 4:string errorDescription) throws (1:comm.ErrorInfo err);

	/**
	* 查询已发送消息列表
	*/
	mailbox_dao_req.MBMessageJobPage 13:queryMBMessageJobPage(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageJobOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}