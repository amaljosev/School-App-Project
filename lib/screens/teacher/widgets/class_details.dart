import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/attendence/attendence_screen.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

class ClassDetailsWidget extends StatefulWidget {
  const ClassDetailsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<ClassDetailsWidget> createState() => _ClassDetailsWidgetState();
}

class _ClassDetailsWidgetState extends State<ClassDetailsWidget> {
  late Stream<QuerySnapshot<Object?>> classDatas = const Stream.empty();
  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchClassDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listenWhen: (previous, current) => current is TeacherActionState,
      buildWhen: (previous, current) => current is! TeacherActionState,
      listener: (context, state) {
        if (state is AttendenceState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScreenAttendence(),
              ));
        }
        if (state is FetchClassDetailsState) {
          classDatas = state.classDatas;
        }
      },
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot>(
            stream: classDatas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                QueryDocumentSnapshot document = documents.first;
                Map<String, dynamic>? data = 
                    document.data() as Map<String, dynamic>; 
                return Center(
                  child: Container(
                    height: 200,
                    width: widget.size.width * 0.97,
                    decoration: BoxDecoration(
                        color: appbarColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "class : ${data['standard']}",  
                                style: appbarTextStyle,
                              ),
                              Text(
                                'Class Strength : ${data['total_students']}', 
                                style: contentTextStyle,
                              ),
                              Text(
                                'Boys : ${data['total_boys']}',
                                style: contentTextStyle,
                              ),
                              Text(
                                'Girls : ${data['total_girls']}',
                                style: contentTextStyle,
                              ),
                              Text(
                                'Today Presents :26', 
                                style: contentTextStyle,
                              ),
                              Text(
                                'Today Absents : 4',
                                style: contentTextStyle,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: ElevatedButton(
                              onPressed: () => context
                                  .read<TeacherBloc>()
                                  .add(AttendenceEvent()),
                              child: const Text('Take Attendence')),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                  child: Center(child: Text('Something went wrong')),
                );
              }
            });
      },
    );
  }
}
