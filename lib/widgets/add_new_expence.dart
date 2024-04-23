import 'package:flutter/cupertino.dart';
import '../models/expences.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddNewExpence extends StatefulWidget {
  final void Function(ExpenceMode expence) onAddExpence;
  const AddNewExpence({super.key, required this.onAddExpence});

  @override
  State<AddNewExpence> createState() => _AddNewExpenceState();
}

class _AddNewExpenceState extends State<AddNewExpence> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  Category _selectedCategory = Category.food;

  final DateTime initialDate = DateTime.now();
  final DateTime firstDate = DateTime(
      DateTime.now().year - 1, DateTime.now().month, DateTime.now().day);
  final DateTime lastDate = DateTime(
      DateTime.now().year + 1, DateTime.now().month, DateTime.now().day);
  DateTime _selectedDate = DateTime.now();

  //date piker
  Future<void> _selectDate() async {
    try {
      //show date model that store the user to choose
      final pikeDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate);

      setState(() {
        _selectedDate = pikeDate!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

//handle form submit
  void _handleFormSubmit() {
    final userAmount = double.parse(_amountController.text.trim());
    if (_titleController.text.trim().isEmpty || userAmount <= 0) {
      showDialog(
          context: context,
          builder: (context) {
            return (AlertDialog(
              title: const Text('Enter valied data'),
              content: const Text(
                  'Please enter valid data for the Titile and the amount, then title cann\'t be empty & amount should be greater than \'0\'.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('close'),
                )
              ],
            ));
          });
    } else {
      ExpenceMode newExpence = ExpenceMode(
          title: _titleController.text.trim(),
          amount: userAmount,
          date: _selectedDate,
          category: _selectedCategory);
      widget.onAddExpence(newExpence);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
                labelText: 'Title', hintText: 'Enter the title'),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          Row(
            children: [
              //amount
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                      labelText: 'Amount', hintText: 'Enter the amount'),
                  keyboardType: TextInputType.number,
                ),
              ),
              Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(fomattedDate.format(_selectedDate)),
                IconButton(
                    onPressed: _selectDate,
                    icon: const Icon(Icons.date_range_outlined)),
              ])),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.redAccent),
                    ),
                    child: const Text('Close'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: _handleFormSubmit,
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.greenAccent),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
