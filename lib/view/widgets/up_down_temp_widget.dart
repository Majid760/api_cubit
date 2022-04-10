import 'package:flutter/material.dart';
import 'dart:math' as math;

class UpDownTempWidget extends StatelessWidget {
  const UpDownTempWidget({Key? key, this.upTemp, this.downTemp})
      : super(key: key);
  final String? upTemp;
  final String? downTemp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Transform.rotate(
              angle: 180 * math.pi / 120,
              child: const Icon(Icons.keyboard_tab_outlined,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              upTemp! + ('\u1d52'),
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
        const SizedBox(
          width: 8,
        ),
        Row(
          children: [
            Transform.rotate(
              angle: 180 * math.pi / 360,
              child: const Icon(Icons.keyboard_tab_outlined,
                  color: Colors.white, size: 18),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              downTemp! + ('\u1d52'),
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
