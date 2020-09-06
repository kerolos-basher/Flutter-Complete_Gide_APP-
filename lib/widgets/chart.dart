import './ChartPar.dart';

import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> resentTransactions;
  Chart(this.resentTransactions);

  List<Map<String, Object>> get groubedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalamount = 0.0;
      for (var i = 0; i < resentTransactions.length; i++) {
        if (resentTransactions[i].date.day == weekDay.day &&
            resentTransactions[i].date.month == weekDay.month &&
            resentTransactions[i].date.year == weekDay.year)
          totalamount += resentTransactions[i].amount;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalamount
      };
    }).reversed.toList();
  }

  double get totalspendinginweek {
    return groubedTransactionValue.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groubedTransactionValue.map((data) {
            return Flexible(
                fit: FlexFit.tight,
                child: Chartpar(
                    data['day'],
                    data['amount'],
                    totalspendinginweek == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalspendinginweek));
          }).toList(),
        ),
      ),
    );
  }
}
