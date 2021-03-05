import 'package:flutter/material.dart';

class SharedMenu extends StatelessWidget {
  const SharedMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Column(
              children: [
                Icon(Icons.account_circle, size: 70.0, color: Colors.blue),
                Text("NoMY APP"),
                Expanded(
                  child: ListTile(
                    title: Text("Dashboard"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.pushNamed(context, "/");
                    },
                  ),
                ),
              ],
            )),
            ListTile(
              title: Text("Consortium"),
              leading: Icon(Icons.camera, color: Colors.blue),
              onTap: () {
                Navigator.pushNamed(context, '/create_consortium');
              },
            )
          ],
        ),
      );
}
