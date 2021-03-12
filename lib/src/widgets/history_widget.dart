import 'package:cashcontrol/src/modelos/expense_model.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {

  //final List<Map<String, dynamic>> items;
  final List<ExpenseModel> items;
  
  HistoryWidget({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.65,
      width: size.width,
      padding: EdgeInsets.all(20.0),
      child: ( items.length == 0 )
        ? Align(
            alignment: Alignment.topCenter,
            child: Text(
              'No tienes movimientos en este rango de fechas',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          )
        : ListView(
            children: List.generate(
              items.length,
              (index) {
                return _buildListItem(
                  size: size,
                  title: items[index].concept,
                  price: items[index].amount.toString(),
                  hour: _getHourFromDate(items[index].createdAt),
                  titleColor: Colors.black
                );
              }
            ).toList()
          )
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
}