import 'package:api_cubit/data/model/forecase_model.dart';
import 'package:api_cubit/utility/conversion_utility.dart';
import 'package:api_cubit/utility/image_cache_utility.dart';
import 'package:api_cubit/view/widgets/section_header_widget.dart';
import 'package:flutter/material.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({Key? key, this.iconId, this.current}) : super(key: key);

  final String? iconId;
  final Current? current;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 360,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeaderWidget(
              headerTitle: "Detail",
              iconData: Icons.view_week_sharp,
            ),
            const Divider(
              thickness: 1,
              color: Colors.white,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 100,
                        child: cacheImage(
                            'http://openweathermap.org/img/wn/${current!.weather![0].icon}@2x.png'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Text(
                                'Feels like',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Text(
                                ConverionUtility.kelvinToCelcius(
                                        current?.feelsLike) +
                                    ('\u1d52'),
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Humidity',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              current!.humidity.toString() + '%',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              ' Visibility',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              ((current?.visibility)! / 1000).toString() +
                                  ' mi',
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'UV index',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  const TextSpan(
                                      text: 'Low ',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: current?.uvi.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20)),
                                ],
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Air Quality',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            Text(
                              '123 AQI (US)',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text(
                'Tonight Showers with a 70% chance of percipitation. Wind Variable at 5 to 6 mph(8.0 to 9.7 kph). The overnight low will be 56 F(13.3C)',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                'Tonight Showers with high of  68 F(20.0 C) and  of percipitation. Wind Variable at 5 to 6 mph(8.0 to 9.7 kph). The overnight low will be 56 F(13.3C)',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
