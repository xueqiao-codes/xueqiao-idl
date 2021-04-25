/**
  * 用于定义各种分页方式统一的IDL
  */
namespace java org.soldier.platform.page
namespace cpp  platform.page

/**
  * 索引从0开始，利用pageIndex和pageSize不断流转的分页方式
  */
struct IndexedPageOption {
	1:optional bool needTotalCount;
	2:optional i32 pageIndex;
	3:optional i32 pageSize;
}
