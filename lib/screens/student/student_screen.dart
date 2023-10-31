import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/teacher/widgets/calender_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

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
                Container(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: CircleAvatar(
                          backgroundColor: headingColor,
                          radius: 60,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage(
                                'lib/assets/images/student female.png'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: appbarColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text("RollNo :",
                                            style: studentProfileTextStyle),
                                        Text('Name :',
                                            style: studentProfileTextStyle),
                                        Text('Age :',
                                            style: studentProfileTextStyle),
                                        Text('Class :',
                                            style: studentProfileTextStyle),
                                        Text('RegisterNo :',
                                            style: studentProfileTextStyle),
                                        Text('ContactNo :',
                                            style: studentProfileTextStyle),
                                        Text('Guardian Name :',
                                            style: studentProfileTextStyle),
                                        Text('Email :',
                                            style: studentProfileTextStyle),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(" 1",
                                            style: studentProfileTextStyle),
                                        Text(' Akhila',
                                            style: studentProfileTextStyle),
                                        Text(' 22',
                                            style: studentProfileTextStyle),
                                        Text(' 5',
                                            style: studentProfileTextStyle),
                                        Text(' 1965478',
                                            style: studentProfileTextStyle),
                                        Text(' 97584685321',
                                            style: studentProfileTextStyle),
                                        Text(' shaji',
                                            style: studentProfileTextStyle),
                                        Text(' diljith@gmail.com',
                                            style: studentProfileTextStyle),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: buttonColor,
                                          shape:
                                              const ContinuousRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                          ),
                                          fixedSize: const Size(100, 30),
                                          elevation: 10),
                                      onPressed: () {},
                                      icon: const Icon(Icons.edit,
                                          color: whiteTextColor),
                                      label: const Text(
                                        'Edit',
                                        style: TextStyle(color: whiteTextColor),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              StudentActionWidget(name: 'HW'),
                              SizedBox(
                                height: 20,
                              ),
                              StudentActionWidget(
                                name: 'Assignment',
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              StudentActionWidget(name: 'Fee Details'),
                              SizedBox(
                                height: 20,
                              ),
                              StudentActionWidget(name: 'Events'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.deepPurple,
                ),
                Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.greenAccent,
                ),
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
