import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/firebase/admin/signup_admin_functions.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/screens/requests/admin_requests.dart';
import 'package:schoolapp/screens/student/studentlist_screen.dart';
import 'package:schoolapp/screens/teacher/teacher_profile_screen.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';

class ScreenAdmin extends StatelessWidget {
  const ScreenAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Principal',
          style: appbarTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<AdminBloc>().add(RequestTapEvent()),
            icon: const Icon(Icons.notifications_none),
          ),
        ],
        backgroundColor: appbarColor,
      ),
      body: BlocConsumer<AdminBloc, AdminState>(
        listenWhen: (previous, current) => current is AdminActionState,
        buildWhen: (previous, current) => current is! AdminActionState,
        listener: (context, state) {
          if (state is StudentCardTapState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenStudentList(),
                ));
          } else if (state is TeacherCardTapState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenTeacherProfile(),
                ));
          } else if (state is RequestTapState) {
            Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => const ScreenAdminResquest(),
                ));
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Teachers',
                    style: GoogleFonts.tiltNeon(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: headingColor)),
              ),
              StreamBuilder(stream: AdminActions().getTeacherDatas(), builder: (context, snapshot) { 
                if (snapshot.hasData) {
                   List teachersList = snapshot.data!.docs;
                   return SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: teachersList.length, 
                itemBuilder: (context, index) {
                  DocumentSnapshot document = teachersList[index]; 
                        String docId = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String teacherName = data['name'];       
                  return GestureDetector(
                    onTap: () =>
                        context.read<AdminBloc>().add(TeacherCardTapEvent()),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                                color: teacherListColor,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(5))),
                          ),
                          Positioned(
                            top: 10,
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: scaffoldColor,
                              backgroundImage: const AssetImage(
                                  'lib/assets/images/teacher.jpg'),
                            ),
                          ),
                          Positioned(
                              bottom: 55,
                              left: 0,
                              right: 0,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  height: 65,
                                  width: 130,
                                  decoration: BoxDecoration(
                                      color: scaffoldColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5))),
                                  child:  Column(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Name : $teacherName',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text("Class : ${data['class']}"), 
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  );
                },
              ),
              );
                } else {
                  return SizedBox(
                    child: Text('Empty'), 
                  );
                }
              },),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Students',
                    style: GoogleFonts.tiltNeon(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: headingColor)),
              ),
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () => context
                            .read<AdminBloc>()
                            .add(StudentCardTapEvent()),
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                              color: scaffoldColor,
                              border: Border.all(color: headingColor, width: 2),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  '${index + 1}',
                                  style: GoogleFonts.teko(
                                      fontSize: 45,
                                      letterSpacing: 3,
                                      fontWeight: FontWeight.bold,
                                      color: headingColor),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Class : ${index + 1}',
                                        style: contentTextStyle),
                                    Text('Total Students : 28',
                                        style: contentTextStyle),
                                    Flexible(
                                      child: Text('Class Teacher: Amal ',
                                          overflow: TextOverflow.ellipsis,
                                          style: contentTextStyle),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}