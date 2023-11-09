import 'package:flutter/material.dart';
import 'package:schoolapp/repositories/core/colors.dart';

class ButtonSubmissionWidget extends StatelessWidget {
  const ButtonSubmissionWidget({
    super.key,
    required this.label,
    required this.icon,
  });
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              fixedSize: const Size(110, 30),
              elevation: 10),
          onPressed: () {},
          icon: Icon(icon, color: whiteTextColor),
          label: Text(
            label,
            style: const TextStyle(color: whiteTextColor),
          )),
    );
  }
}
