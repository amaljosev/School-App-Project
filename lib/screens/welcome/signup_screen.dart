import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';
import 'package:schoolapp/screens/welcome/login_screen.dart';

final nameController = TextEditingController();
final classController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WelcomeBloc, WelcomeState>(
        listenWhen: (previous, current) => current is WelcomeActionState,
        buildWhen: (previous, current) => current is! WelcomeActionState,
        listener: (context, state) {
          if (state is NavigateToSignUpState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ScreenLogin(),
                ));
          } else if (state is SignInSuccessState) {
            AlertMessages().alertMessageSnakebar(
                context,
                'Successfully Registered \nwait for resposnce from pricipal', 
                Colors.green);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                    child: Text(
                  'Welcome To ',
                  style: GoogleFonts.macondo(
                      fontSize: 20,
                      letterSpacing: 3,
                      fontWeight: FontWeight.bold,
                      color: headingColor),
                )),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    'STUDENTS SIGHT',
                    style: GoogleFonts.macondo(
                        fontSize: 35,
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        color: titleColor),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Center(
                    child: Text('Sign Up for continue',
                        style: TextStyle(
                            color: headingColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w300))),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    filled: true,
                    fillColor: loginTextfieldColor,
                    suffixIcon: const Icon(Icons.person),
                    hintText: 'Teacher Name',
                    labelText: 'Teacher Name',
                  ),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      filled: true,
                      fillColor: loginTextfieldColor,
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.remove_red_eye)),
                      hintText: 'Password',
                      labelText: 'Password'),
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => onSignUp(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: const ContinuousRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      fixedSize: const Size(150, 50),
                      elevation: 10),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: whiteTextColor),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    TextButton(
                      onPressed: () =>
                          context.read<WelcomeBloc>().add(NavigateEvent()),
                      child: Text('Sign In',
                          style: GoogleFonts.farro(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: Colors.black)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

onSignUp(BuildContext context) {
  final teacherObject = TeacherModel(
      name: nameController.text,
      className: int.parse(classController.text),
      email: emailController.text,
      contact: int.parse(contactController.text),
      password: passwordController.text.toString());
  context.read<WelcomeBloc>().add(
        SignUpButtonEvent(teacherData: teacherObject),
      );
  nameController.text = "";
  classController.text = "";
  emailController.text = "";
  contactController.text = "";
  passwordController.text = "";
}
