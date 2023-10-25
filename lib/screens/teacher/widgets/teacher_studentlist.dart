
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class TeacherStudentsList extends StatelessWidget {
  const TeacherStudentsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 120,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: appbarColor,
                    radius: 40,
                    child: const Icon(Icons.add,
                        size: 40, color: Colors.white),
                  ),
                  Text(
                    'Add Student',
                    style: teacherAddStudentTextStyle,
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8.0),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: appbarColor,
                      backgroundImage: AssetImage(index % 2 == 0
                          ? 'lib/assets/images/student male.jpg'
                          : 'lib/assets/images/student female.png'),
                      radius: 40,
                    ),
                    Text(
                      'name',
                      style: teacherAddStudentTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  width: 10,
                ),
              ),
            ),
          ],
        ));
  }
}


