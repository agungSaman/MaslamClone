import 'package:flutter/material.dart';

class VerticalTitleValueItem extends StatelessWidget {
  final Widget title;
  final Widget value;
  final CrossAxisAlignment crossAxisAlignment;

  const VerticalTitleValueItem(
      {Key? key,
      required this.title,
      required this.value,
      this.crossAxisAlignment = CrossAxisAlignment.start})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [title, const SizedBox(height: 4), value],
    );
  }
}
