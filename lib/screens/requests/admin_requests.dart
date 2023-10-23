import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/screens/requests/bloc/admin_request_bloc.dart';
import 'package:schoolapp/screens/teacher/teacher_profile_screen.dart';

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
          return SizedBox(
            child: ListView.separated(
                itemBuilder: (context, index) => ExpansionTile(
                      title: const Text('teacher name'),
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
                                  BorderSide(width: 2.0, color: appbarColor),
                                ),
                              ),
                              child: const Text(
                                'View Profile',
                                style: TextStyle(color: titleColor),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.green)),
                              child: const Text(
                                'Accept',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: const Text(
                                'Reject',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: 10),
          );
        },
      ),
    );
  }
}
