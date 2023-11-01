import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenWorks extends StatelessWidget {
  const ScreenWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Assignment'), 
      body: WillPopScope(
          onWillPop: () => toTeacherHome(context),
          child: const Center(
              child: Text('Student Sumitted tasks are show here'))),
    );
  }
}
