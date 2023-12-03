import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/tasks/student_tasks_screen.dart';
import 'package:schoolapp/screens/student/tasks/submit_task_screen.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({
    super.key,
    required this.tasks,
    required this.widget,
    required this.name, required this.isSubmitted,
  });

  final List<DocumentSnapshot<Object?>> tasks;
  final ScreenStudentTasks widget;
  final String name;
  final bool isSubmitted;

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
              return Text('Given ${widget.taskName} are list here');
            } else {
              DocumentSnapshot work = tasks[index];
              DateTime date = (work['date'] as Timestamp).toDate();
              String formattedDate = DateFormat('dd MMM yyyy').format(date);
              String topic =isSubmitted? '${work['note']}': '${work['task']}'; 
              String subject = '${work['subject']}';
              String assignmentDeadline = ''; 
              if (isHw == false&&isSubmitted==false) {
                DateTime date = (work['deadline'] as Timestamp).toDate();
                assignmentDeadline = DateFormat('dd MMM yyyy').format(date); 
              }

              return Card(
                child: ListTile(
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isHw ? formattedDate :isSubmitted?'': "Started on : $formattedDate",
                          style: const TextStyle(color: contentColor)),
                      Text(isHw ? "" :isSubmitted?"subimtted on : $formattedDate": "Deadline : $assignmentDeadline",
                          style:  TextStyle(color:isSubmitted?Colors.green: Colors.red)), 
                       Text(isSubmitted?'':"Tap to Submit > ",  
                          style: const TextStyle(
                              color: Colors.green, fontSize: 15)),
                    ],
                  ),
                  title: Text(
                    topic,
                    style: listViewTextStyle,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: const TextStyle(color: contentColor),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenSubmitTask(
                          widget: widget,
                          name: name,
                        ),
                      )),
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
