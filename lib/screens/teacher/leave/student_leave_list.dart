import 'package:flutter/material.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenLeaveApplications extends StatelessWidget {
  const ScreenLeaveApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Leave Applications'),
      body: const Center(child: Text('apllications are list here')),
    );
  }
}
