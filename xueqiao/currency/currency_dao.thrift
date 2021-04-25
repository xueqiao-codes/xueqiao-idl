namespace java com.longsheng.xueqiao.currency.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "currency.thrift"

service(254) CurrencyDao {

	/**
	  * 添加sled_currency记录
	  * 返回Fsled_currency_id
	  */
	i32 1:addCurrency(1:comm.PlatformArgs platformArgs, 2:currency.Currency currency) throws (1:comm.ErrorInfo err);

	/**
	  * 更新sled_currency记录
	  * 返回Fsled_currency_id
	  */
	i32 2:updateCurrency(1:comm.PlatformArgs platformArgs, 2:currency.Currency currency) throws (1:comm.ErrorInfo err);

	/**
	  * 查询sled_currency记录
	  * 返回sled_currency列表
	  */
	currency.CurrencyPage 3:reqCurrency(1:comm.PlatformArgs platformArgs, 2:currency.ReqCurrencyOption currencyOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 查询sled_exchange_rate记录
	  * 返回sled_exchange_rate列表
	  */
	currency.ExchangeRatePage 10:reqExchangeRate(1:comm.PlatformArgs platformArgs, 2:currency.ReqExchangeRateOption exchangeRateOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);
	
	/**
	  * 更新sled_exchange_rate记录
	  * 返回Fsled_exchange_rate_id
	  */
	i32 11:updateExchangeRateValue(1:comm.PlatformArgs platformArgs, 2:currency.ExchangeRate exchangeRate) throws (1:comm.ErrorInfo err);

	
	/**
	  * 同步到Zookeeper线上环境
	  * 
	  */
	void 12:syncExchangeRateToOnline(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
}