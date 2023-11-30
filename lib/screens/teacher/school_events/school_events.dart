import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/widgets/application_form.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenSchoolEvents extends StatefulWidget {
  const ScreenSchoolEvents({super.key});

  @override
  State<ScreenSchoolEvents> createState() => _ScreenSchoolEventsState();
}

class _ScreenSchoolEventsState extends State<ScreenSchoolEvents> {
  Stream<QuerySnapshot<Object?>> formStream = const Stream.empty();

  @override
  void initState() {
    context.read<TeacherSecondBloc>().add(FetchFormDatasEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
      listener: (context, state) {
        if (state is FetchFormDatasLoadingState) {
          const CircularProgressIndicator();
        } else if (state is FetchFormDatasSuccessDatas) {
          formStream = state.formData;
        } else if (state is FetchFormDatasErrorState) {
          AlertMessages()
              .alertMessageSnakebar(context, 'Please try again', Colors.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: myAppbar('Upcoming Events'),
            body: StreamBuilder<QuerySnapshot<Object?>>(
                stream: formStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    List<DocumentSnapshot> formDatas = snapshot.data!.docs;
                    formDatas.sort((a, b) {
                      DateTime dateA = (a['date'] as Timestamp).toDate();
                      DateTime dateB = (b['date'] as Timestamp).toDate();
                      return dateB.compareTo(dateA);
                    });

                    return SafeArea(
                      child: Column(
                        children: [
                          const ApplicationWidget(isTeacher: true),
                          Expanded(
                              child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 5, right: 5),
                                itemBuilder: (context, index) {
                                  DocumentSnapshot data = formDatas[index];
                                  DateTime date =
                                      (data['date'] as Timestamp).toDate();
                                  String formattedDate =
                                      DateFormat('dd MMM yyyy').format(date);
                                  String title = '${data['title']}';
                                  String topic = '${data['topic']}';
                                  return Card(
                                    color: appbarColor,
                                    child: ListTile(
                                      title:
                                          Text(title, style: listViewTextStyle),
                                      subtitle: Text(
                                        topic,
                                        style: const TextStyle(
                                            color: contentColor),
                                      ),
                                      trailing: Text(
                                        formattedDate,
                                        style: const TextStyle(
                                            color: contentColor),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: formDatas.length),
                          )),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox(
                        child: Center(child: Text('Error: ${snapshot.error}')));
                  }
                }));
      },
    );
  }
}
