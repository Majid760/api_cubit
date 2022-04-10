import 'dart:convert';
import 'package:api_cubit/data/model/suggestion_model.dart';
import 'package:dio/dio.dart';
import 'export_api.dart';

class SearchApi {
  final sessionToken;
  SearchApi({this.sessionToken});

  Dio dio = Dio(
    BaseOptions(
      connectTimeout: ApiConfig.CONNECT_TIMEOUT,
      receiveTimeout: ApiConfig.RECEIVE_TIMEOUT,
    ),
  );

  // get CurrentWeather
  Future<List<Suggestion>> getSearchResult(
      String input, dynamic sessionToken) async {
    try {
      // dio.options.headers['Content-Type'] = 'application/json';
      // dio.options.headers['Accept'] = "application/json";
      // dio.options.queryParameters = {
      //   "appid": ApiConfig.GOOGLE_PLACEC_API_KEY,
      // };
      var response = await dio.get(
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&types=address&language=en&key=${ApiConfig.GOOGLE_PLACEC_API_KEY}&sessiontoken=$sessionToken');
      if (response.statusCode == 200) {
        final result = json.decode(response.data);
        if (result['status'] == 'OK') {
          // compose suggestions in a list
          final rst = result['prediction'];
          print(rst);
          return result['predictions']
              .map<Suggestion>(
                  (p) => Suggestion(p['place_id'], p['description']))
              .toList();
        }
        if (result['status'] == 'ZERO_RESULTS') {
          return [];
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
