import 'package:flutter/material.dart';

class StepperWrap extends StatelessWidget {
  final String lable;

  StepperWrap(this.lable);

  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      softWrap: true,
      style: const TextStyle(fontSize: 13),
    );
  }
}
