import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import '../../../../repositories/core/textstyle.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.formattedDate,
    required this.task,
    required this.subject,
    required this.deadline,
    required this.isHw,
  });

  final String formattedDate;
  final String task;
  final String subject;
  final String deadline;
  final bool isHw;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isHw?formattedDate:"Started on : $formattedDate", 
                style: const TextStyle(color: contentColor)),
            Text(isHw?"":"Deadline : $deadline", 
                style: const TextStyle(color: Colors.red)),
          ],
        ),
        title: Text(
          task,
          style: listViewTextStyle,
        ),
        subtitle: Text(
          subject,
          style: const TextStyle(color: contentColor),
        ),
      ),
    );
  }
}
