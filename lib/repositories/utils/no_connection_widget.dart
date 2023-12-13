import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/textstyle.dart';

class NoConnectionWidget extends StatelessWidget {
  const NoConnectionWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size.width,
          height: 100,
          child:
              Image.asset('lib/assets/videos/connection.gif'),
        ),
        Text(
          'No Internet Connection',
          style: listViewTextStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text('Please Check your internet connection'),
        ),
        ElevatedButton.icon(
            onPressed: () async {
              await Connectivity().checkConnectivity();
            },
            icon: Icon(Icons.refresh_outlined),
            label: Text('Refresh')),
      ],
    );
  }
}