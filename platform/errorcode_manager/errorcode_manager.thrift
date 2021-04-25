namespace java org.soldier.platform.errorcode.manager.thriftapi

/**
* 语言类型
*/
enum Lang {
	ZH = 0,  // （简体）中文
	EN = 1,  //  英文
}

/**
* 版本信息
*/
struct ErrorCodeDataVersion {
	1:optional i64 versionCode;
	2:optional string filePath;
	3:optional string fileMD5;
	4:optional i64 createTimestamp;
}

/**
* 错误项
*/
struct ErrorCodeItem {
	1:optional string domainName;
	2:optional i32 code;
	3:optional map<Lang, string> errorMessage;
	10:optional i64 createTimestamp;
	11:optional i64 lastModifyTimestamp;
}

/**
* 错误领域项
*/
struct ErrorCodeDomain {
	1:optional string name;
	2:optional string description;
	
	10:optional i64 createTimestamp;
	11:optional i64 lastModifyTimestamp;
}

/**
* 总错误信息
*/
struct ErrorCodeData {
	1:optional i64 versionCode;
	2:optional map<string, map<i32, ErrorCodeItem>> domainMap; // map<domainName, map<errorCode, ErrorCodeItem>>
}

struct ReqErrorCodeDomainOption{
	1:optional string name
}

struct ErrorCodeDomainPage{
	1:optional i32 total;
	2:optional list<ErrorCodeDomain> page;
}

struct ReqErrorCodeDataVersionOption{
	1:optional i64 versionCode;
}

struct ReqErrorCodeItemOption{
	1:optional string domainName;
	2:optional i32 code;
}

struct ErrorCodeItemPage{
	1:optional i32 total;
	2:optional list<ErrorCodeItem> page;
}

struct ErrorCodeDataVersionPage{
	1:optional i32 total;
	2:optional list<ErrorCodeDataVersion> page;
}

/**
* 本模块错误码定义
*/
const i32 ERRORCODE_META_DATA_NOT_FOUND = 9201;  // 查找META数据失败（数据库中定义有errorcode_meta）
const i32 ERRORCODE_META_DATA_DIRTY_DATA_NOT_FOUND = 9202;   // 查找dirty_data(META)失败
const i32 ERRORCODE_META_DATA_GENERATE_NEW_VERSION_LOCK_NOT_FOUND = 9203;  // 查找generate_new_version_lock(META)失败
const i32 ERRORCODE_DATA_NOT_DIRTY = 9204;  // 没有脏数据，不触发生成新版本数据(只添加领域不添加错误码，不会产生脏数据)
const i32 ERRORCODE_GENERATE_NEW_VERSION_LOCK_VALID = 9205;   // 生成新版本锁被锁住，需要等锁释放后获取才能执行操作
const i32 ERRORCODE_DOMAIN_NAME_ALREADY_EXIST = 9206;   // 领域名已存在
const i32 ERRORCODE_DOMAIN_NAME_NOT_EXIST = 9207;   // 领域名不存在
const i32 ERRORCODE_ERRORCODE_ITEM_ALREADY_EXIST = 9206;   // 错误码项已存在
const i32 ERRORCODE_ERRORCODE_ITEM_NOT_EXIST = 9207;   // 错误码项不存在
const i32 ERRORCODE_DATA_VERSION_DOUBLE_MD5_CHECK_FAIL = 9208;   // 版本数据MD5校验失败