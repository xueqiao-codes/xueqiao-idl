namespace * xueqiao.company

include "../sync_hosting_task/hosting_sync_task_queue.thrift"


/**
  * 公司类型
  */
enum CompanyType {
    NORMAL = 0,        // 普通型，对应公司用户
    COLLECTIVE = 1,    // 集体型，个人版用户挂靠在集体型公司下
}

/**
  * 公司实体
  */
struct CompanyEntry {
    1:optional i32 companyId;                               //注册时系统生成，唯一id，不可变
    2:optional string companyCode;                          //公司代号，唯一值，不可变
    3:optional string companyName;                          //公司显示名称，可变
    4:optional string fund;                                 //资金规模
    5:optional string channel;                              //注册渠道
    6:optional string address;                              //公司实际地址, 可变
    7:optional string email;                                //联系电子信箱，唯一，可变
    8:optional string telephone;                            //联系手机号，唯一，可变
    9:optional string password;                             //公司登陆密码
    10:optional string contact;
    11:optional CompanyType type;
    30:optional i64 createTimestamp;
    32:optional i64 lastmodifyTimestamp;
}

//托管服务操作员角色
enum OperatorRole{
    TRADER = 0,          // 交易员
    ADMIN = 1,          // 管理员
    OBSERVER = 2,       // 观察员
}

enum UserStatus{
	NORMAL = 0,          // 正常
	DISABLED = 1,        // 禁用
}

/**
  * 用户类型
  */
enum CompanyUserType {
    COMPANY_USER = 0,    // 机构用户
    PERSONAL_USER = 1,   // 个人用户
}

struct CompanyUser{
    1:optional i32 userId;
    2:optional i32 companyId;
    3:optional string userName;
    4:optional string password;
    5:optional string tel;
    6:optional string cnName;
    7:optional UserStatus status;
    8:optional string email;           // 数据库层不做唯一性限定

    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
    12:optional CompanyUserType type;
    13:optional i64 expiredTimeMillis;
}

struct GroupUser{
    1:optional i32 userId;
    2:optional i32 companyId;
    3:optional i32 groupId;
    4:optional OperatorRole role;

    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct CompanyUserEx{
    1:optional CompanyUser companyUser;
    2:optional list<GroupUser> groupUserList;
}

/**
  * 公司组
  */
struct CompanyGroup {
	1:optional i32 companyId;                            //公司ID
	2:optional i32 groupId;                              //组ID
	3:optional string groupCode;                         //组代号
	4:optional string groupName;                         //组名称
	5:optional string hostingAES16Key;                   //托管机授权验证码

    10:optional i32 createTimestamp;
    11:optional i32 lastmodifyTimestamp;
}

struct QueryGroupUserExOption{
    1:optional set<i32> companyIds;
    2:optional set<i32> groupIds;
    3:optional set<OperatorRole> roles;
}

/**
  * 公司配置信息
  */
struct CompanySpec {
    1:optional i32 companyId;
    2:optional set<i32> subscribeCommodityIds;

    10:optional i64 createTimestamp;                     
    11:optional i64 lastmodifyTimestamp;
}

//交易类型
enum TradeType {
    NONE = 0,   //未设定
    REAL = 1,   //实盘
    SIM = 2,    //模拟
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

/**
  * 公司组配置信息(会根据购买的配置改变)
  */
struct CompanyGroupSpec {
    1:optional i32 companyId;                            //公司ID
    2:optional i32 groupId;                              //组ID

    // 组配置, 根据需要会增加多个权限属性(接口使用权限, 交易账号数量等)
    5:optional HostingServiceStatus hostingServiceStatus;
    6:optional TradeType serviceType;
    7:optional string specName;                         // 规格名称 (从支付服务中同步过来的信息，加快访问速度)
    8:optional i64 expiredTimestamp;                    // 过期时间 (从支付服务中同步过来的信息，加快访问速度)

    10:optional i64 releaseTimestamp;                   // 托管机释放时间
    11:optional string operateDescription;              // 操作描述

    20:optional i64 createTimestamp;
    21:optional i64 lastmodifyTimestamp;
}

struct QueryGroupUserOption{
    1:optional i32 companyId;
    2:optional i32 groupId;
    3:optional i32 userId;
}

struct GroupUserPage{
    1:optional i32 total;
    2:optional list<GroupUser> page;
}

struct QueryCompanyUserOption{
    1:optional i32 companyId;
    2:optional set<i32> userId;
    3:optional string userName;
    4:optional UserStatus status;
    5:optional string password;       // RSA 加密后的密码
    6:optional string tel;
    7:optional CompanyUserType type;
}

struct CompanyUserPage{
    1:optional i32 total;
    2:optional list<CompanyUser> page;
}

struct QueryCompanySpecOption{
    1:optional set<i32> companyIds;
}

struct QueryCompanyGroupSpecOption{
    1:optional i32 companyId;
    2:optional i32 companyGroupId;
}

struct QueryExpiredGroupSpecOption{
    1:optional i32 companyId;
    2:optional i32 companyGroupId;
    3:optional i64 expiredOffsets;
    4:optional HostingServiceStatus hostingServiceStatus;
}

struct CompanySpecPage{
    1:optional i32 total;
    2:optional list<CompanySpec> page;
}

struct CompanyGroupSpecPage{
    1:optional i32 total;
    2:optional list<CompanyGroupSpec> page;
}

struct QueryCompanyOption {
    1:optional i32 companyId;
    2:optional string companyCodePartical;
    3:optional string companyCodeWhole;
    4:optional string companyNamePartical;
    5:optional string emailPartical;
    6:optional string emailWhole;
    7:optional string phonePartical;
    8:optional string phoneWhole;
} 

struct CompanyPageResult {
    1:optional i32 totalCount;
    2:optional list<CompanyEntry> resultList;
}

struct QueryCompanyGroupOption {
	1:optional i32 companyId;
	2:optional i32 groupId;
	3:optional string groupCodePartical;
	4:optional string groupCodeWhole;
	5:optional string groupNamePartical;
	6:optional string groupNameWhole;
}

struct CompanyGroupPageResult {
	1:optional i32 totalCount;
	2:optional list<CompanyGroup> resultList;
}

struct InitHostingMachineReq {
	1:optional i32 companyId;
	2:optional i32 groupId;
	3:optional hosting_sync_task_queue.SyncInitHostingTask initHostingTask;
}

struct UpdateCompanyUserPasswordReq {
	1:optional i32 companyId;
	2:optional string userName;
	3:optional string oldPassword;
	4:optional string newPassword;
}

enum CompanyErrorCode{
    COMPANY_NAME_EXIST = 1000,
    GROUP_NAME_EXIST = 1001,
    USER_NAME_EXIST = 1002,
    COMPANY_NOT_FOUND = 1003,
    GROUP_NOT_FOUND = 1004,
    USER_NOT_FOUND = 1005,
    GROUP_SPEC_NOT_FOUND = 1007,
    GROUP_SERVICE_INVALID = 1008,
    PASSWORD_ERROR = 1009,
}

struct GroupUserEx{
    1:optional i32 userId;
    2:optional i32 companyId;                               
    3:optional i32 groupId;
    4:optional string userName;
    5:optional string cnName;
    6:optional string companyCode;                          
    7:optional string companyName;                          
    8:optional string groupCode;                         //组代号
    9:optional string groupName;                         //组名称
    10:optional string tel;
    11:optional string email;
    12:optional OperatorRole role;
    13:optional HostingServiceStatus hostingServiceStatus;
}

struct GroupUserExPage{
    1:optional i32 total;
    2:optional list<GroupUserEx> page;
}