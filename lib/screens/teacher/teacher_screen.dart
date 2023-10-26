import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/widgets/home_page_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenTeacher extends StatefulWidget {
  const ScreenTeacher({super.key});

  @override
  State<ScreenTeacher> createState() => _ScreenTeacherState();
}

const List<String> subjectList = <String>[
  'English',
  'Physics',
  'Maths',
  'Chemistry',
  'Hindi',
  'Social Science',
  'Science'
];

class _ScreenTeacherState extends State<ScreenTeacher> {
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(BottomNavigationEvent(currentPageIndex: 0));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is BottomNavigationState) {
          int currentPageIndex = state.currentPageIndex;
          return Scaffold(
            appBar: myAppbar('Teacher'),
            body: IndexedStack(
              index: currentPageIndex,
              children: <Widget>[
                HomePageWidget(size: size),
                SingleChildScrollView(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(
                              text: 'Home Work',
                            ),
                            Tab(
                              text: 'Assignment',
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: size.height * 0.70,
                            child: TabBarView(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Select Subject',
                                          style: contentTextStyle,
                                        ),
                                        DropdownMenu<String>(
                                          initialSelection: subjectList.first,
                                          onSelected: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              // dropdownValue = value!;
                                            });
                                          },
                                          dropdownMenuEntries: subjectList
                                              .map<DropdownMenuEntry<String>>(
                                                  (String value) {
                                            return DropdownMenuEntry<String>(
                                                value: value, label: value);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                labelText: 'Task',
                                                hintText:
                                                    'eg: Complete Activity 5'),
                                            maxLines: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
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
                                            style: TextStyle(
                                                color: whiteTextColor),
                                          )),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Select Subject',
                                          style: contentTextStyle,
                                        ),
                                        DropdownMenu<String>(
                                          initialSelection: subjectList.first,
                                          onSelected: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              // dropdownValue = value!;
                                            });
                                          },
                                          dropdownMenuEntries: subjectList
                                              .map<DropdownMenuEntry<String>>(
                                                  (String value) {
                                            return DropdownMenuEntry<String>(
                                                value: value, label: value);
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Set a Expiry Date',
                                          style: contentTextStyle,
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: () => datePicker(),
                                          icon: const Icon(Icons.date_range),
                                          label: const Text(' Calender'),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                labelText: 'Task',
                                                hintText:
                                                    'eg: Complete Activity 5'),
                                            maxLines: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 18.0),
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
                                            style: TextStyle(
                                                color: whiteTextColor),
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Text('Page 3'),
                ),
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
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  datePicker() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return SizedBox(
          height: 555,
          width: 500,
          child: child,
        );
      },
    );
  }
}
