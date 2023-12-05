// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/loading_snakebar.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/student/tasks/student_tasks_screen.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc2/teacher_second_bloc.dart';
import 'package:schoolapp/widgets/button_widget.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

final studentnoteController = TextEditingController();
bool isLoading = false;

class ScreenSubmitTask extends StatelessWidget {
  const ScreenSubmitTask({
    super.key,
    required this.widget,
    required this.name,
    required this.subject,
    required this.topic,
  });

  final ScreenStudentTasks widget;
  final String name;
  final String subject;
  final String topic;

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    bool isFileSelected = false;

    return Scaffold(
      appBar: myAppbar('Submit ${widget.taskName}'),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is SubmitWorkLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(
              loadingSnakebarWidget(),
            );
            isLoading = true;
          } else if (state is SubmitWorkSuccessState) {
            AlertMessages()
                .alertMessageSnakebar(context, 'Submitted', Colors.green);
            isLoading = false;
            isFileSelected = false;
            imageUrl = '';
            studentnoteController.text = '';
          } else if (state is SubmitWorkErrorState) {
            AlertMessages()
                .alertMessageSnakebar(context, 'Please try again', Colors.red);
            isLoading = false;
            isFileSelected = false;
            imageUrl = '';
          }
          if (state is LoadingState) {
            isFileSelected = state.isCompleted;
            state.isCompleted
                ? null
                : showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext dialogContext) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
          }
          if (state is FileUploadedState) {
            imageUrl = state.imageUrl;
          }
        },
        builder: (context, state) {
          return BlocConsumer<TeacherSecondBloc, TeacherSecondState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Row(
                      children: [
                        Expanded( 
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subject : $subject',
                                style: listViewTextStyle,
                              ),
                              Text(
                                'Topic : $topic',
                                style: listViewTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                          decoration: const InputDecoration(labelText: 'Notes'),
                          controller: studentnoteController,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        OutlinedButton(
                            onPressed: () =>
                                onChooseFile(imageUrl, context, isFileSelected),
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                const BorderSide(width: 2.0, color: titleColor),
                              ),
                            ),
                            child: Text('Upload ${widget.taskName}')),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(isFileSelected == true
                              ? 'file selected'
                              : 'No file selected !!'),
                        )
                      ],
                    ),
                  ),
                  ButtonSubmissionWidget(
                      label: 'send',
                      icon: Icons.send,
                      onTap: () {
                        isLoading
                            ? context.read<StudentBloc>().add(SubmitWorkEvent(
                                topic: topic,
                                subject: subject,
                                note: studentnoteController.text,
                                name: name,
                                imageUrl: imageUrl,
                                isHw: isHw))
                            : null;
                        isLoading = true;
                      }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

Future<void> onChooseFile(
    String imageUrl, BuildContext context, bool isFileSelected) async {
  String imageUrl = '';
  final file = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (file == null) {
    AlertMessages()
        .alertMessageSnakebar(context, 'No file selected!', Colors.red);
    isFileSelected = false;
    return;
  }

  String fileName = DateTime.now().microsecondsSinceEpoch.toString();
  Reference referenceRoot = FirebaseStorage.instance.ref();
  Reference referenceDireImage = referenceRoot.child('images');
  Reference referenceImageToUpload = referenceDireImage.child(fileName);
  context.read<StudentBloc>().add(LoadingEvent(isCompleted: isFileSelected));
  try {
    await referenceImageToUpload.putFile(File(file.path));
    imageUrl = await referenceImageToUpload.getDownloadURL();
    if (imageUrl != '') isFileSelected = true;
    context.read<StudentBloc>().add(LoadingEvent(isCompleted: isFileSelected));
  } catch (e) {
    log('$e');
    isFileSelected = false;
  } finally {
    context.read<StudentBloc>().add(FileUploadedEvent(imageUrl: imageUrl));
    Navigator.pop(context);
  }
}
