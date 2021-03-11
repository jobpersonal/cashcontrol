import 'package:cashcontrol/src/widgets/bottonNavigatorBar_page.dart';
import 'package:cashcontrol/src/widgets/chart_widget.dart';
import 'package:flutter/material.dart';

import 'package:cashcontrol/src/utils/colores.dart';
import 'package:cashcontrol/src/widgets/filter_widget.dart';
import 'package:cashcontrol/src/widgets/history_widget.dart';

import 'package:charts_flutter/flutter.dart' as charts;


class HistoryPage extends StatefulWidget {

  final String title;
  final Color backgroundPageColor;
  final String fromTo;

  HistoryPage({Key key, this.title = 'Historial', this.backgroundPageColor = Colores.primnary, this.fromTo = 'history'}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  DateTime _startDate;
  DateTime _endDate;
  String titleDates =  '';

  List<String> monthAbrevation = ['ene', 'feb', 'mar', 'abr', 'may', 'jun', 'jul', 'ago', 'sep', 'oct', 'nov', 'dic'];

  List<Map<String, dynamic>> items = [
    {
      'title': 'Empanadas',
      'price': '3.500,00',
      'date': DateTime(2021, 2, 26, 8, 25),
    },
    {
      'title': 'Pago arriendo',
      'price': '500.500,00',
      'date': DateTime(2021, 2, 26, 9, 30),
    },
    {
      'title': 'Pago préstamo',
      'price': '650.500,00',
      'date': DateTime(2021, 2, 28, 10, 15),
    },
    {
      'title': 'Pago préstamo casa',
      'price': '1.200.000,00',
      'date': DateTime(2021, 3, 1, 7, 45),
    },
    {
      'title': 'Pago Servicios públicos',
      'price': '220.500,00',
      'date': DateTime(2021, 3, 2, 8, 10),
    },
    {
      'title': 'Paseo',
      'price': '125.000,00',
      'date': DateTime(2021, 3, 3, 8, 5),
    },
    {
      'title': 'Bicicleta',
      'price': '678.000,00',
      'date': DateTime(2021, 3, 3, 8, 30),
    },
    {
      'title': 'Escritorio',
      'price': '80.000,00',
      'date': DateTime(2021, 3, 3, 11, 50),
    },
    {
      'title': 'Internet',
      'price': '77.500,00',
      'date': DateTime(2021, 3, 4, 8, 40),
    },
    {
      'title': 'Plan de datos',
      'price': '89.000,00',
      'date': DateTime(2021, 3, 5, 11),
    },
    {
      'title': 'Mac',
      'price': '9.800.000,00',
      'date': DateTime(2021, 3, 9, 12, 25),
    },
    {
      'title': 'Play 5',
      'price': '3.500.000,00',
      'date': DateTime(2021, 3, 10, 8, 10),
    },
    {
      'title': 'Televisor',
      'price': '4.200.000,00',
      'date': DateTime(2021, 3, 10, 9, 23),
    },
    {
      'title': 'Parlante',
      'price': '250.000,00',
      'date': DateTime(2021, 3, 24, 10, 50),
    },
  ];

  List<Map<String, dynamic>> itemsTemp = [];


  List<charts.Series<Task, String>> _seriesPieData;

  void _generateData() {
    final pieData = [
      new Task(task: 'Arriendo', taskValue: 450000, color: Colors.lightGreen),
      new Task(task: 'Empanadas', taskValue: 80500, color: Colors.lightBlue),
      new Task(task: 'Préstamo', taskValue: 220000, color: Colors.orange),
      new Task(task: 'Servicios', taskValue: 98000, color: Colors.yellow),
      new Task(task: 'Internet', taskValue: 70000, color: Colors.red[200]),
    ];

    _seriesPieData.add(
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
  void initState() {
    super.initState();

    _seriesPieData = [];
    _generateData();

    itemsTemp = items;

    _setCurrentFilterDates();

    _filterItems();

  }

  void _setCurrentFilterDates() {

    final weekDay = DateTime.now().weekday;
    _startDate = DateTime.now().subtract( Duration( days: weekDay - 1) );
    _endDate = _startDate.add( Duration( days: 6 ) );

    _setFilterTitle();
  }

  void _setFilterDates(String type) {

    _startDate = ( type == 'add') ? _startDate.add( Duration( days: 7 ) ) : _startDate.subtract( Duration( days: 7 ) );
    _endDate = ( type == 'add') ? _endDate.add( Duration( days: 7 ) ) : _endDate.subtract( Duration( days: 7 ) );

    _setFilterTitle();

    _filterItems();

    setState(() {});
  }

  void _setFilterTitle() {
    final monthInit = monthAbrevation[ _startDate.month - 1 ];
    final partOne = '${_startDate.day} $monthInit. ${_startDate.year}';

    final monthEnd = monthAbrevation[ _endDate.month - 1 ];
    final partTwo = '${_endDate.day} $monthEnd. ${_endDate.year}';

    titleDates = '$partOne - $partTwo';
  }

  void _filterItems() {

    itemsTemp = items;
    final filtered = itemsTemp.where((element) => checkItemDate(element['date']) );
    itemsTemp = filtered.toList();
  }

  bool checkItemDate(DateTime date) {

    final init = DateTime(_startDate.year, _startDate.month, _startDate.day);
    final last = DateTime(date.year, date.month, date.day);
    
    print('without hour -> ${ init.difference( last ).inDays } ');

    print(' days  date  $date to startdate $_startDate -> ${ date.difference( _startDate ).inDays }');
    print(' days  startdate to date -> ${ _startDate.difference( date ).inDays }');

    if ( date.difference( _startDate ).inDays == 0 || date.difference( _endDate ).inDays == 0 ) return true;
    if ( date.isAfter( _startDate ) && date.isBefore( _endDate ) ) return true;
      
    return false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundPageColor,
      body: SafeArea(
        child: _buildBody(),
      ),
      bottomNavigationBar: BottonNavigatorBarPage(),
    );
  }

  Widget _buildBody() {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      width: _screenSize.width,
      height: _screenSize.height,
      child: Column(

        children: [

          Container(
            height: _screenSize.height * 0.1,
            padding: EdgeInsets.only(left: 12.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: _buildColumnHeader()
            )
          ),

          Expanded(child: _buildColumnContent(_screenSize)),

        ],

      ),
    );
  }

  Widget _buildColumnHeader() {

    return Row(
      children: [

        IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(width: 100.0,),

        Text(widget.title, style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,)

      ],
    );

  }

  Widget _buildColumnContent(Size size) {

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        )
      ),
      child: Column(

        children: [

          SizedBox(height: 10.0,),
          _buildColumnContentHeader(size),


          (widget.fromTo == 'history')
            ? HistoryWidget( items: itemsTemp, )
            : ChartWidget( seriesPieData: _seriesPieData,),
          
        ],

      ),
    );
  }

  Widget _buildColumnContentHeader(Size size) {

    return Container(
      height: size.height * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          IconButton(
            splashRadius: 25.0,
            icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
            onPressed: () => _setFilterDates('subtract'),
          ),

          GestureDetector(
            child: Text(titleDates, style: TextStyle(color: Colors.black, fontSize: 18.0),),
            onTap: () => _openFilterWidget(context),
          ),

          IconButton(
            splashRadius: 25.0,
            icon: Icon(Icons.arrow_forward_rounded, color: Colors.black,),
            onPressed: () => _setFilterDates('add'),
          ),

        ],

      ),
    );
  }
  
  void _openFilterWidget(BuildContext context) {

    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Color(0xff069fd6).withOpacity(0.4),
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 200),
        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child) {

          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );

        },
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation) {
          return FilterWidget(
            shapeBackgroundColor: Color(0xff0af5ca),
            contentBackgroundColor: Color(0xff069fd6)
          );
        }
      )
    );
  }
}