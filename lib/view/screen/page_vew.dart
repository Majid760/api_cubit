import 'package:api_cubit/cubit/authentication_cubit.dart';
import 'package:api_cubit/cubit/weather_cubit.dart';
import 'package:api_cubit/view/screen/home_screen.dart';
import 'package:api_cubit/view/screen/sign_in_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPageView extends StatefulWidget {
  WeatherPageView({Key? key, @required this.index}) : super(key: key);
  final int? index;

  @override
  State<WeatherPageView> createState() => _WeatherPageViewState();
}

class _WeatherPageViewState extends State<WeatherPageView> {
  PageController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.index!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherApiState>(
        builder: (BuildContext context, Apistate) {
      switch (Apistate.status) {
        case ApiStatus.failure:
          return const Material(
              child: Center(child: Text('something went wrong!')));
        case ApiStatus.initial:
          return const Material(
              child: Center(child: CircularProgressIndicator()));
        case ApiStatus.success:
          return BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (BuildContext context, Autheticationstate) {
            switch (Autheticationstate.status) {
              case AuthStatus.authenticated:
                return PageView.builder(
                  itemCount: Apistate.forecastWeather!.length,
                  scrollDirection: Axis.horizontal,
                  controller: _controller,
                  padEnds: false,
                  itemBuilder: (context, index) {
                    return HomePage(index: index);
                  },
                  // Can be null
                );
              case AuthStatus.unauthenticated:
                {
                  return SignInScreen();
                }
              default:
                return SignInScreen();
            }
          });
        default:
          return const Material(
              child: Center(child: CircularProgressIndicator()));
      }
    });
  }
}
