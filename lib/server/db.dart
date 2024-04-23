import 'package:flutter_app_2/models/expences.dart';
import 'package:hive/hive.dart';

class Db {
  //create a DB referance
  final _db_Box = Hive.box('expencesDB');
  List<ExpenceMode> expenceList = [];

  void creatreInitialDb() {
    expenceList = [
      ExpenceMode(
          title: 'Grocery',
          amount: 100.0,
          date: DateTime.now(),
          category: Category.food),
      ExpenceMode(
          title: 'Transport',
          amount: 50.0,
          date: DateTime.now(),
          category: Category.transport),
      ExpenceMode(
          title: 'Movie',
          amount: 200.0,
          date: DateTime.now(),
          category: Category.entertainment),
      ExpenceMode(
          title: 'Medicine',
          amount: 150.0,
          date: DateTime.now(),
          category: Category.health),
    ];
  }

//load data
  void LoadData() {
    final dynamic data = _db_Box.get('ex_data');
    if (data != null && data is List<dynamic>) {
      expenceList = data.cast<ExpenceMode>().toList();
    }
  }

//update data
  Future<void> updatData() async {
    await _db_Box.put('ex_data', expenceList);
    print("data saved");
  }
}
