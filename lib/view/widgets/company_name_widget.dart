import 'package:flutter/material.dart';

class TempAndCompanyName extends StatelessWidget {
  final String? currentTemp;
  const TempAndCompanyName({
    Key? key,
    @required this.currentTemp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          currentTemp! + ('\u1d52'),
          style: TextStyle(
            fontSize: 96,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
