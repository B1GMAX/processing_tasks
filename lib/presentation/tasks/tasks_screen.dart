import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:procesing_tasks/presentation/models/task.dart';

import 'controller/tasks_controller.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Screen')),
      body: GetBuilder<TaskController>(
        init: TaskController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              'Task ${task.id} - ${task.status} ${task.status == TaskStatus.done ? ' Execution time: ${task.secondsLeft} seconds' : ''}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                          if (task.status == TaskStatus.running)
                            Row(
                              children: [
                                const CircularProgressIndicator(),
                                IconButton(
                                  icon: Icon(task.isPaused
                                      ? Icons.play_arrow
                                      : Icons.pause),
                                  onPressed: () {
                                    controller.toggleTaskPause(task);
                                  },
                                ),
                              ],
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (controller.allTasksComplete)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'All tasks complete',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.startTasks,
                      child: const Text('Start Tasks'),
                    ),
                    ElevatedButton(
                      onPressed: controller.addTask,
                      child: const Text('Add Task'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
