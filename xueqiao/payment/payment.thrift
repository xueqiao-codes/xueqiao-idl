namespace java com.longsheng.xueqiao.payment.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "payment_product.thrift"

enum PayType {
	INNER = 0, // 雪橇内部使用雪橇币支付
	ALI_PAY = 1, // 支付宝
	WECHAT_PAY = 2, // 微信支付
}

enum OrderStatus {
	CREATED = 0,			// 订单创建,等待支付
	PAY_SUCCESS = 10,		// 订单支付成功
	SYSTEM_PROCESSED = 20,	// 系统处理完成
	MANUAL_PROCESSING = 30,	// 人工介入处理中
	SUCCESS = 40,			// 订单完成
	
	CANCELLED = 50,			// 订单已取消
	REMOVED = 53,			// 订单已删除
	EXPIRED = 56,			// 过期未支付
}

// 订单来源
enum OrderSource{
	SITE = 0,
}

struct Order{
	1:optional i32 orderId;
	2:optional OrderSource source;
	3:optional i32 productId;
	4:optional i32 companyId;
	5:optional i32 companyGroupId;
	6:optional string productName;
	7:optional string productDescription;
	8:optional i32 productQuantity;
	9:optional double price;
	10:optional payment_product.CurrencyType currencyType;
	11:optional double totalAmount;
	12:optional PayType payType;
	13:optional string thirdPartyOrderNo;
	14:optional OrderStatus status;
	15:optional string tradeInfo;
	16:optional bool needOperator;
	17:optional string operator;
	18:optional payment_product.Operation operation;
	
	19:optional string companyGroupName;
	20:optional string extraInfo;

	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct OrderFlow{
	1:optional i32 flowId;
	2:optional i32 orderId;
	3:optional OrderStatus status;
	4:optional string description;
	5:optional Order order;

	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct OrderFlowPage{
	1:optional i32 total;
	2:optional list<OrderFlow> page;
}

struct ReqOrderFlowOption{
	1:optional i32 orderId;
	2:optional i32 flowId;
	5:optional page.IndexedPageOption pageOption;
}

struct OrderPage{
	1:optional i32 total;
	2:optional list<Order> page;
}

struct ReqOrderOption{
	1:optional set<i32> orderIds;
	2:optional set<i32> productIds;
	3:optional set<i32> companyIds;
	4:optional string thirdPartyOrderNo;
	5:optional OrderStatus status;
	6:optional PayType payType;
	7:optional i32 groupId;
	10:optional page.IndexedPageOption pageOption;
}

struct PurchaseHistory{
	1:optional i32 historyId;
	2:optional i32 productId;
	3:optional string productName;
	4:optional i32 orderId;
	5:optional double totalAmount;
	6:optional payment_product.CurrencyType currencyType;
	7:optional i32 companyId;
	8:optional double newXCoinBalance;
	9:optional i32 companyGroupId;
	10:optional i64 newExpiredTimestamp;

	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct PurchaseHistoryPage{
	1:optional i32 total;
	2:optional list<PurchaseHistory> page;
}

struct ReqPurchaseHistoryOption{
	1:optional i32 companyId;
	2:optional i32 companyGroupId;
	3:optional i32 productId;
	4:optional i32 historyId;
	5:optional page.IndexedPageOption pageOption;
}

struct CompanyGroupSpec{
	1:optional i32 companyId;
	2:optional i32 groupId;
	3:optional i64 expiredTimestamp;
	4:optional payment_product.ProductType productType;
	9:optional i64 createTimestamp;
	10:optional i64 lastModifyTimestamp;
}

struct CompanyGroupSpecPage{
	1:optional i32 total;
	2:optional list<CompanyGroupSpec> page;
}

struct ReqCompanyGroupSpecOption{
	1:optional set<i32> companyIds;
	2:optional i32 groupId;
	3:optional payment_product.ProductType productType;
	5:optional page.IndexedPageOption pageOption;
}

struct CompanyBalance{
	1:optional i32 companyId;
	2:optional double xCoinBalance;
	3:optional list<CompanyGroupSpec> groupSpecs;

	30:optional i64 createTimestamp;
	31:optional i64 lastModifyTimestamp;
}

struct CompanyBalancePage{
	1:optional i32 total;
	2:optional list<CompanyBalance> page;
}

struct ReqCompanyBalanceOption{
	1:optional set<i32> companyIds;
	5:optional page.IndexedPageOption pageOption;
}

struct PayOrderInfo{
	1:optional i32 orderId;					// 雪橇的订单id (passback)
	2:optional PayType payType;				// 根据支付api指定
	3:optional string thirdPartyOrderNo;	// 第三方支付的订单号
	4:optional double totalAmount;			// 总价
	5:optional string tradeInfo;			// 第三方回调的所有信息
	6:optional i32 productId;				// 商品id (passback)
	7:optional i32 quantity;				// 商品数量 (passback)
}


struct CheckPrePayResp{
	1:optional bool valid;
	2:optional Order order;
	3:optional comm.ErrorInfo err;
}

struct OperateOrderInfo{
	1:optional i32 orderId;
	2:optional string operator;
	3:optional OrderStatus status;
}

// 订单过期时间
const i64 ORDER_EXPIRED_TIME_MS = 3600000;

enum PaymentErrorCode {
	ORDER_HAS_FINISHED = 1001, // 订单已经结束
	ORDER_HAS_PAID = 1002, 		// 订单已经支付
	FINISH_ORDER_FAIL = 1003, // 完成订单失败，可能由于支付要素不符
	PRODUCT_NOT_FOUND = 1004, // 商品ID不存在
	TOTAL_AMOUNT_NOT_MATCH = 1005, // 总金额不相符
	PAY_TYPE_NOT_FOUND = 1006, // 支付类型不存在
	PRODUCT_PAY_TYPE_ERROR = 1007, // 商品的支付类型错误
	TRADE_INFO_NOT_MATCH = 1008, // 交易信息不相符，可能是product_id或者quantity不一致
	XCOIN_BALANCE_NOT_ENOUGH = 1009, // 雪橇币不足
	ORDER_EXPIRED = 1010,	// 订单已过期
	PRODUCT_INVALID = 1011,		// 商品已失效
	ORDER_NOT_FOUND = 1012,		// 订单不存在
	PRODUCT_INVENTORY_NOT_ENOUGH = 1013, 	//商品库存不够
	UNKNOWN_ORDER_STATUS = 1014,		//未知的订单状态
	PRODUCT_TYPE_NOT_MATCH = 1015, 		//商品类型不匹配（例如通用型的服务，购买了基本型的续费方式)
	COMPANY_GROUP_NAME_EXIST = 1020,	// 公司组名已存在
	THRID_PARTY_TRADE_INFO_EXIST = 1021,		// 第三方支付信息已经存在
	
	ORDER_NOT_PAID = 1030,					// 订单未支付
	ORDER_MANUAL_PROCESSING = 1031,			// 订单处于人工介入处理阶段
	ORDER_REMOVED = 1302,					// 订单已被移除
	ORDER_CANCELLED = 1303,					// 订单已取消
	ORDER_HAS_SYSTEM_PROCESSED = 1304, 		// 系统已经处理过订单
}