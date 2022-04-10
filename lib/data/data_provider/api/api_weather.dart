import 'package:dio/dio.dart';

import 'export_api.dart';

class WeatherApi {
  final ApiBase _apiBase = ApiBase();
  var _apiResponse;

  // get CurrentWeather
  Future<dynamic> getCurrentWeatherApi(String cityName) async {
    dynamic data;
    try {
      _apiBase.dio.options.headers['Content-Type'] = 'application/json';
      _apiBase.dio.options.headers['Accept'] = "application/json";
      _apiBase.dio.options.queryParameters = {
        "appid": ApiConfig.API_KEY,
        "q": cityName,
      };
      var response = await _apiBase.apiGet(ApiEndPoints.CURRENTWEATHERSTATUS);
      if (response.statusCode == 200) {
        data = response.data;
      } else {
        return data;
      }
      return data;
    } on DioError catch (_) {
      // throw Exception(e);
    } catch (_) {
      // throw Exception(e);
    }
  }

  // get ForeCast
  Future<dynamic> getForeCastApi(double lat, double lon) async {
    dynamic data;
    try {
      _apiBase.dio.options.headers['Content-Type'] = 'application/json';
      _apiBase.dio.options.headers['Accept'] = "application/json";
      _apiBase.dio.options.queryParameters = {
        "appid": ApiConfig.API_KEY,
        "lat": lat,
        "lon": lon
      };
      var response = await _apiBase.apiGet(ApiEndPoints.ONECALLFORECASTAPI);
      if (response.statusCode == 200) {
        data = response.data;
      } else {
        return data;
      }
      return data;
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<dynamic> postForeCast({
  //   required Map<String, dynamic> creditCardMap,
  // }) async {
  //   try {
  //     _apiBase.dio.options.headers['Content-Type'] = 'application/json';
  //     _apiBase.dio.options.headers['Accept'] = "application/json";
  //     await _apiBase
  //         .apiPost(ApiEndPoints.FIVEDAYFORECASTAPI, creditCardMap)
  //         .then((value) {
  //       _apiResponse = value;
  //     });
  //     return _apiResponse;
  //   } on DioError catch (e) {
  //     return e;
  //   }
  // }

  // get categories with natively( without package)

  // Future<dynamic> getCategory() async {
  //   try {
  //     String basicAuth = 'Basic ' +
  //         base64Encode(utf8
  //             .encode('$ApiConfig.CONSUMER_KEY:$ApiConfig.CONSUMER_SECRET'));
  //     print(basicAuth);
  //     var url = Uri.parse(ApiEndPoints.BASE_URL);
  //     // ssl
  //     // HttpClient httpClient = HttpClient()
  //     //   ..badCertificateCallback =
  //     //       ((X509Certificate cert, String host, int port) => true);
  //     // IOClient ioClient = IOClient(httpClient);
  //     // final respone = await ioClient.get(
  //     //   url,
  //     //   headers: {
  //     //     HttpHeaders.contentTypeHeader: 'application/json',
  //     //     HttpHeaders.authorizationHeader: basicAuth,
  //     //   },
  //     // );
  //
  //     var respone = await http
  //         .get(url, headers: <String, String>{'authorization': basicAuth});
  //
  //     if (respone.statusCode == 200) {
  //       print(respone.body);
  //     }
  //     print(respone.statusCode);
  //     print(respone.body);
  //     return respone;
  //   } on DioError catch (e) {
  //     return e;
  //   }
  // }
}
