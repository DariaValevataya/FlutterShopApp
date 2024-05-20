import 'package:flutter/material.dart';

class LineTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String placeholder;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? right;
  final bool readOnly;

  const LineTextField(
      {super.key,
      required this.title,
      required this.placeholder,
      required this.controller,
      this.right,
      this.keyboardType,
      this.obscureText = false,
      this.readOnly=false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        TextField(
          readOnly: readOnly,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: right,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: placeholder,
            hintStyle: TextStyle(color: Color(0xffE2E2E2), fontSize: 17),
          ),
        ),
        Container(
          width: double.maxFinite,
          height: 2,
          color: const Color(0xffE2E2E2),
        )
      ],
    );
  }
}
