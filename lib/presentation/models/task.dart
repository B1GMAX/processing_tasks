import 'dart:async';
import 'dart:math';
import 'dart:ui';

enum TaskStatus { waiting, running, paused, done }

extension TaskStatusExtension on TaskStatus {
  String get label {
    switch (this) {
      case TaskStatus.waiting:
        return "Task is waiting";
      case TaskStatus.running:
        return "Task is running";
      case TaskStatus.paused:
        return "Task is paused";
      case TaskStatus.done:
        return "Task is done";
      default:
        return "";
    }
  }
}

class Task {
  final int id;
  late final int _duration;
  TaskStatus status = TaskStatus.waiting;
  Timer? _timer;
  bool isPaused = false;
  DateTime? _startTime;
  DateTime? _endTime;

  int? get secondsLeft => _endTime?.difference(_startTime!).inSeconds;

  Task(this.id) {
    _duration = Random().nextInt(5000) + 1000;
  }

  void start(VoidCallback onUpdate) {
    status = TaskStatus.running;
    _startTime = DateTime.now();
    _timer = Timer(Duration(milliseconds: _duration), () {
      _endTime = DateTime.now();
      status = TaskStatus.done;
      onUpdate();
    });
  }

  void pause() {
    if (isPaused) {
      isPaused = false;
      status = TaskStatus.running;
      start(() {});
    } else {
      isPaused = true;
      status = TaskStatus.paused;
      _timer?.cancel();
    }
  }

  void dispose() => _timer?.cancel();
}
