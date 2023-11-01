import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/models/student_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';

final nameController = TextEditingController();
final classTeacherController = TextEditingController();
final rollNoController = TextEditingController();
final guardianNameController = TextEditingController();
final ageController = TextEditingController();
final classController = TextEditingController();
final registrationNumberController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();

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
                    Column(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              backgroundColor: headingColor,
                              radius: 60,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: AssetImage(
                                    'lib/assets/images/student female.png'),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: headingColor,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.add,
                                      color: appbarColor,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        filled: true,
                        fillColor: loginTextfieldColor,
                        suffixIcon: const Icon(Icons.person),
                        hintText: 'Student Name',
                        labelText: 'Student Name',
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (value) => nameController.text.isEmpty
                          ? "Please enter Student's name"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        filled: true,
                        fillColor: loginTextfieldColor,
                        suffixIcon: const Icon(Icons.person),
                        hintText: 'Class Teacher',
                        labelText: 'Class Teacher',
                      ),
                      controller: classTeacherController,
                      keyboardType: TextInputType.name,
                      validator: (value) => classTeacherController.text.isEmpty
                          ? "Please enter Class Teacher's name"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon:
                              const Icon(Icons.format_list_numbered_sharp),
                          hintText: 'Roll No',
                          labelText: 'Roll No'),
                      controller: rollNoController,
                      keyboardType: TextInputType.number,
                      validator: (value) => classController.text.isEmpty
                          ? "Please enter Student's Roll No"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon: const Icon(Icons.av_timer),
                          hintText: 'Age',
                          labelText: 'Age'),
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      validator: (value) => classController.text.isEmpty
                          ? "Please enter Student's age"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon: const Icon(Icons.class_),
                          hintText: 'Class',
                          labelText: 'Class'),
                      controller: classController,
                      keyboardType: TextInputType.number,
                      validator: (value) => classController.text.isEmpty
                          ? "Please enter Student's class"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon:
                              const Icon(Icons.format_list_numbered_sharp),
                          hintText: 'Register No',
                          labelText: 'Register No'),
                      controller: registrationNumberController,
                      keyboardType: TextInputType.number,
                      validator: (value) => classController.text.isEmpty
                          ? "Please enter Student's Register No"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon: const Icon(Icons.email),
                          hintText: 'Email',
                          labelText: 'Email'),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => emailController.text.isEmpty
                          ? "Please enter Student's or guardian's email"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon: const Icon(Icons.phone),
                          hintText: 'Contact Number',
                          labelText: 'Contact Number'),
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (value) => contactController.text.isEmpty
                          ? "Please enter Student's or guardian's contact no"
                          : null,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        filled: true,
                        fillColor: loginTextfieldColor,
                        suffixIcon: const Icon(Icons.people),
                        hintText: "Guardian's Name",
                        labelText: "Guardian's Name",
                      ),
                      controller: guardianNameController,
                      keyboardType: TextInputType.name,
                      validator: (value) => nameController.text.isEmpty
                          ? "Please enter Guardian's Name"
                          : null,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          filled: true,
                          fillColor: loginTextfieldColor,
                          suffixIcon: IconButton(
                              onPressed: () {}, icon: const Icon(Icons.lock)),
                          hintText: 'Password',
                          labelText: 'Password'),
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => passwordController.text.isEmpty
                          ? 'Please enter a password'
                          : null,
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
      rollNo: int.parse(rollNoController.text),
      name: nameController.text,
      age: int.parse(ageController.text),
      className: int.parse(classController.text),
      registerNo: int.parse(registrationNumberController.text),
      email: emailController.text,
      contactNo: int.parse(contactController.text),
      guardianName: guardianNameController.text,
      password: passwordController.text);
  context.read<TeacherBloc>().add(AddStudentEvent(studentData: studentObject));

  nameController.text = "";
  guardianNameController.text = "";
  ageController.text = "";
  classController.text = "";
  registrationNumberController.text = "";
  emailController.text = "";
  contactController.text = "";
  passwordController.text = "";
}
