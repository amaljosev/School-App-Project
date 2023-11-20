import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/class_model.dart';
import 'package:schoolapp/models/fee_model.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/teacher/controllers/teacherBloc1/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/form/newstudent_form.dart';
import 'package:schoolapp/widgets/text_field_widget.dart';
import '../../../../repositories/core/textstyle.dart';

class TextFieldTilesWidgetAddStudent extends StatelessWidget {
  const TextFieldTilesWidgetAddStudent({
    super.key,
    required this.widget,
    required this.studentFormKey,
    required this.teacher,
    required this.standard,
    required this.studentId,
    required this.gender,
    required this.isTeacher,
  });

  final ScreenStudentForm widget;
  final GlobalKey<FormState> studentFormKey;
  final String teacher;
  final String standard;
  final String? studentId;
  final Gender? gender;
  final bool isTeacher;

  @override
  Widget build(BuildContext context) {
    final String id = widget.isUpdate ? widget.studentId as String : '';

    gender ?? Gender.female;

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  context
                      .read<TeacherBloc>()
                      .add(BottomNavigationEvent(currentPageIndex: 0));
                },
                icon: const Icon(Icons.arrow_back)),
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: Center(
                  child: Text(
                      widget.isUpdate
                          ? 'Update Student Details'
                          : 'Add Student to Class',
                      style: const TextStyle(
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
            backgroundImage: AssetImage('lib/assets/images/student female.png'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SignUpTextFieldWidget(
            icon: const Icon(Icons.person_outline_rounded, color: headingColor),
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
            icon:
                const Icon(Icons.person_add_alt_outlined, color: headingColor),
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
        isTeacher
            ? SignUpTextFieldWidget(
                icon: const Icon(Icons.format_list_numbered_rounded,
                    color: headingColor),
                fillColor: appbarColor,
                hintText: 'Roll No',
                labelText: 'Roll No',
                controller: rollNoController,
                keyboardType: TextInputType.number,
                length: 2,
                obscureText: false)
            : const Row(),
        SignUpTextFieldWidget(
            icon: const Icon(Icons.av_timer_rounded, color: headingColor),
            fillColor: appbarColor,
            hintText: 'Age',
            labelText: 'Age',
            controller: ageController,
            keyboardType: TextInputType.number,
            length: 2,
            obscureText: false),
        isTeacher
            ? SignUpTextFieldWidget(
                icon: const Icon(Icons.list, color: headingColor),
                fillColor: appbarColor,
                hintText: 'Register No',
                labelText: 'Register No',
                controller: registrationNumberController,
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false)
            : const Row(),
        widget.isUpdate
            ? const Row()
            : SignUpTextFieldWidget(
                icon:
                    const Icon(Icons.mail_outline_rounded, color: headingColor),
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
            icon: const Icon(Icons.phone_iphone_rounded, color: headingColor),
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
            icon: const Icon(Icons.people_outline, color: headingColor),
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
            icon: const Icon(Icons.lock_outline_rounded, color: headingColor),
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
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            if (studentFormKey.currentState!.validate()) {
              onButtonTap(
                  id: id,
                  isUpdate: widget.isUpdate,
                  context: context,
                  teacher: teacher,
                  standard: standard,
                  gender: gender,
                  isTeacher: widget.isTeacher);
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              fixedSize: const Size(150, 50),
              elevation: 10),
          child: Text(
            widget.isUpdate ? 'Update' : 'Submit',
            style: const TextStyle(color: whiteTextColor),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

void onButtonTap(
    {required bool isUpdate,
    required BuildContext context,
    required String teacher,
    required String standard,
    required String id,
    required Gender? gender,
    required isTeacher}) {
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
    totalAbsent: 0,
    totalPresent: 0,
  );
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

  final feeObject = FeeModel(totalAmount: 0, amountPayed: 0, amountPending: 0);

  if (isTeacher) {
    isUpdate
        ? context.read<TeacherBloc>().add(
            UpdateStudentDataEvent(studentData: studentObject, studentId: id))
        : context.read<TeacherBloc>().add(AddStudentEvent(
            studentData: studentObject,
            classDatas: classObject,
            feeData: feeObject));
  } else {
    context.read<StudentBloc>().add(UpdateStudentDataStudentEvent(
        studentData: studentObject, studentId: id));
  }

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
