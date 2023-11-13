import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';
import 'package:schoolapp/repositories/core/functions.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class ScreenStudentTasks extends StatelessWidget {
  const ScreenStudentTasks({super.key, required this.taskName});
  final String taskName;
  @override
  Widget build(BuildContext context) {
    const List<String> subjectList = <String>[
      'English',
      'Physics',
      'Maths',
      'Chemistry',
      'Hindi',
      'Social Science',
      'Science'
    ];
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: WillPopScope(
        onWillPop: () => tostudentHome(context),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: appbarColor,
            title: Text(taskName, style: appbarTextStyle),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: const Icon(Icons.assignment),
                  text: taskName,
                ),
                Tab(
                  icon: const Icon(Icons.save_as_sharp),
                  text: 'Submit $taskName',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Center(
                child: Text("$taskName's are list here"),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Select Subject',
                        style: contentTextStyle,
                      ),
                      DropdownMenu<String>(
                        initialSelection: subjectList.first,
                        onSelected: (String? value) {
                          // This is called when the user selects an item.
                          // setState(() {
                          //   // dropdownValue = value!;
                          // });
                        },
                        dropdownMenuEntries: subjectList
                            .map<DropdownMenuEntry<String>>((String value) {
                          return DropdownMenuEntry<String>(
                              value: value, label: value);
                        }).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Task',
                              hintText: 'eg: Complete Activity 5'),
                          maxLines: 5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              side: MaterialStateProperty.all(
                                const BorderSide(width: 2.0, color: titleColor),
                              ),
                            ),
                            child:  Text('Upload $taskName')),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('No file selected !!'), 
                        )
                      ],
                    ),
                  ),
                  // const ButtonSubmissionWidget(label: 'send', icon: Icons.send),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
