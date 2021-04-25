/**
  * 交易托管机的基础部分错误码定义
  */
namespace *  xueqiao.trade.hosting

enum TradeHostingBasicErrorCode {
    /**
      * 托管机操作相关的错误
      */
    MACHINEID_ERROR = 1000,                // 错误的操作机器ID
    HOSTING_HAS_ALREADY_INITED = 1001,      // 托管机已经初始化完成
    HOSTING_HAS_NOT_INITED = 1002,          // 托管机未初始化，无法使用
	HOSTING_MACHINE_NOT_FOUND = 1003,        // 找不到对应的托管机
	HOSTING_CLEARING = 1004,                // 托管机清理数据中
    
    /**
      * 用户相关的错误
      */
    ERROR_USER_ALREADY_EXISTED = 1500,      // 用户已经存在
    ERROR_USER_NOT_EXISTED = 1501,          // 用户不存在
    ERROR_USER_SESSION = 1502,              // 用户SESSION错误
    ERROR_USER_PASSWORD = 1503,             // 用户密码错误
    ERROR_USER_DISABLED = 1504,             // 用户被禁用
   
    
    /**
      * 子账户相关错误
      */
    ERROR_SUB_ACCOUNT_DUPLICATE_NAME = 1701, // 重复的子账户名称
    ERROR_SUB_ACCOUNT_OP_MONEY_DUPLICATE_TICKET = 1702, // 出入金重复票据，操作重复
    ERROR_SUB_ACCOUNT_RELATED_ITEM_NOT_EXIST = 1703,  // 子账户和子用户不存在关联 
    ERROR_SUB_ACCOUNT_NOT_EXISTED = 1704,  // 子账户不存在
    
    /**
      * 通用错误
      */
    USER_FORBIDDEN_ERROR = 2000,            // 用户无权限，操作被禁止
    ERROR_PARAMETER = 2001,                 // 参数错误， 值非法
    ERROR_OPERATION_FORBIDDEN = 2002,       // 当前操作被禁止
    
    /**
      * 组合图相关错误的定义
      */
    ERROR_COMPOSE_GRAPH_NOT_OWNER = 3000,          // 组合非拥有者操作
    ERROR_COMPOSE_GRAPH_CONTAINS_INVALID_CONTRACT = 3001, // 组合中包含非法的合约ID
    ERROR_COMPOSE_GRAPH_INVALID = 3002,            // 组合图描述不正确, 组合腿和公式不对等等情况
    ERROR_COMPOSE_GRAPH_NOT_EXISTED = 3003,        // 组合图不存在
    ERROR_COMPOSE_GRAPH_CONTAINS_EXCHANGE_COMB_CONTRACT = 3004, // 组合图中包含交易所组合合约，目前不支持
    ERROR_COMPOSE_GRAPH_TRADE_QUANTITY_GCD_NOT_ONE = 3005,  // 组合图中交易配比值最大公约数不为1
    ERROR_COMPOSE_GRAPH_TRADE_QUANTITY_LEGS_SHOULD_GE_TWO = 3006, // 组合图中至少需要两条腿具备订单配比
    
    ERROR_COMPOSE_VIEW_NOT_EXISTED = 3050,   // 组合视图不存在
    ERROR_COMPOSE_VIEW_SUBSCRIBE_TOO_MANY = 3056, // 订阅的组合行情过多
    
    /**
      * 配置系统的错误定义
      */
    ERROR_CONFIG_VERSION_LOW = 3100,   // 配置版本号过低
    ERROR_CONFIG_LOST = 3101,            // 配置内部原因导致丢失
    ERROR_CONFIG_SAME_CONTENT_MD5 = 3102,  // 配置内容具备和服务端版本相同的MD5值
    
