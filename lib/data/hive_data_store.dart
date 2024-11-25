import 'package:app_to_do/main.dart';
import 'package:app_to_do/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

///All the [CRUD] operation method for hiveDB
class HiveDataStore {
  static const boxName = 'taskBox';

  final Box<Task> box = Hive.box<Task>(boxName);

  ///Add New Task To Box
  Future<void> addTask ({required Task task}) async{
    await box.put(task.id, task);
  }

  ///Show Task
  Future<Task?> getTask({required String id })async{
    return box.get(id);
  }

  ///Update Task
  Future<void> updateTask({required Task task})async{
    await task.save();
  }

  ///Delete Task
  Future<void> deleteTask ({required Task task})async{
    await task.delete();
  }

  ///Listen to Box Changes
  ///Using this method we will listen to box changes and update the
  ///UI accordingly
  ValueListenable<Box<Task>> listToTask() => box.listenable();
}