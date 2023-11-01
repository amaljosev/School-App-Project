import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/widgets/my_appbar.dart';

class ScreenSchoolEvents extends StatelessWidget {
  const ScreenSchoolEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar('Upcoming Events'),
      body: WillPopScope(
        onWillPop: () => toTeacherHome(context), 
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: appbarColor,
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      hintText: 'Title',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        hintText: 'Topic ',
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(fontSize: 20)),
                                    maxLines: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: buttonColor,
                                  shape: const ContinuousRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  fixedSize: const Size(110, 30),
                                  elevation: 10),
                              onPressed: () {},
                              icon: const Icon(Icons.send, color: whiteTextColor),
                              label: const Text(
                                'Share',
                                style: TextStyle(color: whiteTextColor),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


