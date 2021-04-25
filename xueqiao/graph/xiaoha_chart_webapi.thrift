/**
  * 小哈图的投研图表在雪橇层面的数据存取dao
  */
namespace java xueqiao.graph.xiaoha.chart.webapi.thriftapi
namespace csharp xueqiao.graph.xiaoha.chart.webapi.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "xiaoha_chart.thrift"

struct OperateResult{
	1:optional bool success;
	2:optional i32 code;
	3:optional string message;
}

service(901) XiaohaChartWebapi{

	xiaoha_chart.ChartPage 1:reqChart(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqChartOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	OperateResult 2:updateChartTags(1:comm.PlatformArgs platformArgs, 2:i64 chartId, 3:set<string> tags) throws (1:comm.ErrorInfo err);

	OperateResult 3:updateChartState(1:comm.PlatformArgs platformArgs, 2:i64 chartId, 3:xiaoha_chart.ChartState state) throws (1:comm.ErrorInfo err);

	list<string> 4:reqTags(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	list<string> 5:reqPlates(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);

	OperateResult 6:removeTag(1:comm.PlatformArgs platformArgs, 2:i64 tagId) throws (1:comm.ErrorInfo err);

	OperateResult 7:updateTag(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.XueQiaoTag tag) throws (1:comm.ErrorInfo err);

	OperateResult 8:addTag(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.XueQiaoTag tag) throws (1:comm.ErrorInfo err);

	xiaoha_chart.XueQiaoTagPage 9:reqTagPage(1:comm.PlatformArgs platformArgs, 2:xiaoha_chart.ReqTagOption option, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
}