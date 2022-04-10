part of 'weather_cubit.dart';

enum ApiStatus {
  initial,
  success,
  loading,
  failure,
}

class WeatherApiState extends Equatable {
  const WeatherApiState(
      {this.status = ApiStatus.initial,
      this.forecastWeather,
      this.listCity = const []});
  final ApiStatus status;
  final List<ForecastModel>? forecastWeather;
  final List<String>? listCity;
  WeatherApiState copyWith(
      {ApiStatus? status,
      List<ForecastModel>? forecastWeather,
      List<String>? listCity}) {
    return WeatherApiState(
        status: status ?? this.status,
        forecastWeather: forecastWeather ?? this.forecastWeather,
        listCity: listCity ?? this.listCity);
  }

  @override
  List<Object?> get props => [forecastWeather, status, listCity];
}
