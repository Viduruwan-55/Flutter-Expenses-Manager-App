import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/expences.dart';
import 'package:flutter_app_2/widgets/expence_tile.dart';

class ExpenceList extends StatelessWidget {
  final void Function(ExpenceMode expence) onDeleteEcpence;

  const ExpenceList(
      {super.key, required this.expences, required this.onDeleteEcpence});

  final List<ExpenceMode> expences;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expences.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Dismissible(
              // background: stackBehindDisimiss(),
              key: ValueKey(expences[index]),
              direction: DismissDirection.startToEnd,
              onDismissed: (direction) {
                onDeleteEcpence(expences[index]);
              },
              child: ExpenceTile(
                expenceTile: expences[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
