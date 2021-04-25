/**
  * 无法直接到托管机，需要先到代理的托管机接口
  */
namespace * xueqiao.trade.hosting.proxy

include "../../comm.thrift"
include "../trade/trade_hosting_basic.thrift"
include "../mailbox/user_message.thrift"
include "../../page.thrift"

struct ProxyLoginReq{
    1:optional string companyCode;
    2:optional string userName;
    3:optional string passwordMd5;
    4:optional string companyGroupCode;
    5:optional string verifyCode;
}

struct ProxyLoginResp {
    1:optional trade_hosting_basic.HostingSession hostingSession;
    2:optional string hostingServerIP;
    3:optional i32    hostingProxyPort;
    4:optional i64    hostingTimens;
	5:optional trade_hosting_basic.HostingRunningMode hostingRunningMode;
	6:optional i32    companyId; 
	7:optional i32    companyGroupId;
	8:optional trade_hosting_basic.HostingUser loginUserInfo;
}

//交易类型
enum ProxyTradeType {
    REAL = 1,   //实盘
    SIM = 2,    //模拟
}

enum LoginUserType{
  NORMAL_COMPANY_USER = 0,           // 团体用户
  XQ_COMPANY_PERSONAL_USER = 1,      // 个人用户
}

struct ProxyFakeLoginReq{
    1:optional string companyCode;
    2:optional string userName;
    3:optional string passwordMd5;
    4:optional ProxyTradeType tradeType;
    5:optional string verifyCode;
    6:optional LoginUserType loginUserType;
}

//托管服务状态
enum HostingServiceStatus{
    WAITING = 0,        // 等待开通状态
    OPENING = 1,        // 开通中状态
    UPGRADING = 2,      // 升级中
    WORKING = 3,        // 已通状态
    EXPIRED = 4,        // 已过期
    RELEASED = 5,       // 已释放
}

struct ProxyCompanyGroup {
	1:optional i32 companyId;                            //公司ID
	2:optional i32 groupId;                              //组ID
	3:optional string groupCode;                         //组代号
	4:optional string groupName;                         //组名称
	5:optional HostingServiceStatus status;              //托管服务状态
}

struct ProxyFakeLoginResp{
    1:optional list<ProxyCompanyGroup> companyGroups;
    2:optional string companyCode;
}

struct ProxyUpdatePasswordReq{
    1:optional i32 companyId;
    2:optional string userName;
    3:required string oldPassword; // RSA加密后的字符串
    4:required string newPassword; // RSA加密后的字符串
}

/*
 * 描述一个应用的版本号
*/
struct VersionNum{
  1:optional i32 majorVersionNum;   // 主版本号
  2:optional i32 minorVersionNum;   // 小版本号
  3:optional i32 buildVersionNum;   // 编译版本号
  4:optional i32 reversionNum;    // 修正版本号
}

/*
 * 更新类型
*/
enum UpdateType{
  FREE_UPDATE = 0     // 自由更新
  FORCE_UPDATE = 1,   // 强制更新
}

/*
 * 描述应用的版本信息
 *
*/
struct AppVersion{
  1:optional i64 versionId;
  2:optional i64 appId;
  3:optional string appKey;           // 应用key
  4:optional string versionKey;       // 版本key,由应用key和版本号标识字符串生成,唯一标识
  5:optional VersionNum versionNum;   // 版本号描述
  6:optional string versionNumTag;    // 版本号标识字符串
  7:optional string downloadUrlX32;   // 32位软件下载地址
  8:optional string downloadUrlX64;   // 64位软件下载地址
  9:optional list<string> updateNotes;// 更新信息, 发布描述
  10:optional UpdateType updateType;  // 更新类型
}

/*
 * 查询应用的版本信息的条件
 * 优先使用companyId查询, 如果companyId没设置，会使用companyCoce查询，id和code 必须设置一个
*/
struct UpdateInfoReq{
  1:optional i64 companyId;  
  2:optional string appKey;
  3:optional VersionNum versionNum;
  4:optional string companyCode;
}

/*
 * 查询用户托管机消息的条件
*/
struct ReqMailBoxMessageOption{
  1:optional i64 messageId;
  2:optional user_message.MessageState state;
  3:optional i64 startTimestamp;
  4:optional i64 endTimstamp;
}

/*
 * proxy 根据业务错误返回的错误码
 * 使用50000以上，区别从托管机透传的错误码
*/
enum ProxyErrorCode{
  ERROR_APP_SUPPORT_VERSION_NOT_FOUND = 50001, // 服务器支持的客户端版本不存在
  ERROR_COMPANY_SERVICE_MAINTENANCE_NOT_FOUND = 50002, // 公司的维护信息不存在
  ERROR_APP_NOT_FOUND = 50003, // 客户端应用信息不存在
  ERROR_APP_NOT_SUPPORT = 50004, // 不支持的客户端应用
  ERROR_VERIFY_CODE = 50005, // 验证码错误
}

service(702) TradeHostingProxy{
    /**
      * 客户端可以使用的接口
      */
    ProxyLoginResp 1:login(1:comm.PlatformArgs platformArgs, 2:ProxyLoginReq req) throws(1:comm.ErrorInfo err);
    
    /**
      * 获取公司用户所在的组信息
      */
    ProxyFakeLoginResp 3:fakeLogin(1:comm.PlatformArgs platformArgs, 2:ProxyFakeLoginReq req) throws(1:comm.ErrorInfo err);
    
    /**
      * 修改公司成员密码
      */
    void 5:updateCompanyUserPassword(1:comm.PlatformArgs platformArgs, 2:ProxyUpdatePasswordReq req) throws(1:comm.ErrorInfo err);
    
    /**
      * 云端使用的接口
      */
    bool 20:checkSession(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingSession session) throws(1:comm.ErrorInfo err);

    /**
    *  查询软件升级信息
    */
    AppVersion 30:queryUpdateInfo(1:comm.PlatformArgs platformArgs, 2:UpdateInfoReq req) throws(1:comm.ErrorInfo err);

    // ========= 以下接口已经移到 trade hosting terminal ao，接口已废弃 ==============
    /**
      * 查询用户托管机消息的接口
      */
    user_message.UserMessagePage 35:queryMailBoxMessage(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingSession session, 3:ReqMailBoxMessageOption option, 4:page.IndexedPageOption pageOption) throws(1:comm.ErrorInfo err);

    /**
      * 标记用户托管机消息为已读
      * hostingMessageIds empty 表示所有未读状态设置为已读
      */
    bool 36:markMessageAsRead(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingSession session, 3:set<i64> hostingMessageIds) throws(1:comm.ErrorInfo err);

    // ========= 以上接口已经移到 trade hosting terminal ao，接口已废弃 ==============
}