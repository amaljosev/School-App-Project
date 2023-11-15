import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/admin/admin_screen.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/screens/requests/bloc/admin_request_bloc.dart';
import 'package:schoolapp/screens/student/bloc/student_bloc.dart';
import 'package:schoolapp/screens/student/student_screen.dart';
import 'package:schoolapp/screens/teacher/bloc/teacher_bloc.dart';
import 'package:schoolapp/screens/teacher/profile/student_profile.dart';
import 'package:schoolapp/screens/teacher/teacher_screen.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';
import 'package:schoolapp/screens/welcome/first_screen.dart';
import 'package:schoolapp/screens/welcome/login_screen.dart';
import 'package:schoolapp/screens/welcome/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WelcomeBloc(),
        ),
        BlocProvider(
          create: (context) => AdminBloc(),
        ),
        BlocProvider(
          create: (context) => AdminRequestBloc(),
        ),
        BlocProvider(
          create: (context) => TeacherBloc(),
        ),
        BlocProvider(
          create: (context) => StudentBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'School App',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,  
        home: const ScreenStudent(),                                                      
      ), 
    );
  }
}
