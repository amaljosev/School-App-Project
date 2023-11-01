import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

class ScreenAttendence extends StatelessWidget {
  const ScreenAttendence({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( 
            onPressed: () {
              Navigator.of(context).pop();
              context
                  .read<TeacherBloc>()
                  .add(BottomNavigationEvent(currentPageIndex: 0));
            },
            icon: const Icon(Icons.arrow_back)),
        backgroundColor: appbarColor,
        title: Text(
          'Attendence',
          style: titleTextStyle,
        ),
        actions: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.save),
              label: const Text('Submit'))
        ],
      ),
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context), 
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(color: appbarColor),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Roll No',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: contentColor),
                    ),
                  ),
                  Text(
                    'Student Name',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: contentColor),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Text(
                      'Present',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: contentColor),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                        leading: Text('${index + 1}'),
                        title: const Text('Student Name'),
                        trailing: Checkbox(
                          value: true,
                          onChanged: (value) {},
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 30),
            ),
          ],
        ),
      ),
    );
  }
}
