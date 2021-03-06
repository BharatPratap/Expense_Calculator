import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTxns;

  Chart(this.recentTxns);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      int totalSum = 0;

      for (var i = 0; i < recentTxns.length; i++) {
        if (recentTxns[i].date.day == weekDay.day &&
            recentTxns[i].date.month == weekDay.month &&
            recentTxns[i].date.year == weekDay.year) {
          totalSum += recentTxns[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: data['day'],
                  spending: data['amount'],
                  spendingpercent: (totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as int) / totalSpending)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
