import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spending;
  final double spendingpercent;

  ChartBar({this.label, this.spending, this.spendingpercent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 20, child: FittedBox(child: Text('\u{20B9}$spending'))),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                  heightFactor: spendingpercent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(label),
      ],
    );
  }
}
