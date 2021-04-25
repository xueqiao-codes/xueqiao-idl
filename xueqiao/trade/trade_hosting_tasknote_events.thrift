/**
  *  任务笔记的相关事件通知
  */
namespace * xueqiao.trade.hosting.events

include "trade_hosting_tasknote.thrift"

struct TaskNoteCreatedEvent {
    1:optional trade_hosting_tasknote.HostingTaskNote createdTaskNote;
}

struct TaskNoteDeletedEvent{
    1:optional trade_hosting_tasknote.HostingTaskNoteType noteType;
    2:optional trade_hosting_tasknote.HostingTaskNoteKey noteKey;
}

enum TaskNoteGuardEventType {
    GUARD_TASK_NOTE_CREATED = 1,
    GUARD_TASK_NOTE_DELETED = 2,
}

struct TaskNoteGuardEvent{
    1:optional TaskNoteGuardEventType guardType;
    2:optional trade_hosting_tasknote.HostingTaskNoteType noteType;
    3:optional trade_hosting_tasknote.HostingTaskNoteKey noteKey;
}