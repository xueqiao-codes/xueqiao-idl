/**
  * 信箱服务管理后台的webapi
  */
namespace java xueqiao.mailbox.webapi.thriftapi

include "mailbox.thrift"
include "mb_message.thrift"
include "mailbox_dao_req.thrift"
include "../../comm.thrift"
include "../../page.thrift"

struct OperateResult{
	1:optional bool success;
	2:optional i32 code;
	3:optional string message;
}

struct CompanyReceiver{
	1:optional i64 companyId;
	2:optional string companyCode;
	3:optional string companyName;
}

struct GroupReceiver{
	1:optional i64 groupId;
	2:optional string groupCode;
	3:optional string groupName;
	4:optional i64 companyId;
}

struct ContentText{
	1:optional string fileName;
	2:optional string contentText;
}

struct MBMessageTemplateSelector{
	1:optional i64 templateId;
	2:optional string templateName;
}

/**
  * 信箱消息系统dao
  */
service(361) MailboxWebapi {
	
	/**
	  * 查询信箱消息模板
	  */
	mailbox_dao_req.MBMessageTemplatePage 1:reqTemplate(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageTemplateOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	OperateResult 2:addTemplate(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessageTemplate template) throws (1:comm.ErrorInfo err);

	OperateResult 3:updateTemplate(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessageTemplate template) throws (1:comm.ErrorInfo err);

	OperateResult 4:removeTemplate(1:comm.PlatformArgs platformArgs, 2:i64 templateId) throws (1:comm.ErrorInfo err);

	mailbox_dao_req.MBMessageJobPage 5:reqMBMessageJob(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageJobOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	OperateResult 6:addMBMessage(1:comm.PlatformArgs platformArgs, 2:mailbox.MBMessage message) throws (1:comm.ErrorInfo err);

	list<CompanyReceiver> 7:reqCompanyReceiver(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	list<GroupReceiver> 8:reqGroupReceiver(1:comm.PlatformArgs platformArgs, 2:i64 companyId) throws (1:comm.ErrorInfo err);

	ContentText 9:reqContentText(1:comm.PlatformArgs platformArgs, 2:string fileName) throws (1:comm.ErrorInfo err);

	list<MBMessageTemplateSelector> 10:reqMBMessageTemplateSelector(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	/**
	* 查询消息列表
	*/
	mailbox_dao_req.MBMessagePage 11:reqMBMessage(1:comm.PlatformArgs platformArgs, 2:mailbox_dao_req.QueryMBMessageOption queryOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	OperateResult 12:updateMessageJobStatus(1:comm.PlatformArgs platformArgs, 2:i64 messageJobId, 3:mailbox.MJStatus status) throws (1:comm.ErrorInfo err);
}


