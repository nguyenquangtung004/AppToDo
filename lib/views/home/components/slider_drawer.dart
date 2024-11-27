import 'dart:math';

import 'package:app_to_do/extensions/space_exs.dart';
import 'package:app_to_do/untils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  /// Icons
  List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  /// Texts
  List<String> texts = [
    "Home",
    "Profile",
    "Settings",
    "Details",
  ];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 90),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: AppColors.primaryGradientColor, //Màu sắc background drawer
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://i.pinimg.com/236x/51/91/0b/51910b00a1d1e5594096de8b041040ce.jpg"),
            radius: 50,
          ),
          8.h,
          Text(
            "Nguyễn Quang Tùng ",
            style: textTheme.displayMedium,
          ),
          Text(
            "Lập trình viên flutter",
            style: textTheme.displaySmall,
          ),
          Container(
            //Khoảng cách từ header Drawer đến các nút bấm home
            margin: const EdgeInsets.symmetric(
              vertical: 30,
              horizontal: 10,

            ),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    print('${texts[index]} Đã Chọn');
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        texts[index],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
