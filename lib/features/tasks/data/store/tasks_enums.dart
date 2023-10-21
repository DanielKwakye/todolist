enum TasksStatus {
  initial,
  addNewTaskInProgress, addNewTaskFailed, addNewTaskSuccessful,
  updateTaskInProgress, updateTaskFailed, updateTaskSuccessful,
  removeTaskInProgress, removeTaskFailed, removeTaskSuccessful,
  refreshTasksInProgress, refreshTasksFailed, refreshTasksSuccessful,
  fetchTasksInProgress, fetchTasksCompleted, fetchTasksFailed
}

enum TaskBroadcastAction {
  add, update, remove
}