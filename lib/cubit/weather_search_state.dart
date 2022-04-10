part of 'weather_search_cubit.dart';

enum ApiSearchStatus {
  initial,
  success,
  loading,
  failure,
}

class WeatherApiSearchState extends Equatable {
  const WeatherApiSearchState(
      {this.status = ApiSearchStatus.initial,
      this.msgText = '',
      this.isConnected = true,
      this.latAndLon = const <String, dynamic>{}});
  final ApiSearchStatus status;
  final String msgText;
  final bool isConnected;
  final Map<String, dynamic>? latAndLon;
  WeatherApiSearchState copyWith(
      {ApiSearchStatus? status,
      String? msgText,
      bool? isConnected,
      Map<String, dynamic>? latAndLon}) {
    return WeatherApiSearchState(
        status: status ?? this.status,
        msgText: msgText ?? this.msgText,
        isConnected: isConnected ?? this.isConnected,
        latAndLon: latAndLon ?? this.latAndLon);
  }

  @override
  List<Object?> get props => [status, msgText, latAndLon, isConnected];
}
