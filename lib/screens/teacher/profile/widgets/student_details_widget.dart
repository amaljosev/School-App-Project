import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class StudentDetailsWidget extends StatelessWidget {
  const StudentDetailsWidget({
    super.key,
    required this.isTeacher,
    required this.students,
    
  });
  final bool isTeacher;
  final Map<String, dynamic> students;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 270,
        width: double.infinity,
        decoration: BoxDecoration(
            color: isTeacher ? appbarColor : null,
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("RollNo :", style: studentProfileTextStyle),
                      Text('Class Teacher :', style: studentProfileTextStyle),
                      Text('Age :', style: studentProfileTextStyle),
                      Text('Class :', style: studentProfileTextStyle),
                      Text('RegisterNo :', style: studentProfileTextStyle),
                      Text('ContactNo :', style: studentProfileTextStyle),
                      Text('Guardian Name :', style: studentProfileTextStyle),
                      Text('Email :', style: studentProfileTextStyle), 
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" ${students['roll_no']}", style: studentProfileTextStyle),
                      Text("${students['class_Teacher']}" , style: studentProfileTextStyle),
                      Text("${students['age']} ", style: studentProfileTextStyle),
                      Text("${students['standard']} ", style: studentProfileTextStyle),
                      Text("${students['register_no']} ", style: studentProfileTextStyle),
                      Text("${students['contact_no']} ", style: studentProfileTextStyle),
                      Text("${students['guardian_name']} ", style: studentProfileTextStyle),
                      Text("${students['email']} ", style: studentProfileTextStyle), 
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: ButtonSubmissionWidget(label: 'Edit', icon: Icons.edit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
