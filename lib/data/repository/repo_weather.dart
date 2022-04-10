import 'package:api_cubit/data/data_provider/api/export_api.dart';
import 'package:api_cubit/data/model/current_weather_model.dart';
import 'package:api_cubit/data/model/forecase_model.dart';

class WeatherRepository {
  // get the currentweather
  Future<CurrentWeather?> getCurrentWeatherStatus(String city) async {
    try {
      var data = await WeatherApi().getCurrentWeatherApi(city);
      CurrentWeather curWeather = CurrentWeather.fromJson(data);
      return curWeather;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // get the forecast
  Future<ForecastModel> getForecast(double? lat, double? lon) async {
    var data = await WeatherApi().getForeCastApi(lat!, lon!);
    ForecastModel forecast = ForecastModel.fromJson(data);
    return forecast;
  }
}
