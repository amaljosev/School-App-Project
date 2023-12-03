import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';

class StudentActionWidget extends StatelessWidget {
  const StudentActionWidget({
    super.key,
    required this.name,
    required this.index,
    required this.assetPath,
  });
  final int index;
  final String name;
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<StudentBloc>()
          .add(StudentActionsEvent(index: index, name: name)),
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.all(Radius.circular(15))),
        elevation: 5,
        child: Container(
          height: 120,
          width: 130,
          decoration: BoxDecoration(
              color: appbarColor,
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(assetPath),
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                  color: appbarColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
              ),
              Text(
                name,
                style: contentTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
