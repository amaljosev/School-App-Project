// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';

class DropDownStudentWidget extends StatelessWidget {
  DropDownStudentWidget({
    super.key,
    required this.subjectList,
    required this.index,
  });

  final List<String> subjectList;
  int index;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: subjectList.first,
      onSelected: (String? value) {
        index = subjectList.indexWhere((item) => item == value);

        return context
            .read<TeacherSecondBloc>()
            .add(TaskDropDownEvent(index: index, value: value));
      },
      dropdownMenuEntries:
          subjectList.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}