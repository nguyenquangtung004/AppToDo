import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/task.dart';
import '../../../untils/app_colors.dart';
import '../widget/layout_add.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TextEditingController textEditingControllerForTitle = TextEditingController();
  TextEditingController textEditingControllerForSubTitle = TextEditingController();

  // Biến trạng thái cho task completion
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    textEditingControllerForTitle.text = widget.task.title;
    textEditingControllerForSubTitle.text = widget.task.subTitle;
    isCompleted = widget.task.isCompleted; // Khởi tạo trạng thái
  }

  @override
  void dispose() {
    textEditingControllerForTitle.dispose();
    textEditingControllerForSubTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Điều hướng đến LayoutAdd khi nhấn vào toàn bộ Task
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => LayoutAdd(
              task: widget.task,
              titleTaskController: textEditingControllerForTitle,
              descrptionTaskController: textEditingControllerForSubTitle,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          // Thay đổi màu nền khi trạng thái hoàn thành thay đổi
          color: isCompleted
              ? const Color.fromARGB(154, 119, 144, 229)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 4),
                blurRadius: 10)
          ],
        ),
        duration: const Duration(milliseconds: 600),
        child: ListTile(
          // Check Icon
          leading: GestureDetector(
            onTap: () {
              setState(() {
                isCompleted = !isCompleted; // Thay đổi trạng thái
                widget.task.isCompleted = isCompleted;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color: isCompleted ? AppColors.primaryColor : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: Icon(
                Icons.check,
                color: isCompleted ? Colors.white : Colors.transparent,
              ),
            ),
          ),

          // Task Title
          title: GestureDetector(
            onTap: () {
              // Điều hướng đến màn hình cập nhật Task khi nhấn vào tiêu đề
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LayoutAdd(
                    task: widget.task,
                    titleTaskController: TextEditingController(text: widget.task.title),
                    descrptionTaskController: TextEditingController(text: widget.task.subTitle),
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5, top: 3),
              child: Text(
                textEditingControllerForTitle.text,
                style: TextStyle(
                  color: isCompleted ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),

          // Task Subtitle
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textEditingControllerForSubTitle.text,
                style: TextStyle(
                  color: isCompleted ? Colors.white : Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.createAtTime),
                        style: TextStyle(
                            fontSize: 14,
                            color: isCompleted ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.createAtDate),
                        style: TextStyle(
                            fontSize: 14,
                            color: isCompleted ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold),
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
