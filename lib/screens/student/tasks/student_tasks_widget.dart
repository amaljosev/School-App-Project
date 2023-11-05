import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/screens/teacher/widgets/add_task_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenStudentTasks extends StatelessWidget {
  const ScreenStudentTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppbar('Student Tasks'),
      body: WillPopScope(
          onWillPop: () => tostudentHome(context),
          child: Column(
            children: [
              AddTaskWidget(size: size),
            ],
          )),
    );
  }
}
