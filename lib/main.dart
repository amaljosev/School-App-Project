import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/screens/admin/bloc/admin_bloc.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';
import 'package:schoolapp/screens/welcome/login_screen.dart';

void main() {
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
      ],
      child: MaterialApp(
        title: 'School App',
        theme: ThemeData(
          scaffoldBackgroundColor: scaffoldColor,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ScreenLogin(), 
      ),
    );
  }
}
