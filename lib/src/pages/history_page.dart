import 'package:cashcontrol/src/widgets/filter_widget.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            icon: Icon(Icons.arrow_back_rounded, color: Colors.black,),
            onPressed: () => {},
          ),

          GestureDetector(
            child: Text('26 feb. 2021 - 01 mar. 2021', style: TextStyle(color: Colors.black, fontSize: 18.0),),
            onTap: () => _openFilterWidget(context),
          ),

          IconButton(
            icon: Icon(Icons.arrow_forward_rounded, color: Colors.black,),
            onPressed: () => {},
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
        children: [

          Text('Hoy', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
          SizedBox(height: 20.0,),

          _buildListItem(
            size: size,
            title: 'Empanadas',
            price: '3.500,00',
            hour: '06.30',
            titleColor: Colors.green
          ),

          _buildListItem(
            size: size,
            title: 'Pago arriendo',
            price: '500.000,00',
            hour: '07.30',
            titleColor: Colors.black
          ),

          _buildListItem(
            size: size,
            title: 'Pago préstamo',
            price: '650.000,00',
            hour: '10.30',
            titleColor: Colors.black
          ),

          SizedBox(height: 10.0,),
          Text('Ayer', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),),
          SizedBox(height: 20.0,),

          _buildListItem(
            size: size,
            title: 'Pago servicios públicos',
            price: '400.000,00',
            hour: '07.30',
            titleColor: Colors.black
          ),

        ],
      ),
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
          return FilterWidget();
        }
      )
    );
  }
}