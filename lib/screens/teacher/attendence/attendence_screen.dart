import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

class ScreenAttendence extends StatefulWidget {
  const ScreenAttendence({super.key});

  @override
  State<ScreenAttendence> createState() => _ScreenAttendenceState();
}

class _ScreenAttendenceState extends State<ScreenAttendence> {
  Stream<QuerySnapshot<Object?>> studentListStream = const Stream.empty();
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchAllStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => toTeacherHome(context),
      child: BlocConsumer<TeacherBloc, TeacherState>(
        listener: (context, state) {
          if (state is FetchAllStudentsSuccessState) {
            studentListStream = state.studentDatas;
          } else if (state is FetchAllStudentsLoadingState) {
            const CircularProgressIndicator();
          } else if (state is FetchAllStudentsErrorState) {
            AlertMessages().alertMessageSnakebar(
                context, 'Something went wrong Try again', Colors.red);
          }
        },
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
              stream: studentListStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<DocumentSnapshot> students = snapshot.data!.docs;
                  students.sort((a, b) {
                    String nameA = "${a['first_name']} ${a['second_name']}";
                    String nameB = "${b['first_name']} ${b['second_name']}";
                    return nameA.compareTo(nameB);
                  });
                  return Scaffold( 
                    appBar: AppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            context.read<TeacherBloc>().add(
                                BottomNavigationEvent(currentPageIndex: 0));
                          },
                          icon: const Icon(Icons.arrow_back)),
                      backgroundColor: appbarColor,
                      title: Text(
                        'Attendence',
                        style: titleTextStyle,
                      ),
                      actions: [
                        TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.save),
                            label: const Text('Submit'))
                      ],
                    ),
                    body: Column(
                      children: [
                        Container(
                          height: 50,
                          decoration: BoxDecoration(color: appbarColor),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Roll No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: contentColor),
                                ),
                              ),
                              Text(
                                'Student Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: contentColor),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  'Present',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: contentColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                DocumentSnapshot student = students[index];
                                return ListTile(
                                  leading: Text('${index + 1}'),
                                  title: Text(
                                    "${student['first_name']} ${student['second_name']}",
                                    style: contentTextStyle,
                                  ),
                                  trailing: Checkbox(
                                    value: true,
                                    onChanged: (value) {},
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: students.length),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('Something went wrong Try again');
                }
              });
        },
      ),
    );
  }
}
