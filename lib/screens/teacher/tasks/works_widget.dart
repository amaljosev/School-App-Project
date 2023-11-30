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

bool isHw = false;

class _ScreenWorksState extends State<ScreenWorks> {
  Stream<QuerySnapshot<Object?>> taskListStream = const Stream.empty();

  @override
  void initState() {
    isHw = widget.workName == 'Home Works' ? true : false;
    context.read<TeacherSecondBloc>().add(FetchTaskDatasEvent(isHw: isHw));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
        listener: (context, state) {
      if (state is FetchTaskLoadingDatas) {
        const CircularProgressIndicator();
      } else if (state is FetchTaskSuccessDatas) {
        taskListStream = state.taskData;
      } else if (state is FetchTaskErrorDatas) {
        AlertMessages()
            .alertMessageSnakebar(context, 'Please try again', Colors.red);
      }
    }, builder: (context, state) {
      return StreamBuilder<QuerySnapshot<Object?>>(
        stream: taskListStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
                child: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<DocumentSnapshot> tasks = snapshot.data!.docs;
            tasks.sort((a, b) {
              DateTime dateA = (a['date'] as Timestamp).toDate();
              DateTime dateB = (b['date'] as Timestamp).toDate();
              return dateA.compareTo(dateB);
            });
            return Scaffold(
              appBar: myAppbar(widget.workName),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: List.generate(tasks.length, (index) {
                    if (tasks.isEmpty) {
                      return Text('Given ${widget.workName} are list here');
                    } else {
                      DocumentSnapshot work = tasks[index];
                      DateTime date = (work['date'] as Timestamp).toDate();
                      String formattedDate =
                          DateFormat('dd MMM yyyy').format(date);
                      String topic = '${work['task']}';
                      String subject = '${work['subject']}';
                      String assignmentDeadline = '';
                      if (isHw == false) {
                        DateTime date =
                            (work['deadline'] as Timestamp).toDate();
                        assignmentDeadline =
                            DateFormat('dd MMM yyyy').format(date);
                      }

                      return TaskCardWidget(
                        formattedDate: formattedDate,
                        task: topic,
                        subject: subject,
                        deadline: assignmentDeadline,
                        isHw: isHw,
                      );
                    }
                  }),
                ),
              ),
            );
          } else {
            return SizedBox(
                child: Center(child: Text('Error: ${snapshot.error}')));
          }
        },
      );
    });
  }
}
