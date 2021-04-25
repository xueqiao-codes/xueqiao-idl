/**
  * 保证金和手续费
  */
namespace * xueqiao.trade.hosting.position.fee.thriftapi

include "../../comm.thrift"
include "../../page.thrift"

// 费率计算方式
enum FeeCalculateType {
    FR_DELTA_ADD = 0,  // 在默认费率基础上加收
    FR_DELTA_SUB = 1,  // 在默认费率基础上优惠
}

// 上手数据类型
enum UpsideDataType {
	UDT_NO_DATA = 0,    // 没有从上手获取值
	UDT_COMMODITY = 1,  // 商品层级的数据
	UDT_CONTRACT = 2,   // 合约层级的数据
}

// 上手数据类型
enum XQSettingsDataType {
	SDT_NO_DATA = 0,     // 没有设置偏差值（则为0）
	SDT_GENERAL = 1,     // 通用的偏差值
	SDT_COMMODITY = 2,   // 商品层级的偏差值
}

// 保证金
struct MarginInfo {
	1:optional double longMarginRatioByMoney;    // 按金额多仓保证金
	2:optional double longMarginRatioByVolume;   // 按手数多仓保证金
	3:optional double shortMarginRatioByMoney;   // 按金额空仓保证金
	4:optional double shortMarginRatioByVolume;  // 按手数空仓保证金
	5:optional string currency;                  // 币种
	6:optional string currencyGroup;             // 币种组
}

// 手续费
struct CommissionInfo {
	1:optional double openRatioByMoney;              // 按金额开仓手续费费率
	2:optional double openRatioByVolume;             // 按手数开仓手续费费率
	3:optional double closeRatioByMoney;             // 按金额平昨手续费费率
	4:optional double closeRatioByVolume;            // 按手数平昨手续费费率
	5:optional double closeTodayRatioByMoney;        // 按金额平今手续费费率
	6:optional double closeTodayRatioByVolume;       // 按手数平今手续费费率
	7:optional string currency;                      // 币种
	8:optional string currencyGroup;                 // 币种组
}

// 雪橇基础保证金费率设置项
struct XQGeneralMarginSettings {
	1:optional i64 subAccountId;
	4:optional FeeCalculateType type;
	10:optional MarginInfo marginDelta;
	12:optional bool isSync;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}

// 雪橇基础手续费率设置项
struct XQGeneralCommissionSettings {
	1:optional i64 subAccountId;
	4:optional FeeCalculateType type;
	10:optional CommissionInfo commissionDelta;
	12:optional bool isSync;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}

// 合约信息
struct CommodityInfo {
	1:optional string exchangeMic;
	3:optional string commodityEngAcronym;		// 商品英文简称
	4:optional string commodityCnAcronym;		// 商品中文简称
	5:optional string exchangeAcronym;			// 交易所英文简称
	6:optional string exchangeCnAcronym;		// 交易所中文简称
}

// 雪橇特殊保证金费率设置项
struct XQSpecMarginSettings {
	1:optional i64 subAccountId;
	2:optional i64 commodityId;
	3:optional CommodityInfo commodityInfo;
	5:optional FeeCalculateType type;
	10:optional MarginInfo marginDelta;
	12:optional bool isSync;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}

// 雪橇特殊手续费率设置项
struct XQSpecCommissionSettings {
	1:optional i64 subAccountId;
	2:optional i64 commodityId;
	3:optional CommodityInfo commodityInfo;
	5:optional FeeCalculateType type;
	10:optional CommissionInfo commissionDelta;
	12:optional bool isSync;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}

// 合约信息
struct ContractInfo {
	1:optional i64 tradeAccountId;
	2:optional i64 commodityId;
	3:optional string contractCode;
	4:optional i64 contractId;
	5:optional string exchangeMic;
	6:optional string contractEngName;			// 合约英文名称
	7:optional string contractCnName;			// 合约简体中文名称
	8:optional string commodityEngAcronym;		// 商品英文简称
	9:optional string commodityCnAcronym;		// 商品中文简称
	10:optional string exchangeAcronym;			// 交易所英文简称
	11:optional string exchangeCnAcronym;		// 交易所中文简称
}

// 上手合约保证金费率 (每个期货公司收取的保证金和手续费都不一样)
struct UpsideContractMargin {
	1:optional i64 subAccountId;
	2:optional ContractInfo contractInfo;
	10:optional MarginInfo margin;
	11:optional UpsideDataType dataType;
	12:optional bool isSync;
	21:optional i64 lastmodifyTimestampMs;
}

// 上手合约手续费率 (每个期货公司收取的保证金和手续费都不一样)
struct UpsideContractCommission {
	1:optional i64 subAccountId;
	2:optional ContractInfo contractInfo;
	10:optional CommissionInfo commission;
	11:optional UpsideDataType dataType;
	12:optional bool isSync;
	21:optional i64 lastmodifyTimestampMs;
}

// 雪橇合约保证金费率
struct XQContractMargin {
	1:optional i64 subAccountId;
	2:optional ContractInfo contractInfo;
	10:optional MarginInfo margin;
	11:optional UpsideDataType dataType;
	12:optional XQSettingsDataType settingsDataType;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}