    /**
      * 合约信息相关的错误
      */
    ERROR_CONTRACT_NOT_EXISTED = 3200, // 合约不存在
    ERROR_COMMODITY_NOT_EXISTED = 3201, // 商品不存在
    ERROR_CONTRACT_NOT_MATCH_MACHINE_RUNNING_MODE = 3202,  // 交易合约和运行模式不匹配
  
    
    /**
      * 以下为账号相关的错误
      */
    ERROR_DUPLICATE_TRADE_ACCOUNT = 3500,    // 重复的交易账号
    ERROR_TRADE_ACCOUNT_NOT_EXISTED = 3501,  // 交易账号不存在
    ERROR_BROKER_ACCESS_CHECK_FAILED = 3502, // 券商接入检测失败，无同步数据
    ERROR_TRADE_ACCOUNT_STATE_OPERATION_FORBIDDEN = 3503, // 交易账号处于已经标记移除状态，待启用
    ERROR_BROKER_TECH_PLATFORM_NOT_SUPPORTED = 3504, // 券商接入的技术平台目前托管机不支持
    ERROR_TRADE_ACCOUNT_CANNOT_MODIFY_USERNAME = 3505, // 账号被激活过，无法修改用户名
    ERROR_TRADE_ACCOUNT_BROKER_TECH_ENV_NOT_MATCH = 3506, // 托管机环境和券商接入环境不对等
    
    // 账号接入错误的原因
    ERROR_TRADE_ACCOUNT_INVALID_OTHER = 3599,             // 一些其他的错误原因
    ERROR_TRADE_ACCOUNT_INVALID_USER_PASSWD_ERROR = 3600, // 账号接入用户密码无效
    ERROR_TRADE_ACCOUNT_INVALID_NOT_IN_TRADE_TIME = 3601, // 账号不在交易时间
    ERROR_TRADE_ACCOUNT_INVALID_BROKER_REFUSED = 3602,    // 券商拒绝接入,通常是网络无法联通
    ERROR_TRADE_ACCOUNT_INVALID_PROCESS_STARTING = 3603,  // 进程正在启动中
    ERROR_TRADE_ACCOUNT_INVALID_PROCESS_STOPED = 3604,    // 进程已经停止
    ERROR_TRADE_ACCOUNT_INVALID_CONNECTING = 3605,        // 初始化完成，但是正在接入卷商的过程中
    ERROR_TRADE_ACCOUNT_INVALID_AUTH = 3606,        	  // api授权认证失败
    
    /**
      * 订单执行相关的错误
      */
    ERROR_EXEC_ORDER_REJECT_ACCOUNT_INVALID = 3800,           // 雪橇交易账号不可用，订单被拒绝
    ERROR_EXEC_ORDER_ORDERREF_EXPIRED = 3801,                 // OrderRef失效, 账户出现重新登陆, 需要重新分配OrderRef
    ERROR_EXEC_ORDER_REJECT_CONTRACT_NOTIN_TRADE_TIME = 3802, // 订单所下合约不在交易时间
    ERROR_EXEC_ORDER_CANNOT_DELETE_NO_DEALINFO = 3803,        // 无法雪橇系统无交易所订单信息
    ERROR_EXEC_ORDER_NOT_EXISTED = 3804,                      // 订单不存在
    ERROR_EXEC_ORDER_STATE_NOT_IN_WAITING_VERIFY = 3805,      // 非等待审核状态的订单
    ERROR_EXEC_ORDER_ALREADY_IN_REVOKING = 3806,              // 无法撤单，已经在撤单状态
    ERROR_EXEC_ORDER_UPSIDE_DELETED_FOR_REVOKE = 3807,        // 无法撤单，订单已经撤单
    ERROR_EXEC_ORDER_UPSIDE_FINISHED_FOR_REVOKE = 3808,       // 无法撤单，订单已经完成
    ERROR_EXEC_ORDER_EXISTED = 3809,                          // 订单已经存在
    ERROR_EXEC_ORDER_SYSTEM_SEND_FROM_VERIFYTIME_TOO_LONG = 3810,   // 系统错误，发送时间离审核时间过长
    ERROR_EXEC_ORDER_TRADE_ACCOUNT_IN_INIT = 3811,                  // 交易账号正在初始化
    ERROR_EXEC_ORDER_CTP_INSTRUMENT_NOT_FOUND = 3812,              // 无法找到对应的CTP合约信息
    ERROR_EXEC_ORDER_CTP_COMB_INSTRUMENT_SLICE_FAILED = 3813,      // CTP组合合约无法切割
    ERROR_EXEC_ORDER_REVOKE_TIMEOUT = 3814,                     // 雪橇撤单超时,上手撤单情况未知
    ERROR_EXEC_ORDER_ESUNNY9_NO_ACCOUNT_NO = 3815,               // 易胜9.0交易账户无资金账户信息
    ERROR_EXEC_ORDER_SELF_MATCH = 3816,                // 订单构成自成交
    ERROR_EXEC_ORDER_REVOKE_ACTION_UNKOWN = 3817,      // 撤单行为未知，属于程序导致的BUG行为
    ERROR_EXEC_ORDER_DUPLICATE_SEND = 3818,            // 检测到重复发送
    
