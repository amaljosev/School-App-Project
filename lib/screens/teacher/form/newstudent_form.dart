import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/class_model.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/alert_diglogs.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/widgets/class_details.dart';
import 'package:schoolapp/widgets/text_field_widget.dart';

class ScreenStudentForm extends StatefulWidget {
  const ScreenStudentForm({super.key});

  @override
  State<ScreenStudentForm> createState() => _ScreenStudentFormState();
}

final firstNameController = TextEditingController();
final secondNameController = TextEditingController();
final rollNoController = TextEditingController();
final guardianNameController = TextEditingController();
final ageController = TextEditingController();
final registrationNumberController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();

enum Gender { male, female }

Gender? gender = Gender.female;
int totalStrength = 0;
int totalBoys = 0;
int totalGirls = 0;

class _ScreenStudentFormState extends State<ScreenStudentForm> {
  late Stream<DocumentSnapshot<Object?>> teacherDatas = const Stream.empty();

  @override
  void initState() {
    super.initState();
    context.read<TeacherBloc>().add(FetchTeacherDatasEvent());
  }

  @override
  Widget build(BuildContext context) {
    final studentFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context),
        child: BlocConsumer<TeacherBloc, TeacherState>(
          listener: (context, state) {
            if (state is AddStudentState) {
              AlertMessages().alertMessageSnakebar(
                  context, 'Student Created Successfully', Colors.green);
              AlertDialogWidgets().addStudentMessage(context);
            } else if (state is RadioButtonState) {
              gender = state.gender;
            } else if (state is FetchTeacherDataState) {
              teacherDatas = state.teacherDatas!;
            }
          },
          builder: (context, state) {
            return StreamBuilder<DocumentSnapshot>(
                stream: teacherDatas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox(
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    DocumentSnapshot<Object?> documentSnapshot = snapshot.data!;
                    Map<String, dynamic> data =
                        documentSnapshot.data() as Map<String, dynamic>? ?? {};
                    final String teacher = data['name'];
                    final String standard = data['class'];
                    totalStrength = classDatasGlobel?['total_students'] ?? '0';
                    totalBoys = classDatasGlobel?['total_boys'] ?? '0';
                    totalGirls = classDatasGlobel?['total_girls'] ?? '0';
                    return SafeArea(
                      child: Form(
                        key: studentFormKey,
                        child: ListView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          padding: const EdgeInsets.all(18),
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      context.read<TeacherBloc>().add(
                                          BottomNavigationEvent(
                                              currentPageIndex: 0));
                                    },
                                    icon: const Icon(Icons.arrow_back)),
                                const Padding(
                                  padding: EdgeInsets.only(left: 50.0),
                                  child: Center(
                                      child: Text('Add Student to Class',
                                          style: TextStyle(
                                              color: headingColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300))),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const CircleAvatar(
                              backgroundColor: headingColor,
                              radius: 60,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage(
                                    'lib/assets/images/student female.png'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.person_outline_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'First Name',
                                labelText: 'First Name',
                                controller: firstNameController,
                                keyboardType: TextInputType.name,
                                length: null,
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.person_add_alt_outlined,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Second Name',
                                labelText: 'Second Name',
                                controller: secondNameController,
                                keyboardType: TextInputType.name,
                                length: null,
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(
                                    Icons.format_list_numbered_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Roll No',
                                labelText: 'Roll No',
                                controller: rollNoController,
                                keyboardType: TextInputType.number,
                                length: 2,
                                obscureText: false),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.av_timer_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Age',
                                labelText: 'Age',
                                controller: ageController,
                                keyboardType: TextInputType.number,
                                length: 2,
                                obscureText: false),
                            SignUpTextFieldWidget(
                                icon:
                                    const Icon(Icons.list, color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Register No',
                                labelText: 'Register No',
                                controller: registrationNumberController,
                                keyboardType: TextInputType.number,
                                length: 6,
                                obscureText: false),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.mail_outline_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Email',
                                labelText: 'Email',
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                length: null,
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.phone_iphone_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Contact Number',
                                labelText: 'Contact Number',
                                controller: contactController,
                                keyboardType: TextInputType.number,
                                length: 10,
                                obscureText: false),
                            const SizedBox(
                              height: 5,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.people_outline,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: "Guardian's Name",
                                labelText: "Guardian's Name",
                                controller: guardianNameController,
                                keyboardType: TextInputType.name,
                                length: null,
                                obscureText: false),
                            const SizedBox(
                              height: 20,
                            ),
                            SignUpTextFieldWidget(
                                icon: const Icon(Icons.lock_outline_rounded,
                                    color: headingColor),
                                fillColor: appbarColor,
                                hintText: 'Password',
                                labelText: 'Password',
                                controller: passwordController,
                                keyboardType: TextInputType.emailAddress,
                                length: null,
                                obscureText: true),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Gender',
                                      style: titleTextStyle,
                                    ),
                                    Row(
                                      children: [
                                        Radio<Gender>(
                                          value: Gender.female,
                                          groupValue: gender,
                                          onChanged: (Gender? value) => context
                                              .read<TeacherBloc>()
                                              .add(RadioButtonEvent(
                                                  gender: value)),
                                        ),
                                        const Text('Female'),
                                        Radio<Gender>(
                                          value: Gender.male,
                                          groupValue: gender,
                                          onChanged: (Gender? value) => context
                                              .read<TeacherBloc>()
                                              .add(RadioButtonEvent(
                                                  gender: value)),
                                        ),
                                        const Text('Male'),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (studentFormKey.currentState!.validate()) {
                                  onCreate(context, teacher, standard);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  fixedSize: const Size(150, 50),
                                  elevation: 10),
                              child: const Text(
                                'Submit',
                                style: TextStyle(color: whiteTextColor),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox(
                      child: Center(child: Text('Something went wrong')),
                    );
                  }
                });
          },
        ),
      ),
    );
  }
}

void onCreate(BuildContext context, String teacher, String standard) {
  final studentObject = StudentModel(
      firstName: firstNameController.text,
      secondName: secondNameController.text,
      classTeacher: teacher,
      rollNo: rollNoController.text,
      age: ageController.text,
      registerNo: registrationNumberController.text,
      email: emailController.text,
      contactNo: contactController.text,
      guardianName: guardianNameController.text,
      password: passwordController.text,
      gender: gender.toString(),
      standard: standard,
      totalPresentDays: 0);
  if (gender == Gender.male) {
    totalBoys += 1;
  } else {
    totalGirls += 1;
  }
  final classObject = ClassModel(
      totalStudents: totalStrength += 1,
      totalBoys: totalBoys,
      totalGirls: totalGirls,
      classTeacher: teacher,
      standard: standard);

  context.read<TeacherBloc>().add(
      AddStudentEvent(studentData: studentObject, classDatas: classObject));

  firstNameController.text = '';
  secondNameController.text = '';
  rollNoController.text = '';
  guardianNameController.text = '';
  ageController.text = '';
  registrationNumberController.text = '';
  emailController.text = '';
  contactController.text = '';
  passwordController.text = '';
}