// 雪橇合约手续费率
struct XQContractCommission {
	1:optional i64 subAccountId;
	2:optional ContractInfo contractInfo;
	10:optional CommissionInfo commission;
	11:optional UpsideDataType dataType;
	12:optional XQSettingsDataType settingsDataType;
	20:optional i64 createTimestampMs;
	21:optional i64 lastmodifyTimestampMs;
}


// ------------------ page ------------------------------

struct XQSpecMarginSettingPage {
	1:optional i32 totalNum;
	2:optional list<XQSpecMarginSettings> XQSpecMarginSettingList;
}

struct XQSpecCommissionSettingPage {
	1:optional i32 totalNum;
	2:optional list<XQSpecCommissionSettings> XQSpecCommissionSettingList;
}

struct UpsideContractMarginPage {
	1:optional i32 totalNum;
	2:optional list<UpsideContractMargin> upsideContractMarginList;
}

struct UpsideContractCommissionPage {
	1:optional i32 totalNum;
	2:optional list<UpsideContractCommission> upsideContractCommissionList;
}

struct XQContractMarginPage {
	1:optional i32 totalNum;
	2:optional list<XQContractMargin> xqContractMarginList;
}

struct XQContractCommissionPage {
	1:optional i32 totalNum;
	2:optional list<XQContractCommission> xqContractCommissionList;
}

struct PositionFee {
	1:optional i64 subAccountId;
	2:optional i64 contractId;
	10:optional MarginInfo margin;
	11:optional CommissionInfo commission;
}

// ----------------------- query options -------------------------
struct QueryXQSpecSettingOptions {
	1:optional i64 subAccountId;
	2:optional string exchangeMic;
	3:optional set<i64> commodityIds;
	4:optional FeeCalculateType type;
}

struct QueryUpsidePFeeOptions {
	1:optional i64 subAccountId;
	2:optional string exchangeMic;
	3:optional i64 commodityId;
	4:optional string contractCode;
}

struct QueryXQPFeeOptions {
	1:optional i64 subAccountId;
	2:optional string exchangeMic;
	3:optional i64 commodityId;
	4:optional string contractCode;
}


// ------------------------ service ------------------------------

service(722) TradeHostingPositionFee {
	void 1:clearAll(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
	
	// 设置基础保证金费率设置项
	void 2:setGeneralMarginSetting(1:comm.PlatformArgs platformArgs, 2:XQGeneralMarginSettings marginSettings) throws (1:comm.ErrorInfo err);
	
	// 设置基础手续费费率设置项
	void 3:setGeneralCommissionSetting(1:comm.PlatformArgs platformArgs, 2:XQGeneralCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);
	
	// 添加特殊保证金费率设置项
	void 4:addSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:XQSpecMarginSettings marginSettings) throws (1:comm.ErrorInfo err);
	
	// 添加特殊手续费费率设置项
	void 5:addSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:XQSpecCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);
	
	// 编辑特殊保证金费率设置项
	void 6:updateSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:XQSpecMarginSettings marginSettings) throws (1:comm.ErrorInfo err);
	
	// 编辑特殊手续费费率设置项
	void 7:updateSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:XQSpecCommissionSettings commissionSettings) throws (1:comm.ErrorInfo err);
	
	// 删除特殊保证金费率设置项
	void 8:deleteSpecMarginSetting(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:i64 commodityId) throws (1:comm.ErrorInfo err);
	
	// 删除特殊手续费费率设置项
	void 9:deleteSpecCommissionSetting(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:i64 commodityId) throws (1:comm.ErrorInfo err);
	
	//-----------------------------------------查询-----------------------------------------------
	// 查询基础保证金费率设置项
	XQGeneralMarginSettings 20:queryXQGeneralMarginSettings(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId) throws (1:comm.ErrorInfo err);
	
	// 查询基础手续费费率设置项
	XQGeneralCommissionSettings 21:queryXQGeneralCommissionSettings(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId) throws (1:comm.ErrorInfo err);
	
	// 查询特殊保证金费率设置页
	XQSpecMarginSettingPage 22:queryXQSpecMarginSettingPage(1:comm.PlatformArgs platformArgs, 2:QueryXQSpecSettingOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 查贸易特殊手续费费率设置页
	XQSpecCommissionSettingPage 23:queryXQSpecCommissionSettingPage(1:comm.PlatformArgs platformArgs, 2:QueryXQSpecSettingOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 查询上手保证金费率
	UpsideContractMarginPage 24:queryUpsideContractMarginPage(1:comm.PlatformArgs platformArgs, 2:QueryUpsidePFeeOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 查询上手手续费费率
	UpsideContractCommissionPage 25:queryUpsideContractCommissionPage(1:comm.PlatformArgs platformArgs, 2:QueryUpsidePFeeOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 查询特殊保证金费率页
	XQContractMarginPage 26:queryXQContractMarginPage(1:comm.PlatformArgs platformArgs, 2:QueryXQPFeeOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 查贸易特殊手续费费率页
	XQContractCommissionPage 27:queryXQContractCommissionPage(1:comm.PlatformArgs platformArgs, 2:QueryXQPFeeOptions queryOptions, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	// 按合约查询保证金和手续费
	PositionFee 28:queryPositionFee(1:comm.PlatformArgs platformArgs, 2:i64 subAccountId, 3:i64 contractId) throws (1:comm.ErrorInfo err);

}