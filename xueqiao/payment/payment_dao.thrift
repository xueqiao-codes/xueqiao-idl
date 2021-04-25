/**
  * 商品管理dao
  */

namespace java com.longsheng.xueqiao.payment.dao.thriftapi

include "../../comm.thrift"
include "../../page.thrift"
include "payment_product.thrift"
include "payment.thrift"
include "company_balance_alteration.thrift"

/**
  * 支付系统dao
  */
service(351) PaymentDao {
	/**
	  * 查询商品
	  */
	payment_product.ProductPage 1:reqProduct(
		1:comm.PlatformArgs platformArgs, 2: payment_product.ReqProductOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 添加商品
	  */
	void 2:addProduct(
		1:comm.PlatformArgs platformArgs, 2: payment_product.Product product) throws (1:comm.ErrorInfo err);

	/**
	  * 更新商品
	  */
	void 3:updateProduct(
		1:comm.PlatformArgs platformArgs, 2: payment_product.Product product) throws (1:comm.ErrorInfo err);

	/**
	  * 购买产品
	  * 如果购买的产品的支付类型是XCOIN, 会根据余额自动完成支付
	  * 如果购买的产品的支付类型是RMB, 订单状态会变成等待支付
	  * return: 订单信息
	  */
	payment.Order 4:buyProduct(1:comm.PlatformArgs platformArgs, 2:payment.Order order)throws (1:comm.ErrorInfo err);

	/**
	  * 用于给支付接口的回调
	  * @throw RmbOrderHadFinished 如果订单状态不是Created
	  * @throw VerifySignFailed 如果验签失败
	  * @throw FinishRmbOrderFailed 由于支付要素不符, 完成订单失败
	  */
	payment.Order 5:payOrder(
		1:comm.PlatformArgs platformArgs, 2: payment.PayOrderInfo payOrderInfo) throws (1:comm.ErrorInfo err);

	/**
	  * 查询订单
	  */
	payment.OrderPage 6:reqOrder(
		1:comm.PlatformArgs platformArgs, 2: payment.ReqOrderOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 查询订单状态变更流程
	  */
	payment.OrderFlowPage 7:reqOrderFlow(
		1:comm.PlatformArgs platformArgs, 2: payment.ReqOrderFlowOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 查询公司购买的商品
	  */
	payment.PurchaseHistoryPage 8:reqPurchaseHistory(
		1:comm.PlatformArgs platformArgs, 2: payment.ReqPurchaseHistoryOption option) throws (1:comm.ErrorInfo err);

	/**
	  * 查询公司XCOIN余额
	  */
	payment.CompanyBalancePage 9:reqCompanyBalance(
		1:comm.PlatformArgs platformArgs, 2: payment.ReqCompanyBalanceOption option) throws (1:comm.ErrorInfo err);

	payment.CheckPrePayResp 10:checkOrderPrePay(
		1:comm.PlatformArgs platformArgs, 2:payment.PayOrderInfo payOrderInfo) throws (1:comm.ErrorInfo err);

	payment.Order 11:operateOrder(
		1:comm.PlatformArgs platformArgs, 2: payment.OperateOrderInfo info) throws (1:comm.ErrorInfo err);
	
	void 12:setNewMachineOrderGroupId(1:comm.PlatformArgs platformArgs, 2: i32 orderId, 3: i32 companyGroupId) throws (1:comm.ErrorInfo err);

	/**
	  * 查询公司组配置
	  */
	payment.CompanyGroupSpecPage 13: reqCompanyGroupSpec(
		1:comm.PlatformArgs platformArgs, 2: payment.ReqCompanyGroupSpecOption option) throws (1:comm.ErrorInfo err);
	
	/**
	  * 雪橇币支付（扣除雪橇币）
	  */
	void 15:xcoinPay(
		1:comm.PlatformArgs platformArgs, 2: payment.PayOrderInfo payOrderInfo) throws (1:comm.ErrorInfo err);
	
	/**
	  * 变更公司账户雪橇币金额
	  */
	void 20:alterCompanyBalance(
		1:comm.PlatformArgs platformArgs, 2: company_balance_alteration.BalanceAlteration balanceAlteration) throws (1:comm.ErrorInfo err);

	/**
	  * 修改公司账户雪橇币金额变更记录
	  */
	void 21:updateCompanyBalanceAlteration(
		1:comm.PlatformArgs platformArgs, 2: company_balance_alteration.BalanceAlteration balanceAlteration) throws (1:comm.ErrorInfo err);

	/**
	  * 查询公司账户雪橇币金额变更记录
	  */
	company_balance_alteration.BalanceAlterationPage 22:reqCompanyBalanceAlteration(
		1:comm.PlatformArgs platformArgs, 2: company_balance_alteration.ReqBalanceAlterationOption reqOption, 3:page.IndexedPageOption pageOption) throws (1:comm.ErrorInfo err);

	/**
	  * 删除无效订单
	  */
	void 23:removeInvalidOrder(
		1:comm.PlatformArgs platformArgs, 2:i32 orderId) throws (1:comm.ErrorInfo err);
}