import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/profile/student_profile.dart';
import 'package:schoolapp/screens/teacher/widgets/search_student_widget.dart';

class ScreenAllStudentsTeacher extends StatefulWidget {
  const ScreenAllStudentsTeacher({super.key});

  @override
  State<ScreenAllStudentsTeacher> createState() =>
      _ScreenAllStudentsTeacherState();
}

final textControllerSearch = TextEditingController();

class _ScreenAllStudentsTeacherState extends State<ScreenAllStudentsTeacher> {
  Stream<QuerySnapshot<Object?>> studentListStream = const Stream.empty();
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchAllStudentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listener: (context, state) {
        if (state is FetchAllStudentsSuccessState) {
          studentListStream = state.studentDatas;
        } else if (state is FetchAllStudentsLoadingState) {
          const CircularProgressIndicator(
            color: Colors.amber,
          );
        } else if (state is FetchAllStudentsErrorState) {
          AlertMessages().alertMessageSnakebar(
              context, 'Something went wrong Try again', Colors.red);
        } else if (state is StudentProfileState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenStudentProfileTeacher(
                  studentId: state.studentId,
                  studentFee: state.studentFee,
                  studentsMap: state.students,
                ),
              ));
        }
        if (state is SearchStudentScreenState) {
          Navigator.push( 
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ScreenSearchStudent(students: state.studentList),
              ));
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () => toTeacherHome(context),
          child: StreamBuilder<QuerySnapshot>(
              stream: studentListStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      child: Center(child: CircularProgressIndicator()));
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  List<DocumentSnapshot> students = snapshot.data!.docs;
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(
                        'All Students',
                        style: appbarTextStyle,
                      ),
                      backgroundColor: appbarColor,
                      actions: [
                        IconButton(
                            onPressed: () => context.read<TeacherBloc>().add(
                                SearchStudentScreenEvent(
                                    studentList: students)),
                            icon: const Icon(Icons.search))
                      ],
                    ),
                    body: ListView.separated(
                        itemBuilder: (context, index) {
                          DocumentSnapshot student = students[index];
                          var studentMap =
                              students[index].data() as Map<String, dynamic>;
                          final studentFee = students[index]
                              .reference
                              .collection('student_fee');
                          final String studentId = students[index].id;
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(student[
                                              'gender'] ==
                                          'Gender.male'
                                      ? 'lib/assets/images/student male.jpg'
                                      : 'lib/assets/images/student female.png')),
                              title: Text(
                                "${student['first_name']} ${student['second_name']}",
                                style: contentTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () => context.read<TeacherBloc>().add(
                                  StudentProfileEvent(
                                      studentId: studentId,
                                      students: studentMap,
                                      studentFee: studentFee)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: students.length),
                  );
                } else {
                  return const SizedBox(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }
              }),
        );
      },
    );
  }
}
