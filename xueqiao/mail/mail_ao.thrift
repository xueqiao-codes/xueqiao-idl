/**
  * 短信验证ao
  */

namespace java xueqiao.mail.ao.thriftapi

include "../../comm.thrift"
include "mail.thrift"

/**
  * 短信验证ao
  */
service(88) MailAo {

    /**
      * 发送邮件
      */
    void 1:sendMail(1:comm.PlatformArgs platformArgs, 2:mail.MailSettings settings, 3:mail.MailEntity mailEntity) throws (1:comm.ErrorInfo err);
}