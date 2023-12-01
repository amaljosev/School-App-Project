import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/screens/teacher/tasks/widgets/task_card_widget.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class ScreenStudentTasks extends StatefulWidget {
  const ScreenStudentTasks({super.key, required this.taskName});
  final String taskName;

  @override
  State<ScreenStudentTasks> createState() => _ScreenStudentTasksState();
}

bool isHw = false;

class _ScreenStudentTasksState extends State<ScreenStudentTasks> {
  Stream<QuerySnapshot<Object?>> taskListStream = const Stream.empty();

  @override
  void initState() {
    super.initState();
    isHw = widget.taskName == 'Home Work';
    context.read<TeacherSecondBloc>().add(FetchTaskDatasEvent(isHw: isHw));
  }

  @override
  Widget build(BuildContext context) {
    const List<String> subjectList = <String>[
      'English',
      'Physics',
      'Maths',
      'Chemistry',
      'Hindi',
      'Social Science',
      'Science'
    ];
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
      },
      builder: (context, state) {
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
                  return dateB.compareTo(dateA);
                });
                return DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: WillPopScope(
                    onWillPop: () => tostudentHome(context),
                    child: Scaffold(
                      appBar: AppBar(
                        backgroundColor: appbarColor,
                        title: Text(widget.taskName, style: appbarTextStyle),
                        bottom: TabBar(
                          tabs: <Widget>[
                            Tab(
                              icon: const Icon(Icons.assignment),
                              text: widget.taskName,
                            ),
                            Tab(
                              icon: const Icon(Icons.save_as_sharp),
                              text: 'Submit ${widget.taskName}',
                            ),
                          ],
                        ),
                      ),
                      body: TabBarView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10.0,
                              left: 5.0,
                              right: 5.0,
                            ),
                            child: SizedBox(
                              child: ListView(
                                children: List.generate(tasks.length, (index) {
                                  if (tasks.isEmpty) {
                                    return Text(
                                        'Given ${widget.taskName} are list here');
                                  } else {
                                    DocumentSnapshot work = tasks[index];
                                    DateTime date =
                                        (work['date'] as Timestamp).toDate();
                                    String formattedDate =
                                        DateFormat('dd MMM yyyy').format(date);
                                    String topic = '${work['task']}';
                                    String subject = '${work['subject']}';
                                    String assignmentDeadline = '';
                                    if (isHw == false) {
                                      DateTime date =
                                          (work['deadline'] as Timestamp)
                                              .toDate();
                                      assignmentDeadline =
                                          DateFormat('dd MMM yyyy')
                                              .format(date);
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
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'Select Subject',
                                    style: contentTextStyle,
                                  ),
                                  DropdownMenu<String>(
                                    initialSelection: subjectList.first,
                                    onSelected: (String? value) {
                                      // This is called when the user selects an item.
                                      // setState(() {
                                      //   // dropdownValue = value!;
                                      // });
                                    },
                                    dropdownMenuEntries: subjectList
                                        .map<DropdownMenuEntry<String>>(
                                            (String value) {
                                      return DropdownMenuEntry<String>(
                                          value: value, label: value);
                                    }).toList(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                          labelText: 'Task',
                                          hintText: 'eg: Complete Activity 5'),
                                      maxLines: 5,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    OutlinedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            const BorderSide(
                                                width: 2.0, color: titleColor),
                                          ),
                                        ),
                                        child:
                                            Text('Upload ${widget.taskName}')),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('No file selected !!'),
                                    )
                                  ],
                                ),
                              ),
                              ButtonSubmissionWidget(
                                label: 'send',
                                icon: Icons.send,
                                onTap: () {},
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        const ListTile(title: Text('data')),
                                    itemCount: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox(
                    child: Center(child: Text('Something went wrong')));
              }
            });
      },
    );
  }
}
