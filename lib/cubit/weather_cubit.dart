import 'package:api_cubit/data/data_provider/database/weather_table.dart';
import 'package:api_cubit/data/model/current_weather_model.dart';
import 'package:api_cubit/data/model/forecase_model.dart';
import 'package:api_cubit/data/model/weather.dart';
import 'package:api_cubit/data/repository/repo_weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherApiState> {
  WeatherRepository? weatherRepo;
  WeatherCubit({@required this.weatherRepo})
      : super(const WeatherApiState(
            status: ApiStatus.initial, forecastWeather: [])) {
    checkRecords();
  }

  void checkRecords() async {
    int? totalRecord = await WeatherDBTable().fetchTotalRecords();
    if (totalRecord! > 0) {
      List<WeatherDBModel> data =
          await WeatherDBTable().fetchAllWeatherDBModel();
      if (data.isNotEmpty) {
        for (var weatherdb in data) {
          await fetchCurrentWeatherByName(weatherdb.city!);
        }
      }
    } else {
      await fetchCurrentWeatherByName("Islamabad");
    }
  }

  // fetch the forecost data by(lat And lon)
  Future<ForecastModel> getForecastByLatAndLon(double lat, double lon) async {
    ForecastModel forecast = await weatherRepo!.getForecast(lat, lon);
    return forecast;
  }

  // fetch current weather data
  Future fetchCurrentWeatherByName(String cityName) async {
    try {
      if (!(state.listCity!.contains(cityName.toLowerCase()))) {
        CurrentWeather? currentWeather =
            await weatherRepo!.getCurrentWeatherStatus(cityName);
        ForecastModel forecast = await getForecastByLatAndLon(
            currentWeather!.coord!.lat!, currentWeather.coord!.lon!);
        emit(state.copyWith(
            status: ApiStatus.success,
            listCity: [...state.listCity!, currentWeather.name!.toLowerCase()],
            forecastWeather: [...state.forecastWeather!, forecast]));
        bool flag = await WeatherDBTable().isCityWeatherExist(
            currentWeather.coord!.lat!, currentWeather.coord!.lon!);
        if (!flag) {
          saveCityDataToDB(currentWeather);
        }
      } else {
        emit(state.copyWith(
            status: ApiStatus.success,
            listCity: [...state.listCity!],
            forecastWeather: [...state.forecastWeather!]));
      }
    } catch (_) {}
  }

  void saveCityDataToDB(CurrentWeather currentWeather) async {
    Map<String, dynamic> weatherData = {
      "city": currentWeather.name,
      "country": currentWeather.sys!.country!.toLowerCase(),
      "lat": currentWeather.coord!.lat,
      "lon": currentWeather.coord!.lon,
      "updatedDate": DateTime.now().millisecondsSinceEpoch,
      "createdDate": DateTime.now().millisecondsSinceEpoch
    };
    await WeatherDBTable().addWeather(WeatherDBModel.fromJson(weatherData));
  }

  //fetch location by lat and lon
  // Future fetchWeatherByLatAndLon(double lat, double lon) async {
  //   ForecastModel forecast = await weatherRepo!.getForecast(lat, lon);
  //   emit(state.copyWith(
  //       status: ApiStatus.success,
  //       forecastWeather: [...state.forecastWeather, forecast]));
  //   return Future.value();
  // }
  //
  // void fetchWeatherByName(String cityName) async {
  //   CurrentWeather curWeather =
  //       await weatherRepo!.getCurrentWeatherStatus(cityName);
  //   await fetchWeatherByLatAndLon(
  //       curWeather.coord!.lat!, curWeather.coord!.lon!);
  // }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
