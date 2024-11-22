import 'package:app_to_do/views/home/widget/add_task_app_bar.dart';
import 'package:flutter/material.dart';

class LayoutAdd extends StatefulWidget {
  const LayoutAdd({super.key});

  @override
  State<LayoutAdd> createState() => _LayoutAddState();
}

class _LayoutAddState extends State<LayoutAdd> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AddTaskAppBar(),
    );
  }
}
