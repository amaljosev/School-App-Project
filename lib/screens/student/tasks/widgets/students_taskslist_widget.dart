import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/tasks/student_tasks_screen.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.widget,
  });

  final List<DocumentSnapshot<Object?>> tasks;
  final ScreenStudentTasks widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 5.0,
        right: 5.0,
      ),
      child: SizedBox(
        child: ListView(
          children: List.generate(tasks.length, (index) {
            if (tasks.isEmpty) {
              return Text(
                  'Given ${widget.taskName} are list here');
            } else {
              DocumentSnapshot work = tasks[index];
              DateTime date =
                  (work['date'] as Timestamp).toDate();
              String formattedDate =
                  DateFormat('dd MMM yyyy').format(date);
              String topic = '${work['task']}';
              String subject = '${work['subject']}';
              String assignmentDeadline = '';
              if (isHw == false) {
                DateTime date =
                    (work['deadline'] as Timestamp)
                        .toDate();
                assignmentDeadline =
                    DateFormat('dd MMM yyyy')
                        .format(date);
              }

              return Card(
                child: ListTile(
                  trailing: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                          isHw
                              ? formattedDate
                              : "Started on : $formattedDate",
                          style: const TextStyle(
                              color: contentColor)),
                      Text(
                          isHw
                              ? ""
                              : "Deadline : $assignmentDeadline",
                          style: const TextStyle(
                              color: Colors.red)),
                    ],
                  ),
                  title: Text(
                    topic,
                    style: listViewTextStyle,
                  ),
                  subtitle: Text(
                    subject,
                    style: const TextStyle(
                        color: contentColor),
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}