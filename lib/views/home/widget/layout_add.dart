import 'package:app_to_do/extensions/space_exs.dart';
import 'package:app_to_do/models/task.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/views/home/widget/add_task_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_colors.dart';

import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:intl/intl.dart';

import '../components/date_time_selection.dart';
import '../components/rep_textfield.dart';

class LayoutAdd extends StatefulWidget {
  LayoutAdd(
      {super.key,
      this.task,
      required this.titleTaskController,
      required this.descrptionTaskController});
  final TextEditingController titleTaskController;
  final TextEditingController descrptionTaskController;
  final Task? task;
  @override
  State<LayoutAdd> createState() => _LayoutAddState();
}

class _LayoutAddState extends State<LayoutAdd> {
  var title;
  var subTitle;
  DateTime? time;
  DateTime? date;

  //Show Selected time as String Format
  String showTime(DateTime? time){
    if(widget.task?.createAtTime == null){
      if (time ==  null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      }else{
        return DateFormat('hh:mm a').format(time).toString();
      }
    }
    else{
      return DateFormat('hh:mm a').format(widget.task!.createAtTime).toString();
    }
  }

  //Show Selected time as String Format
  String showDate(DateTime? date){
    if (widget.task?.createAtDate == null) {
      if (date ==  null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      }else{
        return DateFormat.yMMMEd().format(date).toString();
      }
    }else{
        return DateFormat.yMMMEd().format(widget.task!.createAtDate).toString();
    }
  }
  //If any task already Exist return true otherwise false
  bool isTaskAlreadyExist() {
    if (widget.titleTaskController?.text == null &&
        widget.descrptionTaskController?.text == null) {
      return true;
    } else {
      return false;
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
              //Top Side Texts
              _buildTopside(textTheme),

              _buildMainTaskViewActivity(textTheme, context),
              //Bottom Side Buttons
              _buildBottomSideButtons()
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
            //Divider : dấu gạch ngang
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: TextSpan(
              style: textTheme.titleLarge,
              text: false ? AppStr.addNewTask : AppStr.updateCurrentTask,
              children: const [
                TextSpan(
                  text: AppStr.taskString,
                  style: TextStyle(fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 150,
            //Divider : dấu gạch ngang
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }

  ///Main Task View
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

          ///Task Title
          RepTextField(
            controller: widget.titleTaskController!,
            onFieldSubmitted: (String inputtitle) {
              title = inputtitle;
            },
            onChange: (String inputtitle) {
              title = inputtitle;
            },
          ),
          10.h,
          RepTextField(
            controller: widget.descrptionTaskController,
            isForDescription: true,
            onFieldSubmitted: (String inputsubtitle) {
              subTitle = inputsubtitle;
            },
            onChange: (String inputsubtitle) {
              subTitle = inputsubtitle;
            },
          ),

          ///Time Selection
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SizedBox(
                  height: 280,
                  child: TimePickerWidget(
                    onChange: (DateTime newTime, List<int> selectedIndex) {
                      print("Time changed: $newTime");
                      print("Selected Index: $selectedIndex");
                    },
                    dateFormat: "HH:mm",
                    onConfirm: (dateTime,________) {
                      setState(() {
                        if (widget.task?.createAtTime == null ) {
                          time = dateTime;
                        }else{
                          widget.task!.createAtTime = dateTime;
                        }
                      });
                    },
                  ),
                ),
              );
            },
            title: AppStr.timeString,
            time:showTime(time),
          ),

          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(context,
                  maxDateTime: DateTime(2030, 4, 5),
                  minDateTime: DateTime.now(),
                  // initialDateTime: ,
                  onConfirm: (dateTime, ___________) {
                    setState(() {
                        if (widget.task?.createAtDate == null ) {
                          date = dateTime;
                        }else{
                          widget.task!.createAtDate = dateTime;
                        }
                      });
                  });
            },
            title: AppStr.dateString, time: showDate(date),
          ),
        ],
      ),
    );
  }

  //Bottom Side Buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Delete Current Task Button
          MaterialButton(
            onPressed: () {
              print("Delete Task");
            },
            minWidth: 150,
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                const Icon(
                  Icons.close,
                  color: AppColors.primaryColor,
                ),
                const Text(
                  AppStr.deleteTask,
                  style: TextStyle(color: AppColors.primaryColor),
                )
              ],
            ),
            height: 55,
          ),

          //Add or Update
          MaterialButton(
            onPressed: () {
              print("New Task Has Been Added");
              //Add or Update TaskActivity
            },
            minWidth: 150,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Text(
                  AppStr.addTaskString,
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            height: 55,
          ),
        ],
      ),
    );
  }
}
