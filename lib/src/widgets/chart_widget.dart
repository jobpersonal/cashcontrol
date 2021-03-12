import 'dart:math';

import 'package:cashcontrol/src/modelos/expense_model.dart';
import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatelessWidget {

  //final List<charts.Series<Task, String>> seriesPieData;
  
  final List<ExpenseModel> transations;

  ChartWidget({Key key, this.transations}) : super(key: key);

  final List<charts.Series<ExpenseModel, String>> seriesPieData = [];
  final List<Color> colors = [Colors.lightGreen, Colors.lightBlue, Colors.orange, Colors.yellow, Colors.red[200], Colors.blue, Colors.grey];
  

  void _generateData() {
    final Random randomColorIndex = new Random();

    seriesPieData.clear();
    seriesPieData.add(
      charts.Series(
        data: transations,
        domainFn: (ExpenseModel transation, _ ) => transation.concept,
        measureFn: (ExpenseModel transation, _ ) => transation.amount,
        colorFn: (ExpenseModel transation, _ ) =>
          charts.ColorUtil.fromDartColor( colors[ randomColorIndex.nextInt(7) ] ),
        id: 'Expenses',
        labelAccessorFn: (ExpenseModel row, _ ) => '${row.amount}',
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    _generateData();

    return Expanded(
      child: charts.PieChart(
        seriesPieData,
        animate: true,
        animationDuration: Duration( seconds: 1 ),
        behaviors: [

          new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 2,
            //cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
            entryTextStyle: charts.TextStyleSpec(
              color: charts.MaterialPalette.black,
              fontSize: 12,
              //fontFamily: 'Georgia',
            )
          )

        ],
        defaultRenderer: new charts.ArcRendererConfig(
          arcWidth: 100,
          arcRendererDecorators: [
            new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside
            )
          ]
        ),
      ),
    );
  }
}

class Task {
  String task;
  double taskValue;
  Color color;

  Task({this.task, this.taskValue, this.color});
}