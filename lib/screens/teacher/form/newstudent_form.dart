import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/repositories/utils/alert_diglogs.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/widgets/text_field_widget.dart';

final firstNameController = TextEditingController();
final secondNameController = TextEditingController();
final classTeacherController = TextEditingController();
final rollNoController = TextEditingController();
final guardianNameController = TextEditingController();
final ageController = TextEditingController();
final registrationNumberController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();

enum Gender { male, female }

List<String> classNames = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
int index = 0;
String? value = '';
Gender? gender = Gender.female;

class ScreenStudentForm extends StatelessWidget {
  const ScreenStudentForm({super.key});

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
            } else if (state is DropdownTeacherState) {
              index = state.index;
              value = state.dropdownValue;
            } else if (state is RadioButtonState) {
              gender = state.gender;
            }
          },
          builder: (context, state) {
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
                                  BottomNavigationEvent(currentPageIndex: 0));
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
                        backgroundImage:
                            AssetImage('lib/assets/images/student female.png'),
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
                        icon: const Icon(Icons.person_3_outlined,
                            color: headingColor),
                        fillColor: appbarColor,
                        hintText: 'Class Teacher',
                        labelText: 'Class Teacher',
                        controller: classTeacherController,
                        keyboardType: TextInputType.name,
                        length: null,
                        obscureText: false),
                    const SizedBox(
                      height: 20,
                    ),
                    SignUpTextFieldWidget(
                        icon: const Icon(Icons.format_list_numbered_rounded,
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
                        icon: const Icon(Icons.list, color: headingColor),
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
                                      .add(RadioButtonEvent(gender: value)),
                                ),
                                const Text('Female'),
                                Radio<Gender>(
                                  value: Gender.male,
                                  groupValue: gender,
                                  onChanged: (Gender? value) => context
                                      .read<TeacherBloc>()
                                      .add(RadioButtonEvent(gender: value)),
                                ),
                                const Text('Male'),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Class',
                              style: titleTextStyle,
                            ),
                            DropdownMenu<String>(
                              initialSelection: classNames.first,
                              onSelected: (String? value) {
                                index = classNames
                                    .indexWhere((item) => item == value);
                                return context.read<TeacherBloc>().add(
                                    DropdownTeacherEvent(
                                        dropdownValue: value,
                                        onSelected: index));
                              },
                              dropdownMenuEntries: classNames
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (studentFormKey.currentState!.validate()) {
                          onCreate(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          shape: const ContinuousRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
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
          },
        ),
      ),
    );
  }
}

void onCreate(BuildContext context) {
  final studentObject = StudentModel(
      firstName: firstNameController.text,
      secondName: secondNameController.text,
      classTeacher: classTeacherController.text,
      rollNo: rollNoController.text,
      age: ageController.text,
      registerNo: registrationNumberController.text,
      email: emailController.text,
      contactNo: contactController.text,
      guardianName: guardianNameController.text,
      password: passwordController.text,
      gender: gender.toString(),
      standard: value as String);
  context.read<TeacherBloc>().add(AddStudentEvent(studentData: studentObject));

  firstNameController.text = '';
  secondNameController.text = '';
  classTeacherController.text = '';
  rollNoController.text = '';
  guardianNameController.text = ''; 
  ageController.text = '';
  registrationNumberController.text = '';
  emailController.text = '';
  contactController.text = '';
  passwordController.text = '';
}
