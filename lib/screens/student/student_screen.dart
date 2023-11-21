import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/loading.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/loading_snakebar.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/student/widgets/fee_popup.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/student/events/event_screen_student.dart';
import 'package:schoolapp/screens/student/tasks/student_tasks_screen.dart';
import 'package:schoolapp/screens/student/widgets/student_home_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_attendence_widget.dart';
import 'package:schoolapp/screens/teacher/school_events/school_events.dart';

class ScreenStudent extends StatefulWidget {
  const ScreenStudent({super.key});

  @override
  State<ScreenStudent> createState() => _ScreenStudentState();
}

late Stream<DocumentSnapshot<Object?>> studentstream;

class _ScreenStudentState extends State<ScreenStudent> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(FetchStudentDataEvent());
  }

  int totalWorkingDays = 0;
  String id = '';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StudentBloc, StudentState>(
      listener: (context, state) {
        if (state is FetchStudentDatasSuccessState) {
          id = state.studentId;
          totalWorkingDays = state.totalWorkingDaysCompleted;
          studentstream = state.studentstream;
          context
              .read<StudentBloc>()
              .add(StudentBottomNavigationEvent(currentPageIndex: 0));
        }
        if (state is UpdateStudentDataLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnakebarWidget());
        }
        if (state is UpdateStudentDataSuccessState) {
          AlertMessages().alertMessageSnakebar(
              context, 'Successfully Updated', Colors.green);
          Navigator.pop(context);
          context.read<StudentBloc>().add(FetchStudentDataEvent());
          tostudentHome(context);
        }
        if (state is UpdateStudentDataErrorState) {
          AlertMessages().alertMessageSnakebar(
              context, 'Something went wrong! Plese try again', Colors.red);
        }
        if (state is StudentActionsState) {
          if (state.index == 1) {
            tostudentHome(context);
            feePopupMessage(context: context);
          } else if (state.index == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  const ScreenStudentTasks(taskName: 'Home Work'),
            ));
          } else if (state.index == 2) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  const ScreenStudentTasks(taskName: 'Assignment'),
            ));
          } else if (state.index == 3) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ScreenEventsStudent(),
            ));
          }
        }
      },
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        if (state is StudentBottomNavigationState) {
          int currentPageIndex = state.currentPageIndex;
          return StreamBuilder<DocumentSnapshot>(
              stream: studentstream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingWidget().studentHomeLoading(size);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  Map<String, dynamic> studentData =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        "${studentData['first_name']} ${studentData['second_name']}",
                        style: appbarTextStyle,
                      ),
                      backgroundColor: appbarColor,
                      actions: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications_none_outlined,
                            ))
                      ],
                    ),
                    body: IndexedStack(
                      index: currentPageIndex,
                      children: <Widget>[
                        StudentHomeWidget(studentId: id, students: studentData),
                        const ApplicationWidget(isTeacher: false),
                        StudentAttendenceDetailsWidget(
                            size: size,
                            studentsMap: studentData,
                            totalWorkingDaysCompleted: totalWorkingDays),
                      ],
                    ),
                    bottomNavigationBar: NavigationBar(
                      onDestinationSelected: (int index) {
                        context.read<StudentBloc>().add(
                            StudentBottomNavigationEvent(
                                currentPageIndex: index));
                      },
                      indicatorColor: appbarColor,
                      selectedIndex: currentPageIndex,
                      destinations: const <Widget>[
                        NavigationDestination(
                          selectedIcon: Icon(
                            Icons.home,
                            color: headingColor,
                          ),
                          icon: Icon(
                            Icons.home_outlined,
                            color: headingColor,
                          ),
                          label: 'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(
                            Icons.assignment_outlined,
                            color: headingColor,
                          ),
                          selectedIcon: Icon(
                            Icons.assignment,
                            color: headingColor,
                          ),
                          label: 'Application',
                        ),
                        NavigationDestination(
                          icon: Icon(
                            Icons.calendar_month,
                            color: headingColor,
                          ),
                          selectedIcon: Icon(
                            Icons.assignment_turned_in_sharp,
                            color: headingColor,
                          ),
                          label: 'Attendence',
                        ),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.amber,
                    )),
                  );
                }
              });
        } else {
          return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.red,
            )),
          );
        }
      },
    );
  }
}
