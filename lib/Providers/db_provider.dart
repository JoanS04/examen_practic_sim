import 'dart:io';


import 'package:examen_practic_sim/Models/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/*
Classe que ens permetraa interactuar amb la base de dades.
*/

class DBProvider {

  // Patro singleton per crear una unica instancia de la base de dades.
  static Database? _database;
  static DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if(_database == null) _database = await initDB();

    return _database!;
    
  }

  /*
  Funcio per crear la base de dades.
  */
  Future<Database> initDB() async{
  
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Users.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: ((db) {}),
      onCreate: (Database db, int version) async{
        await db.execute("""
          CREATE TABLE Users(
            id INTEGER PRIMARY KEY,
            name TEXT,
            address TEXT,
            email TEXT,
            phone TEXT,
            photo TEXT
          );
        """);
      },
      );
  }

  /*
  Funcions per inserir a la base de dades.
  Amb rawInsert podem fer una insercio directa a la base de dades.
  */

  Future<int> insertRawScan(User nouScan) async{
    final id = nouScan.id;
    final name = nouScan.name;
    final address = nouScan.address;
    final email = nouScan.email;
    final phone = nouScan.phone;
    final photo = nouScan.photo;

    final db = await database;

    final res = await db.rawInsert("""
      INSERT INTO Users (id, tipus, valor)
      VALUES ($id, $name, $address, $email, $phone, $photo)
    """);

    return res;
  }

  /*
  Amb insert podem fer una insercio a la base de dades a partir d'un mapa.
  */

  Future<int> insertScan(User nouScan) async{
    final db = await database;

    final res = await db.insert("Users", nouScan.toMap());
    print(res);
    return res;
  }

  /*
  Funcions per obtenir dades de la base de dades.
  Amb rawQuery podem fer una consulta directa a la base de dades.
  */

  Future<List<User>> getAllScans() async{
    final db = await database;
    final res = await db.query("Users");

    return res.isNotEmpty ? res.map((e) => User.fromMap(e)).toList() : [];
  }

  /*
  Amb query podem fer una consulta a la base de dades sense utilitzar la 
  sintaxis SQL.
  */

  Future<User?> getScanById(int id) async{
    final db = await database;
    final res = await db.query("Users", where: "id = ?", whereArgs: [id]);

    if (res.isNotEmpty){
      return User.fromMap(res.first);
    }
    return null;
  }



  /*
  Funcio per actualitzar un scan a la base de dades.
  */

  Future<int> updateScans(User nouScan) async {
    final db = await database;
    final res = await db.update("Users", nouScan.toMap(), where: "id = ?", whereArgs: [nouScan.id]);

    return res;
  }

  /*
  Funcio per esborrar tota la taula Scans de la base dedades.
  */

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("""
      DELETE FROM Users
    """);

    return res;
  }

  /*
  Funcio per esborrar un scan a partir de la seva id.
  */

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete("Users", where: "id = ?", whereArgs: [id]);

    return res;
  }
}