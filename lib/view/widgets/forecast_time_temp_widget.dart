import 'package:api_cubit/utility/image_cache_utility.dart';
import 'package:flutter/material.dart';

class ForecastTimeTemp extends StatelessWidget {
  const ForecastTimeTemp({Key? key, this.time, this.iconId, this.temperature})
      : super(key: key);
  final String? time;
  final String? iconId;
  final String? temperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(time!, style: const TextStyle(color: Colors.white)),
        // tempIcon!,
        SizedBox(
            width: 30,
            height: 30,
            child: cacheImage(
              'http://openweathermap.org/img/wn/$iconId@2x.png',
            )),
        Text(
          temperature! + ('\u1d52'),
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }
}
