import 'package:flutter/material.dart';
import 'package:flutter_app_2/models/expences.dart';

class ExpenceTile extends StatelessWidget {
  const ExpenceTile({super.key, required this.expenceTile});

  final ExpenceMode expenceTile;
  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Color.fromARGB(224, 215, 250, 238),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(expenceTile.title,
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Text(expenceTile.amount.toStringAsFixed(2)),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expenceTile.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expenceTile.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
