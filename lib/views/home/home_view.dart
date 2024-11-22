import 'package:app_to_do/untils/app_colors.dart';
import 'package:app_to_do/views/home/widget/fab.dart';
import 'package:flutter/material.dart';
import 'package:app_to_do/untils/app_str.dart';
import 'package:app_to_do/extensions/space_exs.dart';
import 'package:hive/hive.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
              child: ListView.builder(
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.3),
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
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      title: Text(
                        "Done",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
