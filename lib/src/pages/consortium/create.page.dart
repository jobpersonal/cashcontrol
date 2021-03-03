import 'package:flutter/material.dart';

class ConsortiumCreatePage extends StatefulWidget {
  ConsortiumCreatePage({Key key}) : super(key: key);

  @override
  _ConsortiumCreatePageState createState() => _ConsortiumCreatePageState();
}

class _ConsortiumCreatePageState extends State<ConsortiumCreatePage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(),
    bottomNavigationBar: FloatingActionButton(
      onPressed: () {},
      child: Icon(
        Icons.save
      ),
    ),
  );
}