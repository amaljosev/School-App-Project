import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/form/newstudent_form.dart';
import 'package:schoolapp/screens/teacher/profile/student_profile.dart';

class TeacherStudentsList extends StatefulWidget {
  const TeacherStudentsList({
    super.key,
  });

  @override
  State<TeacherStudentsList> createState() => _TeacherStudentsListState();
}

class _TeacherStudentsListState extends State<TeacherStudentsList> {
  late Stream<QuerySnapshot<Object?>> studentDatasStream = const Stream.empty();
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchStudentDatasEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is FormStudentState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenStudentForm(),
              ));
        } else if (state is StudentProfileState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenStudentProfileTeacher(
                  studentFee: state.studentFee,
                  studentsMap: state.students,
                ),
              ));
        } else if (state is FetchStudentDatasState) {
          studentDatasStream = state.studetDatas;
          context
              .read<TeacherBloc>()
              .add(BottomNavigationEvent(currentPageIndex: 0));
        }
      },
      builder: (context, state) {
        return StreamBuilder(
            stream: studentDatasStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepOrange,
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                var students = snapshot.data?.docs;
                return SizedBox(
                    height: 130,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => context
                                    .read<TeacherBloc>()
                                    .add(FormStudentEvent()),
                                child: CircleAvatar(
                                  backgroundColor: appbarColor,
                                  radius: 40,
                                  child: const Icon(Icons.add,
                                      size: 40, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Add Student',
                                style: teacherAddStudentTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: const EdgeInsets.all(8.0),
                            scrollDirection: Axis.horizontal,
                            itemCount: students!.length,
                            itemBuilder: (context, index) {
                              var student = students[index].data()
                                  as Map<String, dynamic>;
                              final studentFee = students[index]
                                  .reference
                                  .collection('student_fee');
                              final studentGender = student['gender'];
                              final name = student['first_name'];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () => context
                                        .read<TeacherBloc>()
                                        .add(StudentProfileEvent(
                                            students: student,
                                            studentFee: studentFee)),
                                    child: CircleAvatar(
                                      backgroundColor: appbarColor,
                                      backgroundImage: AssetImage(studentGender ==
                                              'Gender.male'
                                          ? 'lib/assets/images/student male.jpg'
                                          : 'lib/assets/images/student female.png'),
                                      radius: 40,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    name,
                                    style: teacherAddStudentTextStyle,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 10,
                            ),
                          ),
                        ),
                      ],
                    ));
              } else {
                return const SizedBox(
                  child: Center(child: Text('error')),
                );
              }
            });
      },
    );
  }
}
