import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class ChartWidget extends StatelessWidget {

  final List<charts.Series<Task, String>> seriesPieData;

  ChartWidget({Key key, this.seriesPieData}) : super(key: key);

  void _generateData() {
    final pieData = [
      new Task(task: 'Arriendo', taskValue: 450000, color: Colors.lightGreen),
      new Task(task: 'Empanadas', taskValue: 80500, color: Colors.lightBlue),
      new Task(task: 'Préstamo', taskValue: 220000, color: Colors.orange),
      new Task(task: 'Servicios', taskValue: 98000, color: Colors.yellow),
      new Task(task: 'Internet', taskValue: 70000, color: Colors.red[200]),
    ];

    seriesPieData.clear();
    seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task, _ ) => task.task,
        measureFn: (Task task, _ ) => task.taskValue,
        colorFn: (Task task, _ ) =>
          charts.ColorUtil.fromDartColor(task.color),
        id: 'Expenses',
        labelAccessorFn: (Task row, _ ) => '${row.taskValue}',
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