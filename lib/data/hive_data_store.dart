import 'package:app_to_do/main.dart';
import 'package:app_to_do/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Tất cả các phương thức [CRUD] cho HiveDB
class HiveDataStore {
  static const boxName = 'taskBox';
  // Tạo box với kiểu dữ liệu <Task> để lưu trữ
  late final Box<Task> box;
  /// Khởi tạo HiveDataStore, đảm bảo mở hộp trước khi sử dụng.
  HiveDataStore() {
    _initBox();
  }
    Future<void> _initBox() async {
    // Đảm bảo hộp đã mở trước khi sử dụng
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox<Task>(boxName);
    } else {
      box = Hive.box<Task>(boxName);
    }
  }

  /// Thêm Task Mới vào Box
  /// [task] là đối tượng `Task` cần thêm vào.
  Future<void> addTask({required Task task}) async {
    // Ghi chú: Sử dụng `task.id` làm key cho task mới.
    await box.put(task.id, task);
  }


  /// Lấy Task Dựa Theo ID
  /// [id] là `String` đại diện cho ID của `Task`.
  Future<Task?> getTask({required String id}) async {
    // Trả về `Task` nếu tìm thấy theo `id`, hoặc null nếu không tìm thấy
    return box.get(id);
  }

 /// Cập Nhật Task
  /// [task] là đối tượng `Task` cần cập nhật.
  Future<void> updateTask({required Task task}) async {
    // Lưu dữ liệu của task lại sau khi đã thay đổi
    // Ghi chú: Đảm bảo `task` đã được sửa đổi trước khi gọi `save()`.
    await box.put(task.id, task);
  }

  /// Xóa Task
  /// [task] là đối tượng `Task` cần xóa.
  Future<void> deleteTask({required Task task}) async {
    // Xóa task dựa trên `id`
    await box.delete(task.id);
  }

   /// Lắng Nghe Thay Đổi Trong Box
  /// Sử dụng phương thức này để lắng nghe các thay đổi của hộp và cập nhật UI tương ứng.
  ValueListenable<Box<Task>> listToTask() => box.listenable();
}