import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class TeacherPrfileWidget extends StatefulWidget {
  const TeacherPrfileWidget({super.key, required this.size});
  final Size size;

  @override
  State<TeacherPrfileWidget> createState() => _TeacherPrfileWidgetState();
}

class _TeacherPrfileWidgetState extends State<TeacherPrfileWidget> {
  late Stream<DocumentSnapshot<Object?>> teacherDatas = const Stream.empty();

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchTeacherDatasEvent()); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherBloc, TeacherState>(
      listenWhen: (previous, current) => current is TeacherActionState,
      buildWhen: (previous, current) => current is! TeacherActionState,
      listener: (context, state) {
        if (state is FetchTeacherDataState) {
          teacherDatas = state.teacherDatas ?? const Stream.empty();
          context
              .read<TeacherBloc>()
              .add(BottomNavigationEvent(currentPageIndex: 0));
        }
      },
      builder: (context, state) {
        return StreamBuilder<DocumentSnapshot>(
            stream: teacherDatas,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.deepOrange,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                 Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
                return Column(
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(color: appbarColor),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: headingColor,
                              radius: 60,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    AssetImage('lib/assets/images/teacher.jpg'),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Text('${data!["name"]}'.toString().toUpperCase(),  
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.teko(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: headingColor)),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: widget.size.width,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            color: appbarColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Class Teacher of : ${data["class"]}",   
                                overflow: TextOverflow.ellipsis,
                                style: contentTextStyle),
                            Text('Email : ${data["email"]}', 
                                overflow: TextOverflow.ellipsis,
                                style: contentTextStyle),
                            Text('Mobile No : ${data["contact"]}', 
                                overflow: TextOverflow.ellipsis,
                                style: contentTextStyle),
                          ],
                        ),
                      ),
                    ),
                    const ButtonSubmissionWidget(
                        label: 'Edit', icon: Icons.edit),
                  ],
                );
              } else {
                return const SizedBox(
                  child: Text('Error'),
                );
              }
            });
      },
    );
  }
}
