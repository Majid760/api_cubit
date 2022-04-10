import 'package:api_cubit/data/model/forecase_model.dart';
import 'package:api_cubit/utility/conversion_utility.dart';
import 'package:flutter/material.dart';

import 'forecast_day_temp_widget.dart';
import 'forecast_time_temp_widget.dart';

class Forecast extends StatefulWidget {
  Forecast({
    Key? key,
    this.listHourly,
    this.listDaily,
  }) : super(key: key);
  final List<Hourly>? listHourly;
  final List<Daily>? listDaily;

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  int? minusDays;
  @override
  void initState() {
    super.initState();
    minusDays = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: (minusDays == 3) ? 420 : 500,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 450,
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const Text(
                    'Forecast',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.white,
                  ),
                  // horizontal forecast time section
                  SizedBox(
                    height: 80,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 45,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.listHourly!.length - 24,
                        itemBuilder: (context, int index) => ForecastTimeTemp(
                              time: ConverionUtility.getHourFromUTC(
                                  widget.listHourly![index].dt!),
                              temperature: ConverionUtility.kelvinToCelcius(
                                  widget.listHourly![index].temp!),
                              iconId:
                                  widget.listHourly![index].weather![0].icon,
                            )),
                  ),
                  // day weather section

                  const Divider(
                    thickness: .5,
                    color: Colors.white,
                  ),

                  SizedBox(
                    height: (minusDays == 3) ? 230 : 300,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.listDaily!.length - minusDays!,
                        itemBuilder: (context, index) => ForecastDayTemp(
                            day: ConverionUtility.getWeekDayFromUTC(int.parse(
                                widget.listDaily![index].dt!
                                    .toStringAsFixed(0))),
                            maxTemperature: ConverionUtility.kelvinToCelcius(
                                widget.listDaily![index].temp!.max!),
                            minTemperature: ConverionUtility.kelvinToCelcius(
                                widget.listDaily![index].temp!.min!),
                            iconId: widget.listDaily![index].weather![0].icon)),
                  ),
                  (minusDays == 3)
                      ? const SizedBox(
                          height: 15,
                        )
                      : const Divider(
                          thickness: .5,
                          color: Colors.white,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            minusDays = 3;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            '5d',
                            style: TextStyle(
                                color: (minusDays == 3)
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 18),
                          ),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: Colors.white70,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            minusDays = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '7d',
                            style: TextStyle(
                                color: (minusDays == 0)
                                    ? Colors.white
                                    : Colors.white70,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
