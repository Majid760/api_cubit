import 'dart:math';
import 'package:api_cubit/view/widgets/section_header_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:funvas/funvas.dart';

import 'package:flutter/material.dart';

class WindSection extends StatelessWidget {
  const WindSection({Key? key, this.windSpeed, this.windPressureHg})
      : super(key: key);
  final String? windSpeed;
  final String? windPressureHg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 200,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeaderWidget(
              headerTitle: "Wind & Pressure",
              iconData: Icons.view_week_sharp,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ExampleFunvasWidget(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Wind',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: windSpeed!,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white.withOpacity(1))),
                              TextSpan(
                                  text: ' mph',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(1))),
                              const TextSpan(
                                  text: ' WNW',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ],
                          ),
                        )
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text('Barrometer',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: windPressureHg,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white.withOpacity(1))),
                                const TextSpan(
                                    text: ' in Hg',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15)),
                              ],
                            ),
                          )
                        ]),
                  )
                ],
              )),
            )),
          ],
        ),
      ),
    );
  }
}

class OrbsFunvas extends Funvas {
  @override
  void u(double t) {
    c.scale(x.width / 1920, x.height / 1080);

    final v = t + 400;
    for (var q = 255; q > 0; q--) {
      final paint = Paint()..color = R(q, q, q);
      c.drawCircle(
          Offset(
            1920 / 2 + C(v - q) * (v + q),
            540 + S(v - q) * (v - q),
          ),
          40,
          paint);
    }
  }
}

/// Example widget that displays the [ExampleFunvas] animation.
class ExampleFunvasWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: FunvasContainer(
        funvas: OrbsFunvas(),
      ),
    );
  }
}
