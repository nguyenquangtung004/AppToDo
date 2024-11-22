import 'package:app_to_do/untils/app_colors.dart';
import 'package:app_to_do/untils/constants.dart';
import 'package:app_to_do/views/home/components/fab.dart';
import 'package:app_to_do/views/home/widget/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/extensions/space_exs.dart';
import 'package:lottie/lottie.dart';
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> tesing =[];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      //Fab
      floatingActionButton: Fab(),

      //Body
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ///Custom App Bar
            Container(
              margin: const EdgeInsets.only(top: 60),
              width: double.infinity,
              height: 100,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Progress Indicator
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      value: 1 / 3,
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation(AppColors.primaryColor),
                    ),
                  ),
                  //Space
                  const SizedBox(
                    width: 25,
                  ),
                  //Top Level Task Info
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStr.mainTitle,
                        style: textTheme.displayLarge,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        "1 of 3 task",
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

            ///Tasks
            SizedBox(
              width: double.infinity,
              height: 745,
              child:tesing.isNotEmpty? ListView.builder(
                // padding: EdgeInsets.only(bottom: 80),
                itemCount: tesing.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  // Dismissible khi vuốt trái sang phải có thể xóa
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    onDismissed: (_) {},
                    background: Row(
                      //mainAxisAlignment: MainAxisAlignment.center căn các lớp như icon và text ra giữa khi vuốt
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete_outline,
                          color: Colors.grey,
                        ),
                        8.w,
                        const Text(
                          AppStr.deletedTask,
                          style: TextStyle(
                            color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    key: Key(
                      index.toString(),
                    ),
                    child: const TaskWidget(),
                  );
                },
              ):Column(
                children: [
                  //Phải tự import bằng tay lottie
                  //Xong sau đó tạo ra file space_exs.dart
                  //Khai báo vào trong đó lottieUrl
                  //rồi lên testing để tảo ra danh sách rỗng kiểm tra xem đã thực hiện thành công lottie chưa
                  Lottie.asset(lottieUrl),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
