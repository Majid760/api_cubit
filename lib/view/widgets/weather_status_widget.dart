import 'package:api_cubit/utility/image_cache_utility.dart';
import 'package:flutter/material.dart';

class WeatherStatusWidget extends StatelessWidget {
  const WeatherStatusWidget({Key? key, this.weatherStatus, this.iconId})
      : super(key: key);
  final String? weatherStatus;
  final String? iconId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: 70,
            height: 70,
            child: cacheImage(
              'http://openweathermap.org/img/wn/$iconId@2x.png',
            )),
        const SizedBox(
          width: 8,
        ),
        Text(
          weatherStatus!,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ),
      ],
    );
  }
}
