// import 'package:example/pages/custom_column_table.dart';
// import 'package:example/pages/custom_column_table.dart';
import 'package:example/pages/simple_table.dart';
import 'package:flutter/material.dart';
import 'package:example/pages/add_entry.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RootPage(),
      routes: {
        '/addEntry': (context) => FormHomePage(),
      },
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            // CustomColumnTable(),
            SimpleTable()
          ],
        ),
      ),
    );
  }
}