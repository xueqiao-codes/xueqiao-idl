/**
  * IDL信息分析服务
  */

namespace java  org.soldier.platform.idl
namespace cpp platform.idl
namespace py  platform.idl

include "../comm.thrift"

enum TFieldType {
    VOID = 0,
    I32 = 1,
    I64 = 2,
    STRING = 3,
    BOOL = 4,
    MAP = 5,
    ENUM = 6,
    TYPEDEF = 7,
    STRUCT = 8,
    LIST = 9,
    SET = 10,
    XCEPTION = 11
}

/**
  * 基本类型
  */
struct FieldTypeBase {
    1:required TFieldType type;
    2:optional string name;
    3:optional string baseNamespace;
}

struct FieldTypeContainerBase {
    1:optional FieldTypeBase baseType;
    2:optional list<FieldTypeBase> baseContainerTypes;
}

struct FieldTypeInfo {
    1:required FieldTypeBase baseType;
    3:optional list<FieldTypeContainerBase> containerTypes;
}

struct FieldInfo {
    1:required FieldTypeInfo fieldType;
    2:required i32 fieldKey;
    3:required string fieldName;
}

struct FunctionInfo {
    1:optional FieldTypeInfo returnType;
    2:required string functionName;
    3:required i32    functionKey;
    4:optional list<FieldInfo> functionParameters;
    5:optional list<FieldInfo> functionThrows;
}

struct ServiceInfo {
    1:required i32 serviceKey;
    2:required string serviceName;
    3:required map<string, string> serviceNamespaces;
    4:required list<FunctionInfo> serviceFunctions;
}

enum IDLAnalysisError {
    ERROR_PARSE = 4000, // 解析文件失败
    IDL_NOT_FOUND = 4001, // IDL未找到
}

service(5) IDLAnalysisAo {
    /**
      * 分析服务IDL, 获取IDL的所有信息
      *    idlRelativePath: 相对于服务提供的IDL部署目录的相对路径
      */
    list<ServiceInfo> 1:analysisIDLServices(1:comm.PlatformArgs platformArgs, 2:string idlRelativePath) throws (1:comm.ErrorInfo err)
}