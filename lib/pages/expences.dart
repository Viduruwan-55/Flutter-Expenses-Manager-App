import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_2/models/expences.dart';
import 'package:flutter_app_2/server/db.dart';
import 'package:flutter_app_2/widgets/add_new_expence.dart';
import 'package:flutter_app_2/widgets/expence_list.dart';
import 'package:hive/hive.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpencesApp extends StatefulWidget {
  const ExpencesApp({super.key});

  @override
  State<ExpencesApp> createState() => _ExpencesAppState();
}

class _ExpencesAppState extends State<ExpencesApp> {
  final _db_Box = Hive.box('expencesDB');
  Db db = Db();
  // final List<ExpenceMode> expences = [
  //   ExpenceMode(
  //       title: 'Grocery',
  //       amount: 100.0,
  //       date: DateTime.now(),
  //       category: Category.food),
  //   ExpenceMode(
  //       title: 'Transport',
  //       amount: 50.0,
  //       date: DateTime.now(),
  //       category: Category.transport),
  //   ExpenceMode(
  //       title: 'Movie',
  //       amount: 200.0,
  //       date: DateTime.now(),
  //       category: Category.entertainment),
  //   ExpenceMode(
  //       title: 'Medicine',
  //       amount: 150.0,
  //       date: DateTime.now(),
  //       category: Category.health),
  // ];

  //Pie chart
  Map<String, double> dataMap = {
    "Food": 0,
    "Transport": 0,
    "Entertainment": 0,
    "Health": 0,
  };

//add new expence
  void onAddNewExpence(ExpenceMode newExpence) {
    setState(() {
      db.expenceList.add(newExpence);
      calculateTotal();
    });
    db.updatData();
  }

//function to open the model
  void _openAddExpenceModal() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AddNewExpence(onAddExpence: onAddNewExpence);
        });
  }

  //remove expence
  void onDeleteEcpence(ExpenceMode expence) {
//store the deleetd expence
    ExpenceMode deletedExpence = expence;

    final int removeIndex = db.expenceList.indexOf(expence);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Sucessfullyu Deleted'),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'undo',
        onPressed: () {
          setState(() {
            db.expenceList.insert(removeIndex, deletedExpence);
            db.updatData();
            calculateTotal();
          });
        },
      ),
    ));
    setState(() {
      db.expenceList.remove(expence);
      db.updatData();
      calculateTotal();
    });
  }

  double f_value = 0;
  double t_value = 0;
  double e_value = 0;
  double h_value = 0;

//cslulate the total expence of each category
  void calculateTotal() {
    double f_valueToatal = 0;
    double t_valueToatal = 0;
    double e_valueToatal = 0;
    double h_valueToatal = 0;

    for (final expence in db.expenceList) {
      if (expence.category == Category.food) {
        f_valueToatal += expence.amount;
      }

      if (expence.category == Category.entertainment) {
        e_valueToatal += expence.amount;
      }

      if (expence.category == Category.transport) {
        t_valueToatal += expence.amount;
      }

      if (expence.category == Category.health) {
        h_valueToatal += expence.amount;
      }
    }
    setState(() {
      f_value = f_valueToatal;
      t_value = t_valueToatal;
      e_value = e_valueToatal;
      h_value = h_valueToatal;
    });
    //update data map
    dataMap = {
      "Food": f_value,
      "Transport": t_value,
      "Entertainment": e_value,
      "Health": h_value,
    };
  }

  Widget stackBehindDisimiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20.0),
      color: Colors.red,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if fist time initial the data
    if (_db_Box.get("ex_data") == null) {
      db.creatreInitialDb();
      calculateTotal();
    } else {
      db.LoadData();
      calculateTotal();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APP_02'),
        backgroundColor: const Color.fromARGB(255, 32, 127, 174),
        actions: [
          Container(
            color: Color.fromARGB(255, 9, 205, 208),
            child: IconButton(
                onPressed: _openAddExpenceModal,
                icon: const Icon(
                  Icons.add,
                  color: Colors.blueGrey,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: PieChart(dataMap: dataMap),
          ),
          ExpenceList(
            expences: db.expenceList,
            onDeleteEcpence: (expence) {
              onDeleteEcpence(expence);
            },
          )
        ],
      ),
    );
  }
}
