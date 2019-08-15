import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import 'package:example/models/content.dart' show Content;

@override
class SimpleTable extends StatefulWidget {
  _SimpleTableState createState() => _SimpleTableState();
}

class _SimpleTableState extends State<SimpleTable> {
  Future<List<dynamic>> getData(String link) async {
  List<Content> list;
    var future = http.get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
        var res = await future;
    var rest;
    // print(res.body);
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        rest = data["content"] as List;
        // print(rest);
        list = rest.map<Content>((json) => Content.fromJson(json)).toList();
        print("List Size: ${rest.length}");
      } else {
      }
    return rest;
  }
  
  Widget tableViewWidget(List content){
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
                children: [
                  JsonTable(
                    content,
                    showColumnToggle: false,
                    tableHeaderBuilder: (String header) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.5),
                            color: Colors.grey[300]),
                        child: Text(
                          header,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.display1.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              color: Colors.black87),
                        ),
                      );
                    },
                    tableCellBuilder: (value) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 2.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.9,
                                color: Colors.grey.withOpacity(0.5))),
                        // child: Text(
                        //   value,
                        //   textAlign: TextAlign.center,
                        //   style: Theme.of(context).textTheme.display1.copyWith(
                        //       fontSize: 14.0, color: Colors.grey[900]),
                        // ),
                        child: TextFormField(
                           style: Theme.of(context).textTheme.display1.copyWith(
                              fontSize: 14.0, color: Colors.grey[900]),
                          textAlign: TextAlign.left,
                          // decoration: const InputDecoration(
                          // icon: Icon(Icons.person),
                          // hintText: 'What do people call you?',
                          // labelText: 'Name *',
                          // ),
                          // initialValue: value,
                          onFieldSubmitted: (String value) {
                            setState(() {
                              print(value);
                            });
                          },
                          // validator: (String value) {
                          //   return value.contains('@') ? 'Do not use the @ char.' : null;
                          // },
                        )
                      );
                    },
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                ],
              )
      );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Master Action Table"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),
          onPressed: (){
            Navigator.pushNamed(context, '/addEntry');
          },
        )],
      ),
      body: FutureBuilder(
        future: getData("https://my-json-server.typicode.com/21sudhanshu/jsonFlutter/db"),
        builder: (context, snapshot){
          // print(snapshot.data.toString());
          return (snapshot.data != null)
              ? tableViewWidget(snapshot.data)
              : Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }

    String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }
}