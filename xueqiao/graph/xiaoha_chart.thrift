/**
  * 小哈图的投研图表
  */
namespace java xueqiao.graph.xiaoha.chart.thriftapi
namespace csharp xueqiao.graph.xiaoha.chart.thriftapi

/**
  * 图表类型
  */
enum ChartType{
	// 历年期货价格 跨期 跨品种 远期曲线
	HISTORICAL_DATA = 0;
	SPREAD_MONTH = 1;
	SPREAD_COMMODITY = 2;
	FORWARD_CURVE = 3;
}

/**
  * 图表状态
  */
enum ChartState{
	ENABLE = 0;	// 启用
	DISABLE =1;	// 禁用
}

struct Chart{
	1:optional i64 chartId;
	2:optional string xiaohaObjId;
	3:optional string chartName;
	4:optional string shareKey;
	5:optional string url;
	6:optional i64 parentFolderId;
	7:optional set<string> tags;
	8:optional i64 createTimestamp;
	9:optional i64 lastModifyTimestamp;
	10:optional ChartType chartType;
	11:optional ChartState chartState;
	12:optional string commodityName;	// 商品
	13:optional string plate;			// 板块
}

struct ChartFolder{
	1:optional i64 folderId;
	2:optional string xiaohaObjId;
	3:optional string folderName;
	4:optional i64 parentFolderId;
	6:optional set<string> tags;
	7:optional i64 createTimestamp;
	8:optional i64 lastModifyTimestamp;
}

struct ReqChartOption{
	1:optional set<i64> chartIds;
	2:optional string xiaohaObjId;
	3:optional i64 parentFolderId;
	4:optional ChartType chartType;
	5:optional string commodityName;	// 商品
	6:optional string plate;			// 板块
	9:optional ChartState state;		// 默认查询 enable
	
	// 模糊匹配
	7:optional string name;
	8:optional set<string> keyWords;
}

struct ReqChartFolderOption{
	1:optional set<i64> chartFolderIds;
	2:optional string xiaohaObjId;
	3:optional i64 parentFolderId;
	4:optional string name;
	
	// 模糊匹配
	5:optional set<string> keyWords;
}

struct ChartPage{
	1:optional i32 total;
	2:optional list<Chart> page;
}

struct ChartFolderPage{
	1:optional i32 total;
	2:optional list<ChartFolder> page;
}

struct XueQiaoTag{
	1:optional i64 tagId;
	2:optional string cnName;
	4:optional i64 createTimestamp;
	5:optional i64 lastModifyTimestamp;
}

struct ReqTagOption{
	1:optional i64 tagId;
	2:optional string cnName;
	3:optional string namePartical;
}

struct XueQiaoPlate{
	1:optional i64 plateId;
	2:optional string cnName;
	4:optional i64 createTimestamp;
	5:optional i64 lastModifyTimestamp;
}

struct XueQiaoTagPage{
	1:optional i32 total;
	2:optional list<XueQiaoTag> page;
}

enum XiaoHaChartErrorCode{
	TAG_NOT_FOUND = 2000,	// 标签不存在
	TAG_EXISTS = 2001,		// 标签已存在
	CHART_NOT_FOUND = 2003,		// 图表不存在
}