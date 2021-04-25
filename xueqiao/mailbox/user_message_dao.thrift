/**
  * 托管机消息信箱服务dao
  */
namespace java xueqiao.mailbox.user.message.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "user_message.thrift"

/**
  * 托管机消息信箱系统dao
  */
service(362) UserMessageDao {

	/**
	  * 添加托管机消息
	  */
	void 1:addUserMessage(1:comm.PlatformArgs platformArgs, 2:list<user_message.UserMessage> userMessage) throws (1:comm.ErrorInfo err);
	
	user_message.UserMessagePage 2:reqUserMessage(1:comm.PlatformArgs platformArgs, 2:user_message.ReqUserMessageOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	void 3:markAsRead(1:comm.PlatformArgs platformArgs, 2:user_message.MarkReadOption option) throws (1:comm.ErrorInfo err);
}