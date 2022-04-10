import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class Utility {
  // network status finder
  static Future<bool> checkNetworkStatus() async {
    bool isConnected = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return isConnected = true;
        } else {
          return isConnected;
        }
      } on SocketException catch (_) {
        return isConnected = false;
      }
    } else {
      return isConnected;
    }
  }
}
