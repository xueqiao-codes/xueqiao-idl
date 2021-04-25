/**
  *  交易托管机云端入口API
  */
namespace * xueqiao.trade.hosting.cloud.ao

include "../../comm.thrift"
include "../../page.thrift"
include "trade_hosting_basic.thrift"

struct HostingInitReq {
    1:optional i64    machineId;          // 托管机ID
    2:optional string adminLoginName;
    3:optional string adminLoginPasswd;
    4:optional string hostingAES16Key;    // 用于授权验证
    5:optional trade_hosting_basic.HostingRunningMode runningMode; // 托管机运行模式
}

struct HostingInitResp {
    1:optional trade_hosting_basic.HostingInfo info; // 当前托管机信息
}

struct HostingResetReq {
    1:optional i32 machineId;
    2:optional string hostingAES16Key;
}

struct LoginReq {
    1:optional i64 machineId;  
    2:optional string loginUserName;
    3:optional string loginPasswordMd5;
}

struct LoginResp {
    1:optional trade_hosting_basic.HostingSession session;   // 用户登陆态
    3:optional i32    hostingProxyPort;                // 托管机接入代理端口
    4:optional i64    hostingTimens;                   // 登陆时获取的服务端纳秒时间
	5:optional trade_hosting_basic.HostingRunningMode runningMode;   // 托管机运行模式
	6:optional trade_hosting_basic.HostingUser loginUserInfo;              // 登录用户的基本信息
}

struct RegisterHostingUserResp {
    1:optional i64 machineId;
    2:optional i32 subUserId;
}

service(700) TradeHostingCloudAo {
    /**
      * 托管机基础相关
      */
    HostingInitResp 1:initHosting(1:comm.PlatformArgs platformArgs, 2:HostingInitReq req) throws (1:comm.ErrorInfo err);

    trade_hosting_basic.HostingInfo 2:getHostingInfo(1:comm.PlatformArgs platformArgs) throws(1:comm.ErrorInfo err);
    
    // 重置托管机，清空原有公司数据信息， 慎用
    void 3:resetHosting(1:comm.PlatformArgs platformArgs, 2:HostingResetReq req) throws (1:comm.ErrorInfo err);
    
    /**
      * 注册托管机子用户
      */
    RegisterHostingUserResp 7:registerHostingUser(1:comm.PlatformArgs platformArgs
            , 2:trade_hosting_basic.HostingUser newUser) throws (1:comm.ErrorInfo err);
            
    /**
      * 更新用户信息
      */
    void 8:updateHostingUser(1:comm.PlatformArgs platformArgs
            , 2:trade_hosting_basic.HostingUser  updateUser) throws (1:comm.ErrorInfo err);
   
    /**
      * 禁用特定的子用户
      */
    void 9:disableHostingUser(1:comm.PlatformArgs platformArgs
            , 2:i32 subUserId) throws(1:comm.ErrorInfo err);
            
    /**
     * 子用户列表页查询
     */
    trade_hosting_basic.QueryHostingUserPage 10:getHostingUserPage(
            1:comm.PlatformArgs platformArgs
            , 2:trade_hosting_basic.QueryHostingUserOption queryOption
            , 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
            
    /**
      * 启用特定的子用户
      */
    void 11:enableHostingUser(1:comm.PlatformArgs platformArgs
            , 2:i32 subUserId) throws (1:comm.ErrorInfo err);         
   
    /**
      * Session相关
      */
    LoginResp 20:login(1:comm.PlatformArgs platformArgs, 2:LoginReq req) throws (1:comm.ErrorInfo err);
    
    bool 21:checkSession(1:comm.PlatformArgs platformArgs, 2:trade_hosting_basic.HostingSession session) throws (1:comm.ErrorInfo err);
    

}