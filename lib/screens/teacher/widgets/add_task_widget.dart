import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';
import 'package:schoolapp/widgets/button_widget.dart';

class AddTaskWidget extends StatelessWidget {
  const AddTaskWidget({
    super.key,
    required this.size,
  });
  final Size size;

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
    return SingleChildScrollView(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(
                  text: 'Home Work',
                ),
                Tab(
                  text: 'Assignment',
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: size.height * 0.70,
                child: TabBarView(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const SizedBox(
                          height: 40,
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
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
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
                        // const ButtonSubmissionWidget(label: 'send', icon: Icons.send),   
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
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
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Set a Expiry Date',
                              style: contentTextStyle,
                            ),
                            ElevatedButton.icon(
                              onPressed: () => datePicker(context),
                              icon: const Icon(Icons.date_range),
                              label: const Text(' Calender'),
                            )
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
                                    hintText:
                                        'eg: Write a assignment based on '),
                                maxLines: 5,
                              ),
                            ),
                          ),
                        ),
                        // const ButtonSubmissionWidget(label: 'send', icon: Icons.send), 
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  datePicker(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.day,
      builder: (context, child) {
        return SizedBox(
          height: 555,
          width: 500,
          child: child,
        );
      },
    );
  }
}
