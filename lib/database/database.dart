import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'travel_rinjani.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tickets(id TEXT PRIMARY KEY, nama TEXT, noTelp TEXT, jumlah_orang INTEGER, pemandu TEXT, total TEXT, tanggalPemesanan TEXT)',
        );
      },
    );
  }

  Future<int> insertTicket(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('tickets', row);
  }

  Future<List<Map<String, dynamic>>> queryAllTickets() async {
    Database db = await database;
    return await db.query('tickets', orderBy: 'tanggalPemesanan DESC');
  }

  Future<int> deleteTicket(String id) async {
    Database db = await database;
    return await db.delete('tickets', where: 'id = ?', whereArgs: [id]);
  }
}
