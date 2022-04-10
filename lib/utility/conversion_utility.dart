import 'package:intl/intl.dart';

class ConverionUtility {
  static String kelvinToCelcius(double? temperature) {
    return (temperature! - 273.15).toStringAsFixed(0);
  }

  static String celciusToFarenheit(double temperature) {
    return ((temperature * 9 / 5) + 32).toStringAsFixed(0);
  }

  static String getHourFromUTC(int utc) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(utc * 1000);
    String timeWithMinute = DateFormat('j').format(date);
    return timeWithMinute;
  }

  static String getWeekDayFromUTC(int? utc) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(utc! * 1000);
    String weekDay = DateFormat('EEEE').format(date);
    return weekDay;
  }

  static double convertAirPressureHpaToHg(int hpa) {
    return (hpa * 0.02953);
  }

  static double convertMpsToMph(double mps) {
    return 2.237 * mps;
  }
}
