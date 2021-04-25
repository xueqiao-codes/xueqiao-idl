/**
  * file stroage dao
  */
namespace java org.soldier.platform.filestorage.dao

include "../comm.thrift"

enum EACLControlList {
    Default = 0,
    Private = 1,
    PublicRead = 2,
    PublicReadWrite = 3,
}

struct HttpOption {
	1:optional string contentType; 
	2:optional i64 expireTimestamp; 
	3:optional string contentEncoding;
	4:optional string catchControl;
	5:optional string contentDisposition;
	6:optional map<string, string> userMetaData;
	7:optional EACLControlList aclControl;
}

service(15) FileStorageDao {
	binary 1:readFile(1:comm.PlatformArgs platformArgs, 2:string storageKey,
		3:string path) throws (1:comm.ErrorInfo err);
		
	void 2:writeFile(1:comm.PlatformArgs platformArgs, 2:string storageKey,
		3:string path, 4:binary content, 5:HttpOption option) throws (1:comm.ErrorInfo err);
		
	void 3:deleteFile(1:comm.PlatformArgs platformArgs, 2:string storageKey,
		3:string path) throws (1:comm.ErrorInfo err);	
}
