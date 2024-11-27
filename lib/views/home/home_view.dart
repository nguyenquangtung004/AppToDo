import 'package:app_to_do/main.dart';
import 'package:app_to_do/models/task.dart';
import 'package:app_to_do/untils/app_colors.dart';
import 'package:app_to_do/untils/constants.dart';
import 'package:app_to_do/views/home/components/fab.dart';
import 'package:app_to_do/views/home/components/home_app_bar.dart';
import 'package:app_to_do/views/home/components/slider_drawer.dart';
import 'package:app_to_do/views/home/widget/task_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/extensions/space_exs.dart';

/// Tự import
import 'package:lottie/lottie.dart';

/// Tự import
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

/// Tự import
import 'package:animate_do/animate_do.dart';

/// Tự import
import 'package:hive/hive.dart';

/// 1. Khởi tạo HomeView
/// HomeView: Lớp chính đại diện cho giao diện chính của ứng dụng
/// StatefulWidget: Được dùng để tạo một widget có trạng thái thay đổi.
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  /// _HomeViewState: Quản lý trạng thái và giao diện của HomeView.
  @override
  State<HomeView> createState() => _HomeViewState();
}

/// 2. Biến toàn cục
class _HomeViewState extends State<HomeView> {
  // drawerKey: Khóa để điều khiển trạng thái của SliderDrawer.
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  /// 3. Widget build
  @override
  Widget build(BuildContext context) {
    // Lấy `BaseWidget` từ context
    final base = BaseWidget.of(context);
    // Lấy `TextTheme` từ `ThemeData` của ứng dụng
    TextTheme textTheme = Theme.of(context).textTheme;
    // `ValueListenable` để lắng nghe các thay đổi từ box của Hive
    ValueListenable<Box<Task>> valueListenable = base.dataStore.listToTask();

    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (ctx, Box<Task> box, Widget? child) {
        // Lấy danh sách `tasks` từ box
        var tasks = box.values.toList();

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Fab(), // Nút nổi để thực hiện hành động
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,
            slider: CustomDrawer(), // slider: Nội dung của ngăn kéo.
            appBar: HomeAppBar(
              drawerKey: drawerKey,
            ),
            child: _buildHomeBody(textTheme, box), // Nội dung chính của giao diện
          ),
        );
      },
    );
  }

  /// 4. Widget _buildHomeBody
  Widget _buildHomeBody(TextTheme textTheme, Box<Task> box) {
    List<Task> tasks = box.values.toList();
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          /// Custom App Bar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress Indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: tasks.isEmpty ? 0 : tasks.where((task) => task.isCompleted).length / tasks.length,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),
                const SizedBox(width: 25),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      "${tasks.where((task) => task.isCompleted).length} of ${tasks.length} tasks",
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          /// Tasks List
          Expanded(
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                        key: Key(task.id), // Sử dụng `task.id` để làm khóa duy nhất
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          // Hiển thị hộp thoại xác nhận trước khi xóa
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Xác nhận xóa"),
                                content: const Text("Bạn có chắc chắn muốn xóa nhiệm vụ này không?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false); // Hủy bỏ
                                    },
                                    child: const Text("Hủy"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true); // Xác nhận xóa
                                    },
                                    child: const Text("Xóa"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) async {
                          // Xóa nhiệm vụ khỏi Hive
                          await box.deleteAt(index);

                          // Sau khi xóa, cần cập nhật giao diện
                          setState(() {
                            tasks.removeAt(index);
                          });
                        },
                        background: Container(
                          color: Colors.redAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.delete_outline, color: Colors.white),
                              const SizedBox(width: 8),
                              const Text(
                                AppStr.deletedTask,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        child: TaskWidget(task: task), // Hiển thị chi tiết nhiệm vụ
                      );
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieUrl,
                            animate: true,
                          ),
                        ),
                      ),
                      FadeInUp(
                        from: 30,
                        child: const Text(AppStr.doneAllTask),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
