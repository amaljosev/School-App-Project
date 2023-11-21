import 'package:flutter/material.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenWorks extends StatelessWidget {
  const ScreenWorks({super.key, required this.workName});
final String workName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(workName),  
      body: Center(
          child: Text('Student Sumitted $workName are show here')),
    );
  }
}
