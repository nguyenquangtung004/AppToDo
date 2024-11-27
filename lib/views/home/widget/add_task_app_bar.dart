import 'package:flutter/material.dart';

class AddTaskAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AddTaskAppBar({super.key});

  @override
  State<AddTaskAppBar> createState() => _AddTaskAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150);
}

class _AddTaskAppBarState extends State<AddTaskAppBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GestureDetector(
                onTap:(){
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_rounded),),
            )
          ],
        ),
      ),
    );
  }
}
