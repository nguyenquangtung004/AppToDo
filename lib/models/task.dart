import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
part "task.g.dart"; //import flutter pub run build_runner build để tạo file này
@HiveType(typeId: 0)
class Task extends HiveObject {
  /// Khởi tạo đối tượng Task với các thuộc tính cần thiết.
  Task({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.createAtTime,
    required this.createAtDate,
    required this.isCompleted
  });

   // id của Task (mã định danh duy nhất)
  @HiveField(0)
  final String id;

  // Tiêu đề của Task
  @HiveField(1)
  String title;

  // Phụ đề hoặc mô tả bổ sung cho Task
  @HiveField(2)
  late final String subTitle;

  // Thời gian tạo Task
  @HiveField(3)
  DateTime createAtTime;

  // Ngày tạo Task
  @HiveField(4)
  DateTime createAtDate;

  // Trạng thái hoàn thành của Task
  @HiveField(5)
  bool isCompleted;

   /// Phương thức tạo mới `Task`
  /// Sử dụng `Uuid` để tạo ID duy nhất cho mỗi `Task`.
  factory Task.create({
    required String?title,
    required String?subtitle,
    required DateTime?createAtTime,
    required DateTime?createAtDate,

  }) =>
      Task(
          id: const Uuid().v1(),// Tạo ID duy nhất cho Task mới
          title: title ?? "", // Nếu không có `title`, dùng chuỗi rỗng
          subTitle: subtitle ?? "", // Nếu không có `subTitle`, dùng chuỗi rỗng
          createAtTime: createAtTime??DateTime.now(),// Nếu không có `createAtTime`, dùng thời gian hiện tại
          createAtDate: createAtDate??DateTime.now(),// Nếu không có `createAtDate`, dùng ngày hiện tại
          isCompleted: false,// Mặc định là chưa hoàn thành
          );
}