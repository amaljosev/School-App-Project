import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/screens/teacher/tasks/widgets/task_card_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenWorks extends StatefulWidget {
  const ScreenWorks({super.key, required this.workName});
  final String workName;

  @override
  State<ScreenWorks> createState() => _ScreenWorksState();
}

class _ScreenWorksState extends State<ScreenWorks> {
  Stream<QuerySnapshot<Object?>> homeWorksListStream = const Stream.empty();
  @override
  void initState() {
    context.read<TeacherSecondBloc>().add(FetchHomeWorkDatasEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
      listener: (context, state) {
        if (state is FetchHomeWorkLoadingDatas) {
          const CircularProgressIndicator();
        } else if (state is FetchHomeWorkSuccessDatas) {
          homeWorksListStream = state.homeWorksData;
        } else if (state is FetchHomeWorkErrorDatas) {
          AlertMessages()
              .alertMessageSnakebar(context, 'Please try again', Colors.red);
        }
      },
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot<Object?>>(
            stream: homeWorksListStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                List<DocumentSnapshot> homeWorks = snapshot.data!.docs;
                return Scaffold(
                  appBar: myAppbar(widget.workName),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: List.generate(
                        homeWorks.length,
                        (index) {
                          DocumentSnapshot homeWork = homeWorks[index];
                          DateTime date =
                              (homeWork['date'] as Timestamp).toDate();
                          String formattedDate =
                              DateFormat('dd MMM yyyy').format(date);
                          final String task = '${homeWork['task']}';
                          final String subject = '${homeWork['subject']}';
                          return TaskCardWidget(
                              formattedDate: formattedDate,
                              task: task,
                              subject: subject,deadline: null,); 
                        },
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox(
                    child: Center(child: Text('Error: ${snapshot.error}')));
              }
            });
      },
    );
  }
}
