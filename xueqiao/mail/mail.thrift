/**
  * 邮件ao
  */

namespace java xueqiao.mail

// 内容类型
enum ContentType {
    TEXT,
    HTML
}

// 邮件配置
struct MailSettings {
    1:required string smtpHost;              // 发送域名(mail.smtp.host)
    2:required string sender;                // 发送账号
    3:required string passwd;                // 密码
    4:optional string senderAlias;                 // 邮件别名
}

// 邮件内容
struct MailContent {
    1:required ContentType contentType;  // 内容类型
    2:required string content;           // 内容
}

// 邮件
struct MailEntity {
    1:required list<string> receivers;       // 接收人列表
    2:optional list<string> cc;              // 抄送人列表
    3:optional list<string> bcc;             // 秘密抄送人列表
    4:required string subject;               // 主题
    5:optional MailContent content;          // 内容
    6:optional list<string> attachments;     // 附件列表
}