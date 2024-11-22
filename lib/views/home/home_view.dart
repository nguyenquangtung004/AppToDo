import 'package:app_to_do/untils/app_colors.dart';
import 'package:app_to_do/untils/constants.dart';
import 'package:app_to_do/views/home/components/fab.dart';
import 'package:app_to_do/views/home/components/home_app_bar.dart';
import 'package:app_to_do/views/home/components/slider_drawer.dart';
import 'package:app_to_do/views/home/widget/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/extensions/space_exs.dart';

///Tự import
import 'package:lottie/lottie.dart';

///Tự import
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

///Tự import
import 'package:animate_do/animate_do.dart';

///Tự import
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //Import thư viện SliderDrawer
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();
  final List<int> tesing = [2, 232, 51];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      //Fab
      floatingActionButton: Fab(),

      //Body
      body: SliderDrawer(
        key: drawerKey,
          //isDraggable: false khi để nút này thành true người dùng vuốt sang phải là hiển thị drawer
          isDraggable: false,
          animationDuration: 1000,
          //Drawer
          slider: CustomDrawer(),
          appBar: HomeAppBar(drawerKey: drawerKey,),
          child: _buildHomeBody(textTheme)
      ),
    );
  }

  ///Home Body
  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
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
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
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
            child: tesing.isNotEmpty

                /// Task list is not empty
                ? ListView.builder(
                    // padding: EdgeInsets.only(bottom: 80),
                    itemCount: tesing.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      // Dismissible khi vuốt trái sang phải có thể xóa
                      return Dismissible(
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          setState(() {
                            tesing.removeAt(index);
                          });
                        },
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
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        key: UniqueKey(),
                        child: const TaskWidget(),
                      );
                    },
                  )

                /// Task list is empty
                : Column(
                    //Căn animation ra giữa
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Phải tự import bằng tay lottie
                      //Xong sau đó tạo ra file space_exs.dart
                      //Khai báo vào trong đó lottieUrl
                      //rồi lên testing để tảo ra danh sách rỗng kiểm tra xem đã thực hiện thành công lottie chưa
                      //nếu Animate mà nó không rỗng

                      //Thêm lớp FadeInUp để làm animation chuyển động chậm
                      ///Lottie Anime
                      FadeIn(
                        child: SizedBox(
                          //Thay đổi kích thước animation
                          width: 200,
                          height: 200,
                          child: Lottie.asset(lottieUrl,
                              animate: tesing.isNotEmpty ? false : true),
                        ),
                      ),
                      //Sub Text
                      FadeInUp(
                        from: 30,

                        ///Đặt ra một câu hỏi đó là tại sao cứ phải dùng const trong một số lớp giao diện ví dụ như :
                        ///child: const Text(AppStr.doneAllTask)
                        /// -> Tối ưu hóa hiệu suất của ứng dụng khi mỗi lần flutter chạy lại và phải tạo lại instance mới của widget Text đó, mặc dù giá trị của nó không thay đổi.
                        ///----------------------------------------------------------------------------------------
                        /// Tiếp theo instance là gì ?
                        /// Được hiểu là  một bản sao cụ thể của một đối tượng được tạo ra từ một lớp (class).
                        /// Bạn có thể tưởng tượng lớp như là một bản thiết kế hoặc khuôn mẫu,
                        /// và khi bạn tạo một instance, bạn đang tạo ra một đối tượng thực tế từ thiết kế đó.
                        ///-----------------------------------------------------------------------------------------
                        /// -> Có thể hiểu đơn giản qua ví dụ sau đây :
                        /// * class Person {
                        ///   String name;
                        ///  int age;
                        ///
                        ///   Person({required this.name, required this.age});
                        /// }
                        /// *
                        ///----------------------------------------------------------------------------------------
                        /// -> Person là lớp (class),
                        /// -> person1 và person2 là instance của lớp Person.
                        /// -> Mỗi instance có thể có các giá trị riêng biệt (ví dụ name và age),
                        /// mặc dù chúng đều được tạo từ lớp Person
                        ///----------------------------------------------------------------------------------------
                        ///Đơn giản hóa
                        ///->Lớp: Text (mô tả cách hiển thị văn bản)
                        ///->Instance: Cái cụ thể mà bạn đang hiển thị trên màn hình (ví dụ: Text("Hello World"))

                        child: const Text(AppStr.doneAllTask),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
