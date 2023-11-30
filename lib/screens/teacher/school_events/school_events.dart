import 'package:flutter/material.dart';
import 'package:schoolapp/widgets/application_form.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenSchoolEvents extends StatelessWidget {
  const ScreenSchoolEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Upcoming Events'),
      body: SafeArea(
        child: Column(
          children: [
            const ApplicationWidget(isTeacher: true),
            Expanded(
                child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.separated(
                  itemBuilder: (context, index) => const ListTile(
                        title: Text('data'),
                      ),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: 10),
            )),
          ],
        ),
      ),
    );
  }
}
