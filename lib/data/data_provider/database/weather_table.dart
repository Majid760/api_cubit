import 'package:api_cubit/data/data_provider/database/database_service.dart';
import 'package:api_cubit/data/model/weather.dart';
import 'package:sqflite/sqflite.dart';

class WeatherDBTable {
  // add record
  Future<int> addWeather(WeatherDBModel weather) async {
    Database? _db = await DatabaseService.instance.database;
    return _db!.insert(
      "weather",
      weather.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // update the record
  Future<int> updateWeatherDb(WeatherDBModel weather) async {
    Database? _db = await DatabaseService.instance.database;
    return _db!.update("weather", weather.toJson(),
        where: 'id = ?',
        whereArgs: [weather.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // fetch all city weather data
  Future<List<WeatherDBModel>> fetchAllWeatherDBModel() async {
    Database? _db = await DatabaseService.instance.database;
    String sql = 'SELECT * FROM weather ORDER BY createdDate ASC';
    List<Map> data = await _db!.rawQuery(sql);
    return data
        .map((e) => WeatherDBModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // fetch single user
  Future<WeatherDBModel> fetchSingleWeatherDBModel(int id) async {
    Database? _db = await DatabaseService.instance.database;
    var data =
        await _db!.query('weather', where: 'id', whereArgs: [id], limit: 1);
    return WeatherDBModel.fromJson(data[0]);
  }

  // check the lat and lon of a city exist or not.
  Future<bool> isCityWeatherExist(double lat, double lon) async {
    Database? _db = await DatabaseService.instance.database;
    List data = await _db!
        .rawQuery('SELECT * FROM weather WHERE lat=$lat AND lon=$lon');
    return data.isEmpty ? false : true;
  }

  // count the number of records
  Future<int?> fetchTotalRecords() async {
    Database? db = await DatabaseService.instance.database;
    List? count = await db!.query('weather');
    return count.length;
  }
}
