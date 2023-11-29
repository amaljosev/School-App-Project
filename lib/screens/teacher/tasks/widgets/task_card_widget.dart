import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import '../../../../repositories/core/textstyle.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required this.formattedDate,
    required this.task,
    required this.subject, required this.deadline,
  });

  final String formattedDate;
  final String task;
  final String subject;
  final String? deadline;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Text(formattedDate,
            style: const TextStyle(color: contentColor)),
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