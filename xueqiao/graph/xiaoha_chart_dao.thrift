/**
  * 小哈图的投研图表在雪橇层面的数据存取dao
  */
namespace java xueqiao.graph.xiaoha.chart.dao.thriftapi
namespace csharp xueqiao.graph.xiaoha.chart.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "xiaoha_chart.thrift"

service(900) XiaohaChartDao{
	
	/**
	  * 添加图表信息记录
	  */
	void 1:addChart(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.Chart chart) throws (1:comm.ErrorInfo err);

	/**
	  * 更新图表信息记录
	  */
	void 2:updateChart(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.Chart chart) throws (1:comm.ErrorInfo err);

	xiaoha_chart.ChartPage 3:reqChart(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqChartOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 添加目录结构信息记录
	  */
	void 4:addChartFolder(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ChartFolder chartFolder) throws (1:comm.ErrorInfo err);

	/**
	  * 更新目录结构信息记录
	  */
	void 5:updateChartFolder(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ChartFolder chartFolder) throws (1:comm.ErrorInfo err);

	xiaoha_chart.ChartFolderPage 6:reqChartFolder(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqChartFolderOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	void 7:addTag(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.XueQiaoTag tag) throws (1:comm.ErrorInfo err);

	void 8:removeTag(1:comm.PlatformArgs platformArgs, 2:i64 tagId) throws (1:comm.ErrorInfo err);

	list<xiaoha_chart.XueQiaoTag> 9:reqTag(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqTagOption option) throws (1:comm.ErrorInfo err);

	void 10:addPlate(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.XueQiaoPlate plate) throws (1:comm.ErrorInfo err);

	list<xiaoha_chart.XueQiaoPlate> 11:reqPlate(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	void 12:updateTag(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.XueQiaoTag tag) throws (1:comm.ErrorInfo err);

	xiaoha_chart.XueQiaoTagPage 14:reqTagPage(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqTagOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}