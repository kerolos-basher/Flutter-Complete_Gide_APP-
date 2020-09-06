import 'package:flutter/material.dart';

class Chartpar extends StatelessWidget {
  final String laple;
  final double spendingAmount;
  final double spendingOfTotal;

 const Chartpar(this.laple, this.spendingAmount, this.spendingOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight * .15,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * .05,
            ),
            Container(
              height: constrains.maxHeight * .6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * .05,
            ),
            Container(
              height: constrains.maxHeight * .15,
              child: FittedBox(child: Text(laple)),
            ),
          ],
        );
      },
    );
  }
}
