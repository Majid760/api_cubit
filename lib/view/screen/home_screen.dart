import 'package:api_cubit/cubit/weather_cubit.dart';
import 'package:api_cubit/utility/conversion_utility.dart';
import 'package:api_cubit/view/widgets/company_name_widget.dart';
import 'package:api_cubit/view/widgets/custom_appbar_widget.dart';
import 'package:api_cubit/view/widgets/detial_section.dart';
import 'package:api_cubit/view/widgets/drawer.dart';
import 'package:api_cubit/view/widgets/forecast_section.dart';
import 'package:api_cubit/view/widgets/map_section.dart';
import 'package:api_cubit/view/widgets/precipitation_section.dart';
import 'package:api_cubit/view/widgets/up_down_temp_widget.dart';
import 'package:api_cubit/view/widgets/weather_status_widget.dart';
import 'package:api_cubit/view/widgets/wind_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.index, Key? key}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherApiState>(
      // buildWhen: (prev, curr) {
      //   return curr.forecastWeather![index] != prev.forecastWeather![index];
      // },
      builder: (BuildContext context, state) {
        switch (state.status) {
          case ApiStatus.failure:
            return const Material(
                child: Center(child: Text('something went wrong!')));
          case ApiStatus.success:
            return Scaffold(
                extendBodyBehindAppBar: true,
                drawer: const CustomeDrawer(),
                extendBody: true,
                appBar: AppBarWidget(
                  cityTitle: state.listCity![index][0].toUpperCase() +
                      state.listCity![index].substring(1),
                  dateTime: DateTime.fromMillisecondsSinceEpoch(
                      state.forecastWeather![index].current!.dt! * 1000),
                ),
                body: RefreshIndicator(
                    displacement: 100,
                    edgeOffset: 25,
                    onRefresh: () async {
                      await Future.delayed(const Duration(seconds: 2));
                      BlocProvider.of<WeatherCubit>(context)
                          .fetchCurrentWeatherByName("Islamabad");
                    },
                    child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/skygif3.gif')),
                        ),
                        child: Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.12,
                                bottom: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.6),
                                child: Column(
                                  children: [
                                    WeatherStatusWidget(
                                      weatherStatus: state
                                          .forecastWeather![index]
                                          .current!
                                          .weather![0]
                                          .description,
                                      iconId: state.forecastWeather![index]
                                          .current!.weather![0].icon,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 7),
                                      child: UpDownTempWidget(
                                        upTemp:
                                            ConverionUtility.kelvinToCelcius(
                                                state.forecastWeather![index]
                                                    .daily![0].temp!.max!),
                                        downTemp:
                                            ConverionUtility.kelvinToCelcius(
                                                state.forecastWeather![index]
                                                    .daily![0].temp!.min!),
                                      ),
                                    ),
                                    TempAndCompanyName(
                                      currentTemp:
                                          ConverionUtility.kelvinToCelcius(state
                                              .forecastWeather![index]
                                              .daily![0]
                                              .temp!
                                              .day!),
                                    ),
                                    // forecast  section
                                    Forecast(
                                      listHourly:
                                          state.forecastWeather![index].hourly,
                                      listDaily:
                                          state.forecastWeather![index].daily,
                                    ),
                                    // detail section
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    DetailSection(
                                      current:
                                          state.forecastWeather![index].current,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MapSection(
                                        lat: state.forecastWeather![index].lat,
                                        lon: state.forecastWeather![index].lon),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    WindSection(
                                        windSpeed:
                                            ConverionUtility.convertMpsToMph(
                                                    state
                                                        .forecastWeather![index]
                                                        .current!
                                                        .windSpeed!)
                                                .toStringAsFixed(0),
                                        windPressureHg: ConverionUtility
                                                .convertAirPressureHpaToHg(
                                                    (state
                                                        .forecastWeather![index]
                                                        .current!
                                                        .pressure!))
                                            .toStringAsFixed(2)),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    PrecipitationSection()
                                  ],
                                ),
                              ),
                            )))));
          default:
            return const Material(
                child: const Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
