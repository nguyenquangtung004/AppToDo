import 'package:flutter/material.dart';
import '../../../untils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ///Navigate to TaskView to see Task Details

      },
      child: AnimatedContainer(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        //Giãn cách dòng trong list view
        decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 4),
                  blurRadius: 10)
            ]),
        duration: const Duration(milliseconds: 600),
        child: ListTile(

          ///Check Icon
          leading: GestureDetector(
            onTap: () {
              ///Check or uncheck the task
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),

          ///Task Title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),

            ///Giãn cách check box với title theo chiều ngang

            ///Tiêu đề
            child: Text(
              "Done",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                // decoration: TextDecoration.lineThrough,
              ),
            ),
          ),

          ///Task Decoration
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // Điều chỉnh descoration xuống dưới title
            children: [
              Text(
                "Descrpation",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w300),
              ),
              Align(
                // Sau khi thêm Lớp Align thì ngày tháng với sub date được căn ra giữa
                //Xong alignment: Alignment.centerRight để căn ra bên phải của app
                alignment: Alignment.centerRight,
                child: Padding(
                  //Xong dùng lớp padding để tạo khoảng cách với lề của của list title
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Date",
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "SubDate",
                        style:
                        TextStyle(fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}