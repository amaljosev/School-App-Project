import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
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

class ScreenStudentForm extends StatelessWidget {
  const ScreenStudentForm({super.key});

  @override
  Widget build(BuildContext context) {
    Gender? gender = Gender.female;
    final studentFormKey = GlobalKey<FormState>();
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context),
        child: BlocConsumer<TeacherBloc, TeacherState>(
          listener: (context, state) {
            if (state is AddStudentState) {
              AlertMessages().alertMessageSnakebar(
                  context, 'Student Created Successfully', Colors.green);
              Navigator.pop(context);
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
                        length: null,
                        obscureText: false),
                    const SizedBox(
                      height: 20,
                    ),
                    SignUpTextFieldWidget(
                        icon: const Icon(Icons.av_timer_rounded,
                            color: headingColor),
                        fillColor: appbarColor,
                        hintText: 'Age',
                        labelText: 'Age',
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        length: null,
                        obscureText: false),
                    const SizedBox(
                      height: 20,
                    ),
                    SignUpTextFieldWidget(
                        icon: const Icon(Icons.list, color: headingColor),
                        fillColor: appbarColor,
                        hintText: 'Register No',
                        labelText: 'Register No',
                        controller: registrationNumberController,
                        keyboardType: TextInputType.number,
                        length: null,
                        obscureText: false),
                    const SizedBox(
                      height: 20,
                    ),
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
                                  onChanged: (Gender? value) {},
                                ),
                                const Text('Female'),
                                Radio<Gender>(
                                  value: Gender.male,
                                  groupValue: gender,
                                  onChanged: (Gender? value) {},
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
                                // This is called when the user selects an item.
                                // setState(() {
                                //   dropdownValue = value!;
                                // });
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
                          // onCreate(context);
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

// void onCreate(BuildContext context) {
//   final studentObject = StudentModel(
//       rollNo: int.parse(rollNoController.text),
//       name: nameController.text,
//       age: int.parse(ageController.text),
//       className: int.parse(classController.text),
//       registerNo: int.parse(registrationNumberController.text),
//       email: emailController.text,
//       contactNo: int.parse(contactController.text),
//       guardianName: guardianNameController.text,
//       password: passwordController.text);
//   context.read<TeacherBloc>().add(AddStudentEvent(studentData: studentObject));

//   nameController.text = "";
//   guardianNameController.text = "";
//   ageController.text = "";
//   classController.text = "";
//   registrationNumberController.text = "";
//   emailController.text = "";
//   contactController.text = "";
//   passwordController.text = "";
// }
