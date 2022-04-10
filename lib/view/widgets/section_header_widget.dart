import 'package:flutter/material.dart';

class SectionHeaderWidget extends StatelessWidget {
  const SectionHeaderWidget(
      {Key? key, @required this.headerTitle, this.iconData})
      : super(key: key);
  final String? headerTitle;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerTitle!,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.white),
        ),
        const Icon(
          Icons.view_week_sharp,
          color: Colors.white,
        )
      ],
    );
  }
}
