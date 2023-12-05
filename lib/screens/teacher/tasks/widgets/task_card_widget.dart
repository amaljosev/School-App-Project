import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/teacher/tasks/submitted_tasks/submitted_task_screen.dart';
import '../../../../repositories/core/textstyle.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget(
      {super.key,
      required this.formattedDate,
      required this.task,
      required this.subject,
      required this.deadline,
      required this.isHw,
      required this.name,
      required this.image,
      required this.note,
      required this.isSubmitted});

  final String formattedDate;
  final String task;
  final String subject;
  final String deadline;
  final bool isHw;
  final bool isSubmitted;
  final String name;
  final String image;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                isHw
                    ? "Submitted on : $formattedDate"
                    : isSubmitted
                        ? "Submitted on : $formattedDate"
                        : "Started on : $formattedDate",
                style: TextStyle(
                    color: isSubmitted ? Colors.green : contentColor)),
            Text(
                isHw
                    ? isSubmitted
                        ? 'Check Now >'
                        : ""
                    : isSubmitted
                        ? "Check Now >"
                        : "",
                style: const TextStyle(color: contentColor)),
            isSubmitted
                ? const SizedBox()
                : Text(isHw ? "" : "Deadline : $deadline",
                    style: const TextStyle(color: Colors.red)),
          ],
        ),
        title: Text(
          isSubmitted ? name : task,
          style: listViewTextStyle,
        ),
        subtitle: Text(
          subject,
          style: const TextStyle(color: contentColor),
        ),
        onTap: () => isSubmitted
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenSubmittedTasksView(
                      formattedDate: formattedDate,
                      task: task,
                      subject: subject,
                      deadline: deadline,
                      isHw: isHw,
                      name: name,
                      image: image,
                      note: note,
                      isSubmitted: isSubmitted),
                ))
            : null,
      ),
    );
  }
}
