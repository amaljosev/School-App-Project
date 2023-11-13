import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/widgets/button_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenSchoolEvents extends StatelessWidget {
  const ScreenSchoolEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Upcoming Events'),
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context),
        child: const SafeArea(
          child: ApplicationWidget(isTeacher: true),
        ),
      ),
    );
  }
}

class ApplicationWidget extends StatelessWidget {
  const ApplicationWidget({
    super.key,
    required this.isTeacher,
  });
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: appbarColor,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: isTeacher ? 'Title' : 'Date of Leave',
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  hintText: isTeacher ? 'Topic' : 'Reason',
                                  border: InputBorder.none,
                                  hintStyle: const TextStyle(fontSize: 20)),
                              maxLines: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const ButtonSubmissionWidget(
                  //   label: 'Share',
                  //   icon: Icons.send,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
