import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenStudentList extends StatelessWidget { 
  const ScreenStudentList({super.key,}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('class 1'),  
      body: SafeArea(
        child: SizedBox.expand(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 20, 
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ExpansionTile(
                collapsedBackgroundColor: appbarColor,
                backgroundColor: appbarColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(index % 2 == 0
                      ? 'lib/assets/images/student male.jpg'
                      : 'lib/assets/images/student female.png'),
                ),
                title: Text(
                  'name',
                  style: titleTextStyle,
                ),
                childrenPadding: const EdgeInsets.all(8),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'class',
                                  style: contentTextStyle,
                                ),
                                Text(
                                  'class teacher',
                                  style: contentTextStyle,
                                ),
                                Text(
                                  'email',
                                  style: contentTextStyle,
                                ),
                                Text(
                                  'age',
                                  style: contentTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
