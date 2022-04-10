import 'package:api_cubit/data/data_provider/database/database_service.dart';
import 'package:api_cubit/data/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserDBTable {
  // add record
  Future<int> addSignedInUser(User user) async {
    try {
      Database? _db = await DatabaseService.instance.database;
      int affectedRow = await _db!.insert(
        "user",
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return affectedRow;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> getCurrentSignedUser() async {
    try {
      Database? _db = await DatabaseService.instance.database;
      List userData = await _db!.query(
        "user",
      );
      return User.fromJson(userData[0]);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteCurrentSignedUser(String email) async {
    try {
      Database? _db = await DatabaseService.instance.database;
      int isDeleted =
          await _db!.delete("user", where: 'email = ?', whereArgs: [email]);
      return isDeleted;
    } catch (e) {
      throw Exception(e);
    }
  }

  // count the number of records
  Future<int?> fetchTotalUserRecordsLength() async {
    Database? db = await DatabaseService.instance.database;
    List? count = await db!.query('user');
    return count.length;
  }
}
