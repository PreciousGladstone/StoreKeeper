import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:storekeeperapp/data/Item_mapper.dart';
import 'package:storekeeperapp/model/item.dart';
// import 'dart:io';

class DBService {
  DBService._();
  static final DBService instance = DBService._();

  Database? _db;

  Future<void> initDB() async {
    if (_db != null) return; //initialising _db database

    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, 'Storekeeper.db');

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, v) async {
        print('✅ TABLE Item CREATED');
        await db.execute('''
    CREATE TABLE items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    price REAL NOT NULL,
    imagePath TEXT,
    createdAt INTEGER
  )
''');
      },
    );
  }

  Future<int> createItem(Item item) async {
    await initDB();
    final id = await _db!.insert('items', ItemMapper.toMap(item));
    return id;
  }

  Future<List<Item>> getItem() async {
    await initDB();
    final row = await _db!.query('items', orderBy: 'createdAt DESC');
    

  
    return row.map((e) => ItemMapper.fromMap(e)).toList();
  }

  Future<int> updateItem(Item item) async {
    await initDB();
    return await _db!.update(
      'items',
      ItemMapper.toMap(item),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id)async {
    await initDB();
    return await _db!.delete('items', where: 'id = ?', whereArgs: [id]);
}}
      
