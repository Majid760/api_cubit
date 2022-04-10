class DataBaseTable {
  static String weatherTable = '''
      CREATE TABLE IF NOT EXISTS weather(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        city TEXT NOT NULL,
        country TEXT NOT NULL,
        lat REAL NOT NULL,
        lon REAL NOT NULL,
        updatedDate INTEGER NOT NULL,
        createdDate INTEGER NOT NULL
      )
      ''';
  static String userTable = '''
      CREATE TABLE IF NOT EXISTS user(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        displayName TEXT NOT NULL,
        userId TEXT NOT NULL,
        logedInPlatform TEXT,
        email TEXT,
        photoUrl TEXT
      )
      ''';
}
