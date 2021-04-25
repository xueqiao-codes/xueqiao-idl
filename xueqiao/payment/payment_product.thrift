/**
  * 商品列表数据类型
  */

namespace java com.longsheng.xueqiao.payment.product.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

enum ProductType {
	XCOIN = 0,					// 雪橇币
	BASIC_SPEC = 1,				// 基本型配置
	COMMON_SPEC= 2,				// 通用型配置
	ENHANCEMENT_SPEC = 3,		// 增强型配置
}

// 产品目的
enum ProductPurpose{
	NEW = 0,			// 新建规格
	UPGRADE = 1,		// 规格升级
	RECHARGE_XCOIN = 2,	// 充值雪橇币
	RECHARGE_TIME = 3,	// 充值时长
	PERSONAL_NEW = 4,			// 新建个人版云服务
	PERSONAL_RECHARGE_TIME = 5, // 个人版云服务续费
}

/**
  * 雪橇平台支持的支付币种
  */
enum CurrencyType {
	XCOIN = 0,	// 默认雪橇币
	RMB = 1,	// 人民币
}

enum ProductStatus {
	VALID = 0,		// 正常生效使用中
	INVALID = 1,	// 已失效
}

/**
  * 商品对应的操作
  */
enum Operation{
	NONE = 0,			// 不做操作
	ALLOCATE_SPEC = 1,	// 分配机器配置
	UPGRADE_SPEC = 2,	// 升级配置
	ALLOCATE_PERSONAL_USER_HOSTING_SERVICE = 3, // 分配个人用户托管服务
}

struct Product {
	1:optional i32 productId;
	2:optional ProductType type;
	3:optional string name;
	4:optional string description;
	5:optional i32 inventoryQuantity;				// 库存数量
	6:optional double price;						// 使用对应货币的价格
	7:optional CurrencyType currencyType;
	8:optional string imageCodes;
	9:optional ProductStatus status;
	10:optional map<string,string> extendProperties; // 商品的扩展属性
	11:optional bool needOperator;					// 是否需要操作员介入
	12:optional Operation operation;
	13:optional ProductPurpose purpose;
	14:optional ProductType purposeType;			// 目标规格

	// 商品购买效果对应的增量
	31:optional double xCoinIncrement;				// 购买该商品时的雪橇币增量
	32:optional i64 timeIncrement; 					// 购买该商品时的时长增量

	20:optional i64 createTimestamp;
	21:optional i64 lastModifyTimestamp;
}

struct ReqProductOption{
	1:optional set<i32> productIds;
	2:optional ProductType type;
	3:optional ProductStatus status;
	4:optional CurrencyType currencyType;
	5:optional page.IndexedPageOption pageOption;
	6:optional ProductPurpose purpose;
}

struct ProductPage{
	1:optional i32 total;
	2:optional list<Product> page;
}