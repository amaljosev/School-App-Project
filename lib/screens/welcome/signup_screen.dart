import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/models/teacher_model.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/utils/loading_snakebar.dart';
import 'package:schoolapp/repositories/utils/snakebar_messages.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';
import 'package:schoolapp/screens/welcome/widgets/dropdown_widget.dart';
import 'package:schoolapp/screens/welcome/widgets/title_widget.dart';
import 'package:schoolapp/widgets/text_field_widget.dart';

final nameController = TextEditingController();
final emailController = TextEditingController();
final contactController = TextEditingController();
final passwordController = TextEditingController();
final divisionController = TextEditingController();
String? value;
int index = 0;

class ScreenSignUp extends StatelessWidget {
  const ScreenSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        body: BlocConsumer<WelcomeBloc, WelcomeState>(
            listenWhen: (previous, current) => current is WelcomeActionState,
            buildWhen: (previous, current) => current is! WelcomeActionState,
            listener: (context, state) {
              if (state is SignUpLoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  loadingSnakebarWidget(),
                );
                isLoading = true;
              } else if (state is SignUpSuccessState) {
                AlertMessages().alertMessageSnakebar(
                    context,
                    'Successfully Registered, Please wait for conform',
                    Colors.green);
                isLoading = false;
                Navigator.pop(context);
              } else if (state is SignUpClassErrorState) {
                AlertMessages().alertMessageSnakebar(context,
                    'Enterd Class or Email already Registered', Colors.red);
                isLoading = false;
              } else if (state is SignUpErrorState) {
                AlertMessages().alertMessageSnakebar(
                    context, 'Not registerd Please contact admin', Colors.red);
                isLoading = false;
              } else if (state is DropdownMenuTapState) {
                value = state.dropdownValue;
                index = state.index;
              }
            },
            builder: (context, state) {
              return SafeArea(
                  child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(18),
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    const TitleCardWidget(),
                    SignUpTextFieldWidget(
                      icon: const Icon(Icons.person),
                      fillColor: loginTextfieldColor,
                      hintText: 'Teacher Name',
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      length: null,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignUpTextFieldWidget(
                      icon: const Icon(Icons.email),
                      fillColor: loginTextfieldColor,
                      hintText: 'Email',
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      length: null,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SignUpTextFieldWidget(
                      icon: const Icon(Icons.phone),
                      fillColor: loginTextfieldColor,
                      hintText: 'Contact Number',
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      length: 10,
                      obscureText: false,
                    ),
                    SignUpTextFieldWidget(
                      icon: const Icon(Icons.remove_red_eye),
                      fillColor: loginTextfieldColor,
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.emailAddress,
                      length: null,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    DropDownWidget(index: index),
                    const SizedBox(
                      height: 15,
                    ),
                    SignUpTextFieldWidget(
                      icon: const Icon(Icons.email),
                      fillColor: loginTextfieldColor,
                      hintText: 'Division',
                      controller: divisionController,
                      keyboardType: TextInputType.name,
                      length: null,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (isLoading) {
                          null;
                        } else {
                          if (formKey.currentState!.validate()) {
                            if (!RegExp(r'^[a-zA-Z]+$')
                                .hasMatch(divisionController.text)) {
                              AlertMessages().alertMessageSnakebar(
                                  context,
                                  'Division can only contain letters',
                                  Colors.red);
                            } else {
                              onSignUp(context);
                            }
                          }
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
                          onPressed: () => Navigator.pop(context),
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
              ));
            }));
  }
}

onSignUp(BuildContext context) async {
  final teacherObject = TeacherModel(
      name: nameController.text,
      className: value as String,
      email: emailController.text,
      contact: int.parse(contactController.text),
      password: passwordController.text.toString(),
      division: divisionController.text.toUpperCase());

  context.read<WelcomeBloc>().add(
        SignUpButtonEvent(teacherData: teacherObject),
      );

  nameController.text = "";
  emailController.text = "";
  contactController.text = "";
  passwordController.text = "";
  divisionController.text = "";
}
