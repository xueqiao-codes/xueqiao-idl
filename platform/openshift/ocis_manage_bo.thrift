/**
  * Openshift ImageStream的管理服务
  */
namespace java org.soldier.platform.openshift

include "../../comm.thrift"

struct OcProject {
    1:optional string projectName;
    2:optional string displayName;
    3:optional string description;
}

struct OcImageStream {
    1:optional string isName;
    2:optional string dockerRepo;
}

struct OcImageStreamTag {
    1:optional string tagName;
    2:optional string fromKind;
    3:optional string fromName;
    4:optional string imageId;
    5:optional i64 createTimestamp; //创建的时间戳
    6:optional string message;  // 对应展示的message
}

service(30) OcisManageBo {
    list<OcProject> 1:getProjects(1:comm.PlatformArgs platformArgs) throws (1:comm.ErrorInfo err);
    
    list<OcImageStream> 2:getProjectImageStreams(1:comm.PlatformArgs platformArgs
            , 2:string projectName) throws (1:comm.ErrorInfo err);
            
    list<OcImageStreamTag> 3:getImageStreamTags(1:comm.PlatformArgs platformArgs
            , 2:string projectName
            , 3:string isName) throws (1:comm.ErrorInfo err);
   
    /**
      * 创建空的镜像流
      */         
    void 4:createImageStream(1:comm.PlatformArgs platformArgs
            , 2:string projectName
            , 3:string isName) throws (1:comm.ErrorInfo err);
            
    /**
      *  从默认镜像源导入导入指定名称的镜像
      */
    void 5:importImageFromDefaultSource(1:comm.PlatformArgs platformArgs
            , 2:string projectName
            , 3:string isName
            , 4:string tagName) throws (1:comm.ErrorInfo err);  
            
    /**
      *  删除镜像Tag
      */        
    void 6:deleteImageStreamTag(1:comm.PlatformArgs platformArgs
            , 2:string projectName
            , 3:string isName
            , 4:string tagName) throws (1:comm.ErrorInfo err);
}

