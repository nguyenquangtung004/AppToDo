import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Import các model và widget cần thiết
import 'data/hive_data_store.dart'; // Đảm bảo bạn có lớp này trong thư mục data
import './models/task.dart'; // Đảm bảo đường dẫn đúng với model Task của bạn
import './views/home/home_view.dart'; // Đảm bảo đường dẫn đúng với widget HomeView của bạn

Future<void> main() async {
  /// Đảm bảo khởi tạo các widget và Hive
  WidgetsFlutterBinding.ensureInitialized();

  /// Khởi tạo Hive
  await Hive.initFlutter();

  /// Đăng ký adapter cho Task
  Hive.registerAdapter(TaskAdapter());

  /// Mở box Hive
  try {
    await Hive.openBox<Task>('taskBox');
    debugPrint('Hive box opened successfully');
  } catch (e) {
    debugPrint('Error opening Hive box: $e');
  }

  /// Chạy ứng dụng với BaseWidget
  runApp(BaseWidget(child: const MyApp()));
}

/// BaseWidget để quản lý các dịch vụ toàn cục
/// Mục tiêu của `BaseWidget` là để cung cấp `HiveDataStore` cho toàn bộ ứng dụng.
class BaseWidget extends InheritedWidget {
  BaseWidget({Key? key, required this.child}) : super(key: key, child: child);

  final Widget child;

  /// Tạo instance của HiveDataStore (đảm bảo bạn đã tạo lớp này)
  final HiveDataStore dataStore = HiveDataStore();

  /// Lấy instance của BaseWidget
  /// Hàm này giúp truy cập `HiveDataStore` từ bất kỳ vị trí nào trong widget tree
  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw StateError('Không tìm thấy widget BaseWidget trong context.');
    }
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

/// MyApp là lớp chính của ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Todo App',
      theme: ThemeData(
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w300,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 21,
          ),
          displaySmall: TextStyle(
            color: Color.fromARGB(255, 234, 234, 234),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          headlineSmall: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          titleSmall: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          titleLarge: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      home: const HomeView(), // Mặc định chuyển đến `HomeView`
    );
  }
}
