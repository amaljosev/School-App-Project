import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';

class StudentFeeWidget extends StatelessWidget {
  const StudentFeeWidget({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<StudentBloc>().add(FeeDetailsEvent()),   
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(15))),
        elevation: 5,
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              color: appbarColor,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Center(
              child: Text(
            name,
            style: contentTextStyle,
          )),
        ),
      ),
    );
  }
}
