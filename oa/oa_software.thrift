/** * oa software */ namespace java org.soldier.platform.oa.software

 struct TsoftwareProject { 	1:optional i32 projectId; 	2:optional string name; 	3:optional string remark;	
	4:optional i32 createTimestamp; }

 struct TsoftwarePlatform {
	1:optional string platformId;
	2:optional string name;
	3:optional i32 createTimestamp;
 }
 struct Tsoftware { 	1:optional string name; 	2:optional string version; 	3:optional TsoftwarePlatform platform; 	4:optional TsoftwareProject project; 	5:optional string linkUrl; 	6:optional string remark; 	7:optional i32 createTimestamp;
	8:optional i32 modifyTimestamp; 	9:optional i32 softwareId;
	10:optional bool inUse;
	11:optional bool inMaintain;
	12:optional string releaseNotes;
	13:optional string relatedFileFormat;
	14:optional bool existRelatedFile;
	15:optional string fullRelatedFileUrl;	16:optional string bundleId; }  struct QuerySoftwareOption { 	1:optional string platformId; 	2:optional i32 projectId; 	3:optional string name;
	4:optional bool inUse;
	5:optional bool inMaintain;
	6:optional string version;	7:optional string bundleId;	8:optional set<i32> inSoftwareIds;			9:optional set<i32> notInSoftwareIds;		 }  struct SoftwarePage { 	1:optional i32 total; 	2:optional list<Tsoftware> page; } 