import 'package:api_cubit/utility/image_cache_utility.dart';
import 'package:flutter/material.dart';

class ForecastDayTemp extends StatelessWidget {
  const ForecastDayTemp(
      {Key? key,
      this.day,
      this.maxTemperature,
      this.minTemperature,
      this.iconId})
      : super(key: key);
  final String? day;

  final String? maxTemperature;
  final String? minTemperature;
  final String? iconId;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                day!,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            SizedBox(
                width: 40,
                height: 30,
                child: cacheImage(
                  'http://openweathermap.org/img/wn/$iconId@2x.png',
                )),
            const Expanded(child: SizedBox()),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      maxTemperature! + ('\u1d52'),
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Text(
                    minTemperature! + ('\u1d52'),
                    style: TextStyle(
                        fontSize: 18, color: Colors.lightBlue.shade100),
                  )
                ],
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 0.5,
          color: Colors.white,
        )
      ],
    );
  }
}
