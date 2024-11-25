import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part "task.g.dart"; //import flutter pub run build_runner build để tạo file này
@HiveType(typeId: 0)
class Task extends HiveObject {
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createAtTime,
    required this.createAtDate,
    required this.isCompleted
  });

  //id
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  final String subTitle;

  @HiveField(3)
  DateTime createAtTime;

  @HiveField(4)
  DateTime createAtDate;

  @HiveField(5)
  bool isCompleted;

  //Create new Task
  factory Task.create({
    required String?title,
    required String?subtitle,
    required DateTime?createAtTime,
    required DateTime?createAtDate,

  }) =>
      Task(id: const Uuid().v1(),
          title: title ?? "",
          subTitle: subtitle ?? "",
          createAtTime: createAtTime??DateTime.now(),
          createAtDate: createAtDate??DateTime.now(),
          isCompleted: false);
}