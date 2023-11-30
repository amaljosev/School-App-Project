import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/loading_snakebar.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/widgets/button_widget.dart';

final titileController = TextEditingController();
final topicController = TextEditingController();

class ApplicationWidget extends StatelessWidget { 
  const ApplicationWidget({
    super.key,
    required this.isTeacher,
  });
  final bool isTeacher;
  @override
  Widget build(BuildContext context) {
    final formFormKey = GlobalKey<FormState>();
    return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
      listener: (context, state) {
        if (state is TeacherNoticeLoadingState) {
          ScaffoldMessenger.of(context).showSnackBar(loadingSnakebarWidget());
        } else if (state is TeacherNoticeSuccessState) {
          AlertMessages().alertMessageSnakebar(context, 'Done', Colors.green);
          context.read<TeacherSecondBloc>().add(FetchFormDatasEvent()); 
        } else if (state is TeacherNoticeErrorState) {
          AlertMessages()
              .alertMessageSnakebar(context, 'Try Again', Colors.red);
        }
      },
      builder: (context, state) {
        return Form(
          key: formFormKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appbarColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isTeacher ? 'Create an Event or Notice' : 'Leave Application',   
                            style: titleTextStyle,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: InputDecoration(
                                      hintText:
                                          isTeacher ? 'Title' : 'Date of Leave',
                                    ),
                                    controller: titileController,
                                    validator: (value) =>
                                        titileController.text.isEmpty
                                            ? 'Please enter a title'
                                            : null,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                        hintText:
                                            isTeacher ? 'Topic' : 'Reason',
                                        border: InputBorder.none,
                                        hintStyle:
                                            const TextStyle(fontSize: 20)),
                                    controller: topicController,
                                    validator: (value) =>
                                        topicController.text.isEmpty
                                            ? 'Please enter a topic'
                                            : null,
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ButtonSubmissionWidget(
                          label: 'Share',
                          icon: Icons.send,
                          onTap: () {
                            if (formFormKey.currentState!.validate()) {
                              onShare(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onShare(BuildContext context) {
    context.read<TeacherSecondBloc>().add(TeacherNoticeEvent(
        title: titileController.text, topic: topicController.text));
    titileController.text = '';
    topicController.text = '';
  }
}
