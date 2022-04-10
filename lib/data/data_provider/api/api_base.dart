import 'package:api_cubit/utility/internet_checking_utility.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getInstance;
import 'export_api.dart';

class ApiBase {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiEndPoints.BASE_URL,
      connectTimeout: ApiConfig.CONNECT_TIMEOUT,
      receiveTimeout: ApiConfig.RECEIVE_TIMEOUT,
    ),
  );

  Future<dynamic> apiGet(String url) async {
    late Response dioResponse;
    if ((await Utility.checkNetworkStatus())) {
      try {
        await dio.get(url).then((value) {
          if (value.statusCode == 200) {
            dioResponse = value;
          }
        });
        return dioResponse;
      } on DioError catch (e) {
        return e;
      }
    } else {
      getInstance.Get.defaultDialog(
        title: "No Internet",
        middleText: "Please check your internet connection!(no data)",
        backgroundColor: Colors.blue.shade200,
        onCancel: () {
          getInstance.Get.back();
        },
        cancelTextColor: Colors.white,
        titleStyle: const TextStyle(color: Colors.white),
        middleTextStyle: const TextStyle(color: Colors.white),
      );
    }
  }

  Future<dynamic> apiPost(
    String url,
    dynamic data,
  ) async {
    late Response dioResponse;
    try {
      await dio.post(url, data: data).then((value) {
        if (value.statusCode == 200 || value.statusCode == 201) {
          dioResponse = value;
        }
      });
      return dioResponse;
    } on DioError catch (e) {
      return e;
    }
  }
}
