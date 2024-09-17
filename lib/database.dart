import 'package:flutter_polindrome/input_model.dart';
import 'package:sqflite/sqflite.dart';

class PalindromeDatabase {
  static final PalindromeDatabase instance = PalindromeDatabase._internal();

  static Database? _database;

  PalindromeDatabase._internal();

  Future<InputModel> create(InputModel input) async {
    final db = await instance.database;
    final id = await db.insert(PalindromeFields.tableName, input.toJson());
    return input;
  }

  Future<List<InputModel>?> read() async {
    List<InputModel> results = [];
    final db = await instance.database;
    final List<Map<String, Object?>> maps = await db.query(
      PalindromeFields.tableName,
    );
    for (final map in maps) {
      int isPalindrome = map[PalindromeFields.palindName] as int;
      results.add(
        InputModel(
          id: map[PalindromeFields.idName] as int,
          input: map[PalindromeFields.inputName] as String,
          isPalindrome: isPalindrome == 0 ? false : true,
        ),
      );
    }
    return results;
  }

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE ${PalindromeFields.tableName} (
          ${PalindromeFields.idName} ${PalindromeFields.idType} ${PalindromeFields.idReq},
          ${PalindromeFields.inputName} ${PalindromeFields.inputType} ${PalindromeFields.inputReq},
          ${PalindromeFields.palindName} ${PalindromeFields.palindType} ${PalindromeFields.palindReq}
        )
      ''');
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/${PalindromeFields.tableName}.db';
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }
}

class PalindromeFields {
  static const tableName = 'palindrome';

  static const idName = 'id';
  static const idType = 'INTEGER';
  static const idReq = 'PRIMARY KEY AUTOINCREMENT';

  static const inputName = 'INPUT';
  static const inputType = 'TEXT';
  static const inputReq = 'NOT NULL';

  static const palindName = 'isPalindrome';
  static const palindType = 'BOOLEAN';
  static const palindReq = 'NOT NULL';
}
