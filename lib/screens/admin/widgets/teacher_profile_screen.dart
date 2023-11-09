import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/my_appbar.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/profile_head_widget.dart';

class ScreenTeacherProfileAdmin extends StatelessWidget {
  const ScreenTeacherProfileAdmin({super.key, required this.teacherData});
  final Map<String, dynamic> teacherData;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: myAppbar('Teacher Profile'),
      body: Column(
        children: [
          ProfileHeadWidget(
              image: 'lib/assets/images/teacher.jpg',
              name: teacherData['name']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: appbarColor,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Class Teacher of : ${teacherData['class']}",
                        overflow: TextOverflow.ellipsis, style: contentTextStyle),
                    Text('Email : ${teacherData['email']}',
                        overflow: TextOverflow.ellipsis, style: contentTextStyle),
                    Text('Mobile No : ${teacherData['contact']}',
                        overflow: TextOverflow.ellipsis, style: contentTextStyle),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: ListView.separated(
                  itemBuilder: (context, index) =>
                      Text('${index + 1} leave asked'),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
