import 'package:flutter/material.dart';

class TitleValueSection extends StatelessWidget {
  final List<Widget> items;
  final Color? backgroundColor;

  const TitleValueSection({
    Key? key,
    required this.items,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor ?? Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => items[index],
                separatorBuilder: (context, index) => const SizedBox(height: 4),
                itemCount: items.length)));
  }
}
