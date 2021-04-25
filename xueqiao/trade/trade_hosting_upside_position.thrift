/**
  * 上手接入账号持仓信息
  */
namespace * xueqiao.trade.hosting.upside.position

include "trade_hosting_basic.thrift"

enum CTPPositionDirection {
    POSITION_LONG = 0,   // 多头
    POSITION_SHORT = 1,  // 空头
}

enum CTPContractPosDateType {
    POS_USE_HISTORY = 1,   // 持仓使用历史
    POS_UNUSE_HISTORY = 2, // 持仓不使用历史
}

// 昨日持仓
struct CTPYDPositionInfo {
    1:optional i32 ydPosVolume;
}

// 平昨量信息
struct CTPCloseYDInfo {
    1:optional i32 closeYDVolume;
}

// 平今量信息
struct CTPCloseTDInfo {
    1:optional i32 closeTDVolume;
}

// 开仓信息
struct CTPOpenTDInfo {
    1:optional i32 openTDVolume;
}

enum CTPFronzenPositionDateType {
    FRONZEN_YD_POSITION = 1,  // 冻结昨日仓
    FRONZEN_TD_POSITION = 2,  // 冻结今仓
    FRONZEN_ALL_POSITION = 3,  // 不区分性冻结
}

// 持仓冻结信息
struct CTPFronzenInfo {
    1:optional i32 fronzenTotalVolume; // 冻结总量信息
    2:optional CTPFronzenPositionDateType fronzenPosDateType;  // 冻结仓位信息
}

struct CTPPositionSummary {
    1:optional string instrumentID;  // CTP InstrumentID
    2:optional CTPContractPosDateType contractPosDateType; // 合约是否使用历史持仓
    3:optional string exchangeID;  // CTP echangeID
    4:optional i16 productClass;   // CTP productClass
    5:optional string productID;   // CTP productID
    
    10:optional CTPPositionDirection posDirection; // 持仓方向
    11:optional CTPYDPositionInfo ydPosInfo; // 昨日持仓信息
    12:optional CTPCloseTDInfo closeTDInfo; // 平今信息
    13:optional CTPCloseYDInfo closeYDInfo; // 平昨信息
    14:optional CTPOpenTDInfo openTDInfo;   // 开仓信息
    
    15:optional map<CTPFronzenPositionDateType, CTPFronzenInfo> fronzenInfos; // 冻结信息
}


struct PositionSummary {
    1:optional trade_hosting_basic.BrokerTechPlatform techPlatform;   // 技术平台
    2:optional CTPPositionSummary ctpPosSummary; // CTP持仓信息
}


