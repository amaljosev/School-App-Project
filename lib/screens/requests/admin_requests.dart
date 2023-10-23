import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/screens/requests/bloc/admin_request_bloc.dart';
import 'package:schoolapp/screens/teacher/teacher_profile_screen.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';

class ScreenAdminResquest extends StatelessWidget {
  const ScreenAdminResquest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Requests',
          style: appbarTextStyle,
        ),
        backgroundColor: appbarColor,
      ),
      body: BlocConsumer<AdminRequestBloc, AdminRequestState>(
        listenWhen: (previous, current) => current is AdminRequestActionState,
        buildWhen: (previous, current) => current is! AdminRequestActionState,
        listener: (context, state) {
          if (state is ViewTeacherState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenTeacherProfile(),
                ));
          }
        },
        builder: (context, state) {
          return StreamBuilder<QuerySnapshot>(
            stream: signUpRequest.getTeacherDatas(), 
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List teachersList = snapshot.data!.docs;

                return SizedBox(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = teachersList[index]; 
                        String docId = document.id;
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        String teacherName = data['name'];       
                        return ExpansionTile(
                          title: Text(teacherName),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                  onPressed: () => context
                                      .read<AdminRequestBloc>()
                                      .add(ViewTeacherEvent()),
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all<BorderSide>(
                                      BorderSide(
                                          width: 2.0, color: appbarColor),
                                    ),
                                  ),
                                  child: const Text(
                                    'View Profile',
                                    style: TextStyle(color: titleColor),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () =>context.read<AdminBloc>().add(AcceptButtonEvent(id: docId)), 
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green)),
                                  child: const Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.red)),
                                  child: const Text(
                                    'Reject',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: teachersList.length), 
                );
              } 
              else {
                return Center(child: const Text('teachers not found')); 
              }
            },
          );
        },
      ),
    );
  }
}
