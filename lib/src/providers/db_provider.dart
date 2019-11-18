import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'package:constructor_rajuma/src/models/empleado_model.dart';
import 'package:constructor_rajuma/src/models/sucursal_model.dart';
import 'package:constructor_rajuma/src/models/supervisor_model.dart';
import 'package:constructor_rajuma/src/models/herramienta_model.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  final _url = "https://zeos-app.firebaseio.com";

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'HerramientasRajumaDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        final batch = db.batch();
        //batch.execute("");
        batch.rawQuery('CREATE TABLE sucursales ('
            ' id_suc TEXT PRIMARY KEY,'
            ' nombre TEXT'
            ')');
        batch.rawQuery('CREATE TABLE supervisores ('
            ' id_sup TEXT PRIMARY KEY,'
            ' id_suc TEXT,'
            ' FOREIGN KEY(id_suc) REFERENCES sucursales(id_suc),'
            ' nombre TEXT'
            ')');
        batch.rawQuery('CREATE TABLE empleados ('
            ' id_emp TEXT PRIMARY KEY,'
            ' id_suc TEXT,'
            ' FOREIGN KEY(id_suc) REFERENCES sucursales(id_suc),'
            ' nombre TEXT'
            ')');
        batch.rawQuery('CREATE TABLE herramientas ('
            ' id_her TEXT PRIMARY KEY,'
            ' id_suc TEXT,'
            ' FOREIGN KEY(id_suc) REFERENCES sucursales(id_suc),'
            ' id_emp TEXT,'
            ' FOREIGN KEY(id_emp) REFERENCES empleados(id_emp),'
            ' nombre TEXT,'
            ' fe_sal TEXT,'
            ' fe_ent TEXT'
            ')');
        final result = await batch.commit();
        print(result);
        // await db.execute(
        //   'CREATE TABLE herramientas ('
        //   ' id_her TEXT PRIMARY KEY,'
        //   ' id_emp TEXT  KEY,'
        //   ')');
        // await db.execute(
        //   'CREATE TABLE herramientas ('
        //   ' id_her TEXT PRIMARY KEY,'
        //   ' id_emp TEXT  KEY,'
        //   ')');
      },
    );
    //print(p)
  }

  agregarHerramientaLocal(HerramientaModel model) async {
    final db = await database;
    //final res = db.insert('herramientas', model.toJsonFull());
    //return res;
  }

  agregarHerramientaFirebase(HerramientaModel model) async {
    final url = "$_url/herramientas";

    /*final resp = await http.put("$url/${model.idHerramienta}.json",
        body: herramientaModelToJsonNoFull(model));

    final decodedData = json.decode(resp.body);

    if (decodedData == null)
      return false;
    else*/
      return true;
  }

  agregarEmpleadoLocal(EmpleadoModel model) async {
    final db = await database;
    final res = db.insert('empleados', model.toJsonFull());
    return res;
  }

  agregarEmpleadoFirebase(EmpleadoModel model) async {
    final url = "$_url/empleados";

    final resp = await http.put("$url/${model.idEmpleado}.json",
        body: empleadoModelToJsonNoFull(model));

    final decodedData = json.decode(resp.body);

    if (decodedData == null)
      return false;
    else
      return true;
  }

  agregarSucursalLocal(SucursalModel model) async {
    final db = await database;
    final res = db.insert('sucursales', model.toJsonFull());
    return res;
  }

  agregarSucursalFirebase(SucursalModel model) async {
    final url = "$_url/sucursales";

    final resp = await http.put("$url/${model.idSucursal}.json",
        body: sucursalModelToJsonNoFull(model));

    final decodedData = json.decode(resp.body);

    if (decodedData == null)
      return false;
    else
      return true;
  }

  agregarSupervisorLocal(SupervisorModel model) async {
    final db = await database;
    final res = db.insert('supervisores', model.toJsonFull());
    return res;
  }

  agregarSupervisorFirebase(SupervisorModel model) async {
    final url = "$_url/supervisores";

    final resp = await http.put("$url/${model.idSupervisor}.json",
        body: supervisorModelToJsonNoFull(model));

    final decodedData = json.decode(resp.body);

    if (decodedData == null)
      return false;
    else
      return true;
  }
}
