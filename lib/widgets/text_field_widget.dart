import 'package:flutter/material.dart';

class SignUpTextFieldWidget extends StatelessWidget {
  const SignUpTextFieldWidget({
    super.key,
    required this.icon,
    required this.fillColor,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
  });
  final Widget icon;
  final Color fillColor;
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        filled: true,
        fillColor: fillColor,
        suffixIcon: icon,
        hintText: hintText,
        labelText: labelText,
      ),
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) =>
          controller.text.isEmpty ? 'Please enter $labelText' : null,
    );
  }
}
