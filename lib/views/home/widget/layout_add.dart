import 'package:app_to_do/extensions/space_exs.dart';
import 'package:app_to_do/main.dart';
import 'package:app_to_do/models/task.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/untils/constants.dart';
import 'package:app_to_do/views/home/widget/add_task_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_colors.dart';

import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../components/date_time_selection.dart';
import '../components/rep_textfield.dart';

/// `LayoutAdd` là widget để thêm hoặc chỉnh sửa nhiệm vụ
class LayoutAdd extends StatefulWidget {
  LayoutAdd({
    super.key,
    this.task,
    required this.titleTaskController,
    required this.descrptionTaskController,
  });

  final TextEditingController titleTaskController;
  final TextEditingController descrptionTaskController;
  final Task? task;

  @override
  State<LayoutAdd> createState() => _LayoutAddState();
}

class _LayoutAddState extends State<LayoutAdd> {
  DateTime? time;
  DateTime? date;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      time = widget.task!.createAtTime;
      date = widget.task!.createAtDate;
      widget.titleTaskController.text = widget.task!.title;
      widget.descrptionTaskController.text = widget.task!.subTitle;
    }
  }

  /// Kiểm tra xem nhiệm vụ có trống hay không
  bool isTaskAlreadyExist() {
    return widget.titleTaskController.text.isEmpty || widget.descrptionTaskController.text.isEmpty;
  }

  /// Hiển thị thời gian đã chọn dưới dạng chuỗi
  String showTime(DateTime? time) {
    if (time == null) {
      return DateFormat('hh:mm a').format(DateTime.now());
    } else {
      return DateFormat('hh:mm a').format(time);
    }
  }

  /// Hiển thị ngày đã chọn dưới dạng chuỗi
  String showDate(DateTime? date) {
    if (date == null) {
      return DateFormat.yMMMEd().format(DateTime.now());
    } else {
      return DateFormat.yMMMEd().format(date);
    }
  }

  /// Hàm chính để tạo hoặc cập nhật nhiệm vụ
  void isTaskAlreadyExistUpdateOrCreate() {
    // Lấy giá trị mới từ TextField
    String updatedTitle = widget.titleTaskController.text.trim();
    String updatedSubTitle = widget.descrptionTaskController.text.trim();

    // Kiểm tra xem tiêu đề hoặc mô tả có trống không
    if (updatedTitle.isEmpty || updatedSubTitle.isEmpty) {
      emptyWarning(context);
      print("Title or Subtitle is empty.");
      return;
    }

    if (widget.task != null) {
      try {
        // Cập nhật nhiệm vụ bằng cách tạo một nhiệm vụ mới và thay thế
        var newTask = Task.create(
          title: updatedTitle,
          subtitle: updatedSubTitle,
          createAtTime: time ?? widget.task!.createAtTime,
          createAtDate: date ?? widget.task!.createAtDate,
        );

        var box = Hive.box<Task>('taskBox');
        box.put(widget.task!.key, newTask); // Thay thế nhiệm vụ cũ bằng nhiệm vụ mới
        print("Task updated successfully.");
      } catch (e) {
        print("Error saving/updating task: $e");
        updateTaskWarning(context);
      }
    } else {
      // Tạo một nhiệm vụ mới
      var task = Task.create(
        title: updatedTitle,
        subtitle: updatedSubTitle,
        createAtTime: time ?? DateTime.now(),
        createAtDate: date ?? DateTime.now(),
      );

      var box = Hive.box<Task>('taskBox');
      box.add(task); // Thêm Task mới vào Hive
      print("New Task added successfully: ${task.title}");
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const AddTaskAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopside(textTheme), // Phần tiêu đề phía trên
              _buildMainTaskViewActivity(textTheme, context), // Phần chính của giao diện thêm/chỉnh sửa task
              _buildBottomSideButtons(), // Các nút ở phía dưới
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopside(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 100,
            child: Divider(thickness: 2),
          ),
          RichText(
            text: TextSpan(
              style: textTheme.titleLarge,
              text: widget.task == null ? AppStr.addNewTask : AppStr.updateCurrentTask,
              children: const [
                TextSpan(
                  text: AppStr.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 150,
            child: Divider(thickness: 2),
          ),
        ],
      ),
    );
  }

  /// Phần chính của giao diện thêm hoặc chỉnh sửa nhiệm vụ
  Widget _buildMainTaskViewActivity(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStr.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),
          RepTextField(
            controller: widget.titleTaskController,
            onFieldSubmitted: (String inputTitle) {
              setState(() {
                widget.titleTaskController.text = inputTitle;
              });
            },
            onChange: (String inputTitle) {
              setState(() {
                widget.titleTaskController.text = inputTitle;
              });
            },
          ),
          10.h,
          RepTextField(
            controller: widget.descrptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputSubTitle) {
              setState(() {
                widget.descrptionTaskController.text = inputSubTitle;
              });
            },
            onChange: (String inputSubTitle) {
              setState(() {
                widget.descrptionTaskController.text = inputSubTitle;
              });
            },
          ),
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    onChange: (DateTime newTime, List<int> selectedIndex) {
                      print("Time changed: $newTime");
                    },
                    dateFormat: "HH:mm",
                    onConfirm: (dateTime, _) {
                      setState(() {
                        time = dateTime;
                      });
                    },
                  ),
                ),
              );
            },
            title: AppStr.timeString,
            time: showTime(time),
            isTime: true,
          ),
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2030, 4, 5),
                minDateTime: DateTime.now(),
                initialDateTime: date ?? DateTime.now(),
                onConfirm: (dateTime, _) {
                  setState(() {
                    date = dateTime;
                  });
                },
              );
            },
            title: AppStr.dateString,
            time: showDate(date),
            isTime: false,
          ),
        ],
      ),
    );
  }

  // Các nút ở phía dưới (Xóa và Thêm/Cập nhật)
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: isTaskAlreadyExist() ? MainAxisAlignment.center : MainAxisAlignment.spaceEvenly,
        children: [
          if (widget.task != null)
            MaterialButton(
              onPressed: () {
                var box = Hive.box<Task>('taskBox');
                box.delete(widget.task!.key);
                Navigator.pop(context); // Trở lại màn hình trước đó
                print("Task deleted");
              },
              minWidth: 150,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: const [
                  Icon(Icons.close, color: AppColors.primaryColor),
                  Text(AppStr.deleteTask, style: TextStyle(color: AppColors.primaryColor)),
                ],
              ),
              height: 55,
            ),
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOrCreate();
              Navigator.pop(context); // Trở lại màn hình trước đó
              print("Task add/update process completed.");
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Text(
              widget.task == null ? AppStr.addTaskString : AppStr.updateTaskString,
              style: const TextStyle(color: Colors.white),
            ),
            height: 55,
          ),
        ],
      ),
    );
  }
}
