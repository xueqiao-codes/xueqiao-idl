/**
  * 雪橇个人用户的数据类型
  */
namespace * xueqiao.personal.user.thriftapi

struct PersonalUserEntry{
	1:optional i64 userId;
	2:optional string tel;
	3:optional string password;
	4:optional i64 createTimestamp;
	5:optional i64 lastModifyTimestamp;
}

struct UserRelateInfo{
	1:optional i64 personalUserId;
	2:optional i64 companyId;
	3:optional i64 companyUserId;
	4:optional i64 createTimestamp;
	5:optional i64 lastModifyTimestamp;
	6:optional bool linked;
}

struct FavoriteFolder{
	1:optional i64 folderId;
	2:optional string folderName;
	3:optional i64 parentFolderId;
	4:optional i64 personalUserId;
}

struct FavoriteChart{
	1:optional i64 favoriteChartId;
	2:optional i64 xiaohaChartId;
	3:optional i64 parentFolderId;
	4:optional i64 personalUserId;
	5:optional string name;
}

struct ReqPersonalUserOption{
	1:optional set<i64> personalUserIds;
	2:optional string tel;
}

struct ReqFavoriteFolderOption{
	1:optional set<i64> folderIds;
	2:optional i64 personUserId;
	3:optional i64 parentFolderId;
}

struct ReqFavoriteChartOption{
	1:optional set<i64> favoriteChartIds;
	2:optional i64 personUserId;
	3:optional i64 parentFolderId;
	4:optional i64 xiaohaChartId;
}

struct ReqUserRelateInfoOption{
	1:optional i64 personUserId;
	2:optional i64 companyId;
	3:optional i64 companyUserId;
}

enum PersonalUserErrorCode{
	USER_EXISTS = 1000,
	USER_NOT_FOUND = 1001,
	PERSONAL_USER_RELATION_EXISTS = 1002,
	COMPANY_USER_RELATION_EXISTS = 1003,
	RELATION_NOT_FOUND = 1004,
	FAVORITE_FOLDER_NOT_FOUND = 1005,
	FAVORITE_CHART_NOT_FOUND = 1006,
	FAVORITE_CHART_EXISTS = 1007,
}