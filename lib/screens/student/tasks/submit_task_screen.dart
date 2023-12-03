import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/student/tasks/student_tasks_screen.dart';
import 'package:schoolapp/screens/student/tasks/widgets/dropdown_widget.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/widgets/button_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

final studentTaskController = TextEditingController();
String? dropDownValue;
bool isLoading = false;

class ScreenSubmitTask extends StatelessWidget {
  const ScreenSubmitTask({
    super.key,
    required this.widget,
    required this.name,
  });

  final ScreenStudentTasks widget;
  final String name;

  @override
  Widget build(BuildContext context) {
    const List<String> subjectList = <String>[
      'English',
      'Physics',
      'Maths',
      'Chemistry',
      'Hindi',
      'Social Science',
      'Science'
    ];
    return Scaffold(
      appBar: myAppbar('Submit ${widget.taskName}'),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is SubmitWorkLoadingState) {
            const CircularProgressIndicator();
          } else if (state is SubmitWorkSuccessState) {
            AlertMessages()
                .alertMessageSnakebar(context, 'Submitted', Colors.green);
            isLoading = false;
          } else if (state is SubmitWorkErrorState) {
            AlertMessages()
                .alertMessageSnakebar(context, 'Please try again', Colors.red);
            isLoading = false;
          }
        },
        builder: (context, state) {
          return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
            listener: (context, state) {
              if (state is HomeWorkDropDownState) {
                index = state.index;
                dropDownValue = state.value;
                log('$dropDownValue');
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Select Subject',
                        style: contentTextStyle,
                      ),
                      DropDownStudentWidget(
                          index: index, subjectList: subjectList),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: 'Notes'),
                          controller: studentTaskController,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                const BorderSide(width: 2.0, color: titleColor),
                              ),
                            ),
                            child: Text('Upload ${widget.taskName}')),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('No file selected !!'),
                        )
                      ],
                    ),
                  ),
                  ButtonSubmissionWidget(
                      label: 'send',
                      icon: Icons.send,
                      onTap: () {
                        isLoading
                            ? context.read<StudentBloc>().add(SubmitWorkEvent(
                                subject: dropDownValue ?? subjectList.first,
                                note: studentTaskController.text,
                                name: name,
                                isHw: isHw))
                            : null;
                        isLoading = true;
                      }),
                  Expanded(
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            const ListTile(title: Text('data')),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
