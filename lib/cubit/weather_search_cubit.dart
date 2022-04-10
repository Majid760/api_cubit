import 'package:api_cubit/data/model/current_weather_model.dart';
import 'package:api_cubit/data/model/suggestion_model.dart';
import 'package:api_cubit/data/repository/repo_weather.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'weather_search_state.dart';

class WeatherSearchCubit extends Cubit<WeatherApiSearchState> {
  WeatherRepository? weatherRepo;
  WeatherSearchCubit({@required this.weatherRepo})
      : super(const WeatherApiSearchState(
            status: ApiSearchStatus.initial, isConnected: true));

  void getLatAndLon(String cityName) async {
    try {
      CurrentWeather? currentWeather =
          await weatherRepo!.getCurrentWeatherStatus(cityName);
      if (currentWeather!.coord == null || currentWeather.name == null) {
        emit(state.copyWith(
            status: ApiSearchStatus.failure, msgText: 'No city found'));
      } else {
        emit(state.copyWith(
            status: ApiSearchStatus.success,
            msgText: 'city found!',
            latAndLon: <String, dynamic>{
              'lat': currentWeather.coord!.lat!,
              'lon': currentWeather.coord!.lon!
            }));
      }
    } catch (_) {
      emit(state.copyWith(
          status: ApiSearchStatus.failure,
          msgText: 'No city found!Please enter valid city'));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // debugPrint('$error, $stackTrace');
    super.onError(error, stackTrace);
  }

  // Fetch suggestion
  // Future<List<Suggestion>> fetchSuggestions(String input,
  //     [String lang = "en"]) async {}
}
