/**
  * 雪橇个人用户的访问dao
  */
namespace * xueqiao.personal.user.dao.thriftapi


include "../../comm.thrift"
include "../../page.thrift"
include "personal_user.thrift"

service(902) PersonalUserDao{
	
	/**
	  * 添加个人用户记录
	  */
	i64 1:addPersonalUser(1:comm.PlatformArgs platformArgs, 2:personal_user.PersonalUserEntry personalUserEntry) throws (1:comm.ErrorInfo err);

	void 2:updatePersonalUser(1:comm.PlatformArgs platformArgs, 2:personal_user.PersonalUserEntry personalUserEntry) throws (1:comm.ErrorInfo err);

	list<personal_user.PersonalUserEntry> 3:reqPersonalUser(1:comm.PlatformArgs platformArgs, 2:personal_user.ReqPersonalUserOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 添加个人用户与公司用户的关联记录
	  */
	void 4:addUserRelateInfo(1:comm.PlatformArgs platformArgs, 2:personal_user.UserRelateInfo userRelateInfo) throws (1:comm.ErrorInfo err);

	list<personal_user.UserRelateInfo> 5:reqUserRelateInfo(1:comm.PlatformArgs platformArgs, 2:personal_user.ReqUserRelateInfoOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 添加个人用户的收藏夹
	  */
	i64 6:addFavoriteFolder(1:comm.PlatformArgs platformArgs, 2:personal_user.FavoriteFolder favoriteFolder) throws (1:comm.ErrorInfo err);

	void 7:updateFavoriteFolder(1:comm.PlatformArgs platformArgs, 2:personal_user.FavoriteFolder favoriteFolder) throws (1:comm.ErrorInfo err);

	list<personal_user.FavoriteFolder> 8:reqFavoriteFolder(1:comm.PlatformArgs platformArgs, 2:personal_user.ReqFavoriteFolderOption option) throws (1:comm.ErrorInfo err);

	void 9:removeFavoriteFolder(1:comm.PlatformArgs platformArgs, 2:i64 folderId) throws (1:comm.ErrorInfo err);

	/**
	  * 添加个人用户的图表收藏
	  */
	i64 10:addFavoriteChart(1:comm.PlatformArgs platformArgs, 2:personal_user.FavoriteChart favoriteChart) throws (1:comm.ErrorInfo err);

	void 11:updateFavoriteChart(1:comm.PlatformArgs platformArgs, 2:personal_user.FavoriteChart favoriteChart) throws (1:comm.ErrorInfo err);

	list<personal_user.FavoriteChart> 12:reqFavoriteChart(1:comm.PlatformArgs platformArgs, 2:personal_user.ReqFavoriteChartOption option) throws (1:comm.ErrorInfo err);

	void 13:removeFavoriteChart(1:comm.PlatformArgs platformArgs, 2:i64 favoriteChartId) throws (1:comm.ErrorInfo err);

	/**
	  * 合并个人用户与公司用户的关联记录(用户先关联了默认新个人用户, 之后再导入已有个人用户信息, 合并收藏夹)
	  */
	void 14:mergeUserRelateInfo(1:comm.PlatformArgs platformArgs, 2:i64 companyUserRelatePersonalUserId, 3:i64 forMergePersonalUserId) throws (1:comm.ErrorInfo err);

	bool 15:isUserRelate(1:comm.PlatformArgs platformArgs, 2:i64 companyUserRelatePersonalUserId) throws (1:comm.ErrorInfo err);
}