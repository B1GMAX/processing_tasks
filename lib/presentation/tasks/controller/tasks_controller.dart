import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:procesing_tasks/presentation/models/task.dart';

class TaskController extends GetxController {
  List<Task> tasks = List.generate(5, (index) => Task(index + 1));
  bool allTasksComplete = false;

  TaskController() {
    startTasks();
  }

  void startTasks() {
    for (final task in tasks) {
      task.start(checkIsAllTasksDone);
    }
  }

  void addTask() {
    Task newTask = Task(tasks.length + 1);
    tasks.add(newTask);
    allTasksComplete = !allTasksComplete;
    newTask.start(checkIsAllTasksDone);
    update();
  }

  void checkIsAllTasksDone() {
    allTasksComplete = tasks.every((task) => task.status == TaskStatus.done);
    update();
  }

  void toggleTaskPause(Task task) {
    task.pause();
    update();
  }

  @override
  void dispose() {
    super.dispose();
    for (final task in tasks) {
      task.dispose();
    }
  }
}
