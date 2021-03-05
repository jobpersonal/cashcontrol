import 'package:cashcontrol/src/widgets/filter_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

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
  ];

  List<Map<String, dynamic>> itemsTemp = [];

  @override
  void initState() {
    super.initState();

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
    final filtered = itemsTemp.where((element) => ( element['date'].isAfter( _startDate ) && element['date'].isBefore( _endDate ) ) );
    itemsTemp = filtered.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xff970cf7),
      backgroundColor: Color(0xff8005FF),
      body: SafeArea(
        child: _buildBody(),
      ),
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

        Text('Historial', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w500), textAlign: TextAlign.center,)

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

          _buildColumnList(size),
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
 
  Widget _buildColumnList(Size size) {

    return Container(
      height: size.height * 0.7,
      width: size.width,
      padding: EdgeInsets.all(20.0),
      child: ListView(
        children: List.generate(
          itemsTemp.length,
          (index) {
            return _buildListItem(
              size: size,
              title: itemsTemp[index]['title'],
              price: itemsTemp[index]['price'],
              hour: _getHourFromDate(itemsTemp[index]['date']),
              titleColor: Colors.black
            );
          }
        ).toList()
      ),
      /* child: ListView(
        children: [

          Text('Hoy', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
          SizedBox(height: 20.0,),

          SizedBox(height: 10.0,),
          Text('Ayer', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
          SizedBox(height: 20.0,),

        ],
      ), */
    );

  }
  
  Widget _buildListItem({ Size size, String title, String price, String hour, Color titleColor }) {

    return Container(
      padding: EdgeInsets.all(5.0),
      width: size.width,
      height: size.height * 0.08,
      child: Column(

        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: 4.0,
                height: 4.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[400]
                ),
              ),

              SizedBox(width: 25.0,),

              Text(title, style: TextStyle(color: titleColor, fontSize: 15.0, fontWeight: FontWeight.w600),),

              Expanded(child: Text(hour, style: TextStyle( fontSize: 17.0, fontWeight: FontWeight.w600 ), textAlign: TextAlign.end,)),

            ],

          ),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                width: 1.0,
                height: 20.0,
                margin: EdgeInsets.only(left: 2.0),
                color: Colors.grey[400],
              ),

              SizedBox(width: 25.0,),

              Expanded(child: Text('\$$price', style: TextStyle(color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.w500 ))),

            ],

          )

        ],

      ),
    );

  }

  String _getHourFromDate(DateTime date) {

    final hour = date.toString().split(' ')[1].split(':');
    final newHour = '${hour[0]}.${hour[1]}';

    return newHour;
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