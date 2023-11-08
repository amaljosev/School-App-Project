import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenEventsStudent extends StatelessWidget {
  const ScreenEventsStudent({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => tostudentHome(context), 
      child:  Scaffold(
        appBar: myAppbar('Upcoming Events'), 
        body: const Center(child: Text('Events are shown here'),),   
      ),
    );
  }
}