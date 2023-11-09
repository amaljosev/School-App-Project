import 'package:flutter/material.dart';

class AttendenceHistoryWidget extends StatelessWidget {
  const AttendenceHistoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated( 
        itemBuilder: (context, index) => const ListTile(
              title: Text('date '),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  Text('total present : 40'),
                  Text('total absent : 10')  
                ],
              ),
            ),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: 10);
  }
}