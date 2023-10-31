import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/student/widgets/student_home_widget.dart';
import 'package:schoolapp/screens/teacher/profile/widgets/student_attendence_widget.dart';

class ScreenStudent extends StatefulWidget {
  const ScreenStudent({super.key});

  @override
  State<ScreenStudent> createState() => _ScreenStudentState();
}

class _ScreenStudentState extends State<ScreenStudent> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(BottomNavigationEvent(currentPageIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc, StudentState>(
      builder: (context, state) {
        final size = MediaQuery.of(context).size;
        if (state is BottomNavigationState) {
          int currentPageIndex = state.currentPageIndex;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Student',
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
                const StudentHomeWidget(),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.deepPurple,
                ),
                StudentAttendenceDetailsWidget(size: size),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                context
                    .read<StudentBloc>()
                    .add(BottomNavigationEvent(currentPageIndex: index));
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
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

class StudentActionWidget extends StatelessWidget {
  const StudentActionWidget({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}
