/**
  * 托管机实体机管理dao
  */
namespace * xueqiao.hosting.taskqueue.dao

include "../../comm.thrift"
include "../../page.thrift"
include "hosting_sync_task_queue.thrift"

service(756) HostingSyncTaskQueueDao {
	/**
	  * 同步信息任务队列
	  */
	void 1: addSyncTaskQueue(1:comm.PlatformArgs platformArgs, 2: hosting_sync_task_queue.TSyncTaskQueue taskQueue)
		throws (1:comm.ErrorInfo err);
	
	/**
	 * 返回任务队列
	 */
	hosting_sync_task_queue.SyncTaskQueuePage 2: querySyncTaskQueue(1:comm.PlatformArgs platformArgs, 2: hosting_sync_task_queue.QuerySyncTaskQueueOption option, 3:page.IndexedPageOption pageOption)
		throws (1:comm.ErrorInfo err);
	
	/**
      * 删除特定id的任务(任务完成后，从队列中删除任务)
      */
	void 3: deleteSyncTaskQueue(1:comm.PlatformArgs platformArgs, 2: i32 taskId)
		throws (1:comm.ErrorInfo err);
	
	/**
      * 更新任务状态(重试次数或状态)
      */
	void 4: updateSyncTaskQueue(1:comm.PlatformArgs platformArgs, 2: hosting_sync_task_queue.TSyncTaskQueue taskQueue)
		throws (1:comm.ErrorInfo err);
}