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

import 'package:lottie/lottie.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    final base = BaseWidget.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    ValueListenable<Box<Task>> valueListenable = base.dataStore.listToTask();

    return ValueListenableBuilder(
      valueListenable: valueListenable,
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: Fab(),
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,
            slider: CustomDrawer(),
            appBar: HomeAppBar(
              drawerKey: drawerKey,
            ),
            child: _buildHomeBody(textTheme, box),
          ),
        );
      },
    );
  }

  Widget _buildHomeBody(TextTheme textTheme, Box<Task> box) {
    List<Task> tasks = box.values.toList();

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: tasks.isEmpty
                        ? 0
                        : tasks.where((task) => task.isCompleted).length / tasks.length,
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
          Expanded(
            child: tasks.isNotEmpty
                ? ListView.builder(
                    itemCount: tasks.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      var task = tasks[index];
                      return Dismissible(
                        key: Key(task.id),
                        direction: DismissDirection.horizontal,
                        confirmDismiss: (direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Xác nhận xóa"),
                                content: const Text("Bạn có chắc chắn muốn xóa nhiệm vụ này không?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: const Text("Hủy"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text("Xóa"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (direction) async {
                          await box.deleteAt(index);
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
                        // Không còn sự kiện nhấp vào đây nữa.
                        child: TaskWidget(task: task),
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
