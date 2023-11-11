import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/widgets/add_task_widget.dart';
import 'package:schoolapp/screens/teacher/widgets/attendace_history_widget.dart';
import 'package:schoolapp/screens/teacher/widgets/home_page_widget.dart';
import 'package:schoolapp/screens/teacher/widgets/teacher_profile_widget.dart';

class ScreenTeacher extends StatefulWidget {
  const ScreenTeacher({super.key});

  @override
  State<ScreenTeacher> createState() => _ScreenTeacherState();
    
}

class _ScreenTeacherState extends State<ScreenTeacher> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(BottomNavigationEvent(currentPageIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<TeacherBloc, TeacherState>( 
      listener: (context, state) {},
      builder: (context, state) {
        if (state is BottomNavigationState) {
          int currentPageIndex = state.currentPageIndex;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Teacher',
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
                HomePageWidget(size: size),
                AddTaskWidget(
                  size: size,
                ),
                const AttendenceHistoryWidget(),
                TeacherProfileWidget(size: size),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                context
                    .read<TeacherBloc>()
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
                  label: 'Add Task',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.bar_chart_rounded,
                    color: headingColor,
                  ),
                  selectedIcon: Icon(
                    Icons.bar_chart,
                    color: headingColor,
                  ),
                  label: 'Staticstics',
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.person,
                    color: headingColor,
                  ),
                  icon: Icon(
                    Icons.person_outlined,
                    color: headingColor,
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          );
        } else {
          return const SizedBox(
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.cyan,
            )),
          );
        }
      },
    );
  }
}
