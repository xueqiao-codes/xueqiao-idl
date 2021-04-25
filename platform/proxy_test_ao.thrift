namespace java org.soldier.platform.proxy.test.ao
namespace cpp platform.proxy_test_ao
namespace py  proxy_test_ao

include "../comm.thrift"

struct EchoListResult {
    1:optional list<string> contentList;
}

struct EchoTypes {
    1:optional bool bool_field;
    2:optional string string_field;
    3:optional i64  int64_field;
    4:optional i32  int32_field;
    5:optional double double_field;
    6:optional list<string> list_field;
    7:optional map<string, string> map_field;
    8:optional set<string>  set_field;
    9:optional EchoListResult struct_field;
}


service(3) proxy_test_ao {
    string 1:testEcho(1:comm.PlatformArgs platformArgs, 2:string content) throws (1:comm.ErrorInfo err);

    list<string> 2:testEchoList(1:comm.PlatformArgs platformArgs, 2:list<string> contentList) throws (1:comm.ErrorInfo err);

    EchoListResult 3:testEchoListStruct(1:comm.PlatformArgs platformArgs, 2:list<string> contentList) throws (1:comm.ErrorInfo err);

    EchoTypes 4:echoTypes(1:comm.PlatformArgs platformArgs, 2:EchoTypes types, 3:bool throw_action) throws (1:comm.ErrorInfo err);
  
    set<i64> 5:testEchoSet(1:comm.PlatformArgs platformArgs, 2:set<i64> valueList) throws (1:comm.ErrorInfo err);
  
    map<i64, string> 6:testEchoMap(1:comm.PlatformArgs platformArgs, 2:map<i64, string> mapValue) throws (1:comm.ErrorInfo err);

    list<EchoTypes> 7:testEchoTypesList(1:comm.PlatformArgs platformArgs, 2:list<EchoTypes> types) throws (1:comm.ErrorInfo err);
}
