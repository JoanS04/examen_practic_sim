import 'package:examen_practic_sim/Models/User.dart';
import 'package:examen_practic_sim/Providers/db_provider.dart';
import 'package:flutter/foundation.dart';

/*
Aquest provider ens permetra carregar una llista de scans.
A mes del nombre de scans que tenim de cada tipus.
*/

class ScanListProvider extends ChangeNotifier{
  List<User> scans = [];

  String tipusSeleccionat = "http";

  /*
  Funcio per afegir un nou scan a la llista i a la base
  de dades.
  */

  void nouScan(User user) async {
    final id = await DBProvider.db.insertScan(user);
    user.id = '$id';

    this.scans.add(user);

    notifyListeners();
  }

  /*
  Funcio per carregar tots els scans de la base de dades.
  */

  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }



  /*
  Funcio per esborrar un scan a partir de la seva id.
  */

  esborraPerID(int id) async {
    final res = await DBProvider.db.deleteScan(id as int);
  }

  /*
  Funcio per actualitzar el total de scans de tipus http.
  */

}