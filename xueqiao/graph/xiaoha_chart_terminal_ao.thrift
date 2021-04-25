/**
  * 小哈图的投研图表的客户端接口服务
  */
namespace * xueqiao.graph.xiaoha.chart.terminal.ao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "xiaoha_chart.thrift"
include "../personal_user/personal_user.thrift"

/**
  * 登陆信息
  */
struct XiaohaChartLandingInfo {
    1:optional i64 personalUserId;
    2:optional string token;
}

struct LoginReq{
	1:optional string tel;
	2:optional string password;
}

struct SignUpReq{
	1:optional string tel;
	2:optional string verifyCode;
}

/**
  *  雪橇app的用户Session
  */
struct XueQiaoAppSession {
	1:optional i64 machineId; 		 // 托管机用于关联的ID
    2:optional i32 subUserId;        // 托管机子用户ID
    3:optional string token;         // 唯一的验证的Token
}

enum LinkState{
	UN_LINKED = 0,
	LINKED = 1,
}

enum XiaohaChartTerminalError{
	SESSION_ERROR = 3000,
	SESSION_TIMEOUT = 3001,
	SESSION_DIFFERENT = 3002,
	LOGIN_TEL_NOT_FOUND = 3003,		// 电话号码不存在
	VERIFY_CODE_ERROR = 3004,		// 验证码错误
}

/**
  * 此对外接口需要统一错误码信息
  * 使用ERROR CODE 范围区分不同服务的错误码信息：
  * personal_user_dao : 1000 - 1999
  * xiaoha_chart_dao : 2000 - 2999
  * token : 3000-3999
  */


service(903) XiaohaChartTerminalAo{
	
	/**
	  * 登录
	  */
	XiaohaChartLandingInfo 1:login(1:comm.PlatformArgs platformArgs, 2:LoginReq loginReq) throws (1:comm.ErrorInfo err);

	void 2:logout(1:comm.PlatformArgs platformArgs, 2:XiaohaChartLandingInfo landingInfo)throws (1:comm.ErrorInfo err);

	/**
	  * 通过雪橇app登录信息授权
	  */
	XiaohaChartLandingInfo 3:authorizeXueQiaoApp(1:comm.PlatformArgs platformArgs, 2:XueQiaoAppSession appSession) throws (1:comm.ErrorInfo err);

	XiaohaChartLandingInfo 4:signUp(1:comm.PlatformArgs platformArgs, 2:SignUpReq signUpReq)throws (1:comm.ErrorInfo err);

	void 5:sendVerifyCode(1:comm.PlatformArgs platformArgs, 2:string tel)throws (1:comm.ErrorInfo err);

	/**
	  * 查询小哈图表文件夹
	  */
	xiaoha_chart.ChartFolderPage 10:reqChartFolder(1:comm.PlatformArgs platformArgs, 3:xiaoha_chart.ReqChartFolderOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 查询图表
	  */
	xiaoha_chart.ChartPage 11:reqChart(1:comm.PlatformArgs platformArgs, 3:xiaoha_chart.ReqChartOption option, 4:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 添加个人用户的收藏夹
	  */
	personal_user.FavoriteFolder 20:addFavoriteFolder(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:personal_user.FavoriteFolder favoriteFolder) throws (1:comm.ErrorInfo err);

	list<personal_user.FavoriteFolder> 21:reqFavoriteFolder(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:personal_user.ReqFavoriteFolderOption option) throws (1:comm.ErrorInfo err);

	void 22:removeFavoriteFolder(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:i64 folderId) throws (1:comm.ErrorInfo err);

	void 23:renameFavoriteFolder(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:i64 folderId, 4:string newName) throws (1:comm.ErrorInfo err);

	/**
	  * 移动个人用户的收藏文件夹
	  */
	void 24:moveFavoriteFolder(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:i64 folderId, 4:i64 parentFolderId) throws (1:comm.ErrorInfo err);

	/**
	  * 添加个人用户的图表收藏
	  */
	personal_user.FavoriteChart 25:addFavoriteChart(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:personal_user.FavoriteChart favoriteChart) throws (1:comm.ErrorInfo err);

	list<personal_user.FavoriteChart> 26:reqFavoriteChart(1:comm.PlatformArgs platformArgs,2:XiaohaChartLandingInfo landingInfo, 3:personal_user.ReqFavoriteChartOption option) throws (1:comm.ErrorInfo err);

	void 27:removeFavoriteChart(1:comm.PlatformArgs platformArgs, 2:XiaohaChartLandingInfo landingInfo, 3:i64 favoriteChartId) throws (1:comm.ErrorInfo err);

	/**
	  * 移动个人用户的图表收藏
	  */
	void 28:moveFavoriteChart(1:comm.PlatformArgs platformArgs, 2:XiaohaChartLandingInfo landingInfo, 3:i64 favoriteChartId, 4:i64 parentFolderId) throws (1:comm.ErrorInfo err);

	/**
	  * 关联已有账号
	  */
	void 29:linkExistAccount(1:comm.PlatformArgs platformArgs, 2:XiaohaChartLandingInfo landingInfo, 3:string tel, 4:string verifyCode) throws (1:comm.ErrorInfo err);

	LinkState 30:getLinkState(1:comm.PlatformArgs platformArgs, 2:XiaohaChartLandingInfo landingInfo) throws (1:comm.ErrorInfo err);
}