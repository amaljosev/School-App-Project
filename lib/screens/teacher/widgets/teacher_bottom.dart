import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/school_events/school_events.dart';
import 'package:schoolapp/screens/teacher/widgets/works_widget.dart';

class TeacherActions extends StatelessWidget {
  const TeacherActions({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listenWhen: (previous, current) => current is TeacherActionState,
      buildWhen: (previous, current) => current is! TeacherActionState,
      listener: (context, state) {
        if (state is SchoolEventsState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenSchoolEvents(),
              ));
        } else if (state is TeacherAssignmetState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ScreenWorks(workName: 'Assignments'),
              ));
        } else if (state is TeacherHomeWorkState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenWorks(workName: 'Home Works'),
              ));
        } else if (state is TeacherLeaveApplicationState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const ScreenWorks(workName: 'Leave Applications'),
              ));
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () =>
                        context.read<TeacherBloc>().add(SchoolEventsEvent()),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        width: size.width * 0.45,
                        height: 70,
                        decoration: BoxDecoration(
                          color: appbarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'Events',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        context.read<TeacherBloc>().add(TeacherLeaveApplicationEvent()), 
                    child: Card(
                      elevation: 8,
                      child: Container(
                        width: size.width * 0.45,
                        height: 70,
                        decoration: BoxDecoration(
                          color: appbarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'Leave Applications ',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  GestureDetector(
                    onTap: () => context
                        .read<TeacherBloc>()
                        .add(TeacherAssignmentEvent()),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        width: size.width * 0.45,
                        height: 70,
                        decoration: BoxDecoration(
                          color: appbarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'Assignments',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () =>
                        context.read<TeacherBloc>().add(TeacherHomeWorkEvent()), 
                    child: Card(
                      elevation: 8,
                      child: Container(
                        width: size.width * 0.45,
                        height: 70,
                        decoration: BoxDecoration(
                          color: appbarColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Text(
                            'HomeWorks',
                            style: appbarTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
