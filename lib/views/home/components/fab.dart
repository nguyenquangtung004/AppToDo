import 'package:app_to_do/views/home/widget/layout_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../untils/app_colors.dart';

class Fab extends StatelessWidget {
  const Fab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //We will navigate to task by tapping on this button later one
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => const LayoutAdd(),
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
