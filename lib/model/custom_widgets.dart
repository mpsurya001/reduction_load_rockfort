import 'package:flutter/material.dart';

class CustomTextFields extends StatelessWidget {
  final TextEditingController? myController;
//  final String hintText;
  final String labelText;
  final String keyboard;

  CustomTextFields(
      {required this.myController,
      // required this.hintText,
      required this.labelText,
      required this.keyboard}); // const CustomTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: TextField(
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textInputAction: keyboard == 'text'
                  ? TextInputAction.none
                  : TextInputAction.next,
              keyboardType: keyboard == 'text'
                  ? TextInputType.multiline
                  : TextInputType.number,
              // minLines: 1,
              maxLines: null,
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: labelText, // hintText,
                labelText: labelText,
              ))),
    );
  }
}
