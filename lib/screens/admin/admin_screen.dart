import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/firebase/admin/signup_admin_functions.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/screens/admin/settings/settings_admin.dart';
import 'package:schoolapp/screens/admin/widgets/classcard_widget.dart';
import 'package:schoolapp/screens/admin/widgets/teachercard_widget.dart';
import 'package:schoolapp/screens/requests/admin_requests.dart';
import 'package:schoolapp/screens/admin/widgets/studentlist_screen.dart';
import 'package:schoolapp/screens/admin/widgets/teacher_profile_screen.dart';


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
                  builder: (context) => ScreenStudentList(
                      studentData: state.studentList, standard: state.standard),
                ));
          } else if (state is TeacherCardTapState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenTeacherProfileAdmin(
                    teacherData: state.teacherData,
                  ),
                ));
          } else if (state is RequestTapState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenAdminResquest(),
                ));
          } if (state is SettingsState) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScreenSettingsAdmin(), 
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
              StreamBuilder(
                stream: AdminActions().getTeacherDatas(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        height: 250,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasData) {
                    List teachersList = snapshot.data!.docs;
                    if (teachersList.isNotEmpty) {
                      return TeacherCardWidget(teachersList: teachersList);
                    } else {
                      return const SizedBox(
                        height: 250,
                        child: Center(
                            child: Text('No Teachers has Registered yet')),
                      );
                    }
                  } else {
                    return const SizedBox(
                      height: 250,
                      child: Text('Empty'),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text('Students',
                    style: GoogleFonts.tiltNeon(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: headingColor)),
              ),
              StreamBuilder(
                  stream: AdminActions().getTeacherDatas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 250,
                          child: Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasData) {
                      List teachersList = snapshot.data!.docs;
                      if (teachersList.isNotEmpty) {
                        return ClassCardWidget(teachersList: teachersList);
                      } else {
                        return const SizedBox(
                          height: 250,
                          child: Center(child: Text('Classes not added')),
                        );
                      }
                    } else {
                      return const SizedBox(
                        height: 250,
                        child: Center(child: Text('error')),
                      );
                    }
                  })
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              context.read<AdminBloc>().add(FloatingActionButtonTapEvent()), 
          child: Icon(
            Icons.settings,
            color: buttonColor,
          )),
    );
  }

  
}