    ERROR_EXEC_ORDER_FAILED_USER_CANCELLED = 3850,           // 用户取消，导致失败
    ERROR_EXEC_ORDER_VERIFY_FAILED_ACCOUNT_NOT_FOUND_FORSUBACCOUNT= 3851, // 子用户无订单路由
    ERROR_EXEC_ORDER_VERIFY_FAILED_CONTRACT_MAPPING_NOT_FOUND = 3852, // 无法获取合约商品映射
    ERROR_EXEC_ORDER_VERIFY_FAILED_NOT_SUPPORTED_ORDER_TYPE = 3853,  // 不支持审核的订单类型
    ERROR_EXEC_ORDER_VERIFY_FAILED_SYSTEM_ERROR = 3854,      // 系统内部错误，无法审核
    ERROR_EXEC_ORDER_VERIFY_FAILED_ACCOUNT_DISABLED = 3855,   // 路由交易账户被禁用
    ERROR_EXEC_ORDER_VERIFY_FAILED_ACCOUNT_ORDER_NOT_SUPPORTED = 3856, // 路由关联的账户不支持该种类型的下单
    ERROR_EXEC_ORDER_VERIFY_FAILED_CONTRACT_MAPPING_TOO_MUCH = 3857,   // 查找到的合约映射过多，通常这种错误属于合约系统异常
    ERROR_EXEC_ORDER_VERIFY_FAILED_CONTRACT_MAPPING_ERROR = 3858, // 找到的合约信息有误，明显的程序检查错误
    ERROR_EXEC_ORDER_VERIFY_FAILED_MAPPING_CONTRACT_CODE_FAILED = 3859, // 获取映射合约代码错误
    ERROR_EXEC_ORDER_VERIFY_FAILED_SYSTEM_CANNOT_PROCESSS = 3860,  // 系统无法处理, 审核时间过长
    ERROR_EXEC_ORDER_VERIFY_FAILED_CALCULTE_TRADETIME_FAILED = 3861,  // 计算交易时间失败 
    ERROR_EXEC_ORDER_VERIFY_FAILED_COMMODITY_TRADE_FORBIDDEN = 3862,  // 商品禁止交易
    ERROR_EXEC_ORDER_VERIFY_FAILED_RISK_FORBIDDEN = 3863,             // 风控触发
    
    // 上手接口调用错误
    ERROR_EXEC_ORDER_UPSIDE_REJECT_RETCODE_OTHER = 3900,      // 上手下单接口请求时拒绝，其他错误
    ERROR_EXEC_ORDER_UPSIDE_ORDER_NOT_FOUND = 3901,                 // 上手未找到对应订单
    ERROR_EXEC_ORDER_UPSIDE_OVER_CLOSETODAY_POSITION = 3902,        // 平今仓位不足
    ERROR_EXEC_ORDER_UPSIDE_OVER_CLOSEYESTERDAY_POSITION = 3903,    // 平昨仓位不足
    ERROR_EXEC_ORDER_UPSIDE_OVER_CLOSE_POSITION = 3904,             // 平仓量不足
    ERROR_EXEC_ORDER_UPSIDE_REJECT_ORDER_SENDING = 3905,            // 上手拒绝操作，订单正在发送
    
    ERROR_UPSIDE_CALL_FAILED = 3920,   // 调用上手失败
    
    // 套利错误码占用4000-5000之间

    // 资源结算错误码占用5001-5200之间

    // 持仓调整(核对与分配)错误码占用 5201-5400之间

    // 持仓统计错误码占用 5500-5600之间
    
    // TaskNote错误码在 5700-5800之间
    
    // RiskManager错误码在6000-6200之间

    
    /**
      * 通用错误， 与平台对接
      */
    ERROR_NOT_SUPPORTED = 9000,             // 不支持的操作
    ERROR_SERVER_INNER = 10500,             // 服务器内部出错 
}