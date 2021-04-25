namespace java com.longsheng.xueqiao.currency.thriftapi

include "../../comm.thrift"

struct Currency{
	2:optional string currencyCode;						//货币编号
	3:optional string enName;							//英文名称
	4:optional string cnName;							//中文名称
	5:optional string symbol;							//货币符号
	6:optional bool isBaseCurrency;						//是否为基准货币：0，否；1，是
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct CurrencyPage{
	1:optional i32 total;
	2:optional list<Currency> page;
}

struct ExchangeRate{
	2:optional string name;								//汇率名称
	3:optional string baseCurrency;						//基准货币
	4:optional string targetCurrency;					//兑换目标货币
	5:optional double exchangeRate;						//汇率值
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct ExchangeRatePage{
	1:optional i32 total;
	2:optional list<ExchangeRate> page;
}

struct ReqCurrencyOption{
	1:optional bool isBaseCurrency;
	2:optional string currencyCode;
	3:optional string enName;
	4:optional string cnName;
	5:optional string symbol;
}

struct ReqExchangeRateOption{
	1:optional string baseCurrency;
	2:optional string targetCurrency;
}

struct ExchangeRateHistory{
	1:optional i64 historyId;
	2:optional string currencyCode;
	3:optional map<string,double> exchangeRate;			// 基币与对应货币的汇率
	40:optional i64 createTimestamp;					// 创建时间
	41:optional i64 lastModityTimestamp;				// 最后修改时间
}

struct ExchangeRateHistoryPage{
	1:optional i32 total;
	2:optional list<ExchangeRateHistory> page;
}

struct ReqHistoryOption{
	1:optional i64 historyId;
	2:optional string currency;
}

