import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:example/pages/json_table.dart';
import 'package:example/pages/json_table_column.dart';

class CustomColumnTable extends StatefulWidget {
  @override
  _CustomColumnTableState createState() => _CustomColumnTableState();
}

class _CustomColumnTableState extends State<CustomColumnTable> {
  static var object = [  
      {  
         "id":"asdf      ",
         "assemblyType":"aaaa",
         "assemblySubtype":"aaaa",
         "attributeCode":null,
         "attributeDesc":null,
         "srlNo":null,
         "srlNoDisp":null,
         "department":null,
         "isActive":null,
         "domainId":"bbbb",
         "createdBy":null,
         "createdOn":null,
         "updatedBy":null,
         "updatedOn":null
      },
      {  
         "id":"WYUMY62   ",
         "assemblyType":"aaaa",
         "assemblySubtype":"aaaa",
         "attributeCode":null,
         "attributeDesc":null,
         "srlNo":null,
         "srlNoDisp":null,
         "department":null,
         "isActive":null,
         "domainId":"bbbb",
         "createdBy":null,
         "createdOn":null,
         "updatedBy":null,
         "updatedOn":null
      }
   ];
  
  final String jsonSample = jsonEncode(object);
  // final String jsonSample =
  //     '[{"name":"Ram","email":"ram@gmail.com","age":23,"DOB":"1990-12-01"},'
  //     '{"name":"Shyam","email":"shyam23@gmail.com","age":18,"DOB":"1995-07-01"},'
  //     '{"name":"John","email":"john@gmail.com","age":10,"DOB":"2000-02-24"},'
  //     '{"name":"Ram","age":12,"DOB":"2000-02-01"}]';
  bool toggle = true;
  List<JsonTableColumn> columns;

  @override
  void initState() {
    super.initState();
    columns = [
      JsonTableColumn("id", label: "ID"),
      JsonTableColumn("assemblyType", label: "Assembly Type"),
      JsonTableColumn("createdBy", label: "Created By"),
      JsonTableColumn("createdOn", label: "Created On", valueBuilder: formatDOB),
      JsonTableColumn("updatedBy", label: "Updated By"),
      JsonTableColumn("updatedOn", label: "Updated On", valueBuilder: formatDOB),
      JsonTableColumn("isActive", label: "Status", defaultValue: "NA"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var json = jsonDecode(jsonSample);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            JsonTable(json, columns: columns, showColumnToggle: false),
            SizedBox(
              height: 16.0,
            ),
            Text(
              getPrettyJSONString(jsonSample),
              style: TextStyle(fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }

  String getPrettyJSONString(jsonObject) {
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String jsonString = encoder.convert(json.decode(jsonObject));
    return jsonString;
  }

  String formatDOB(value) {
    var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
    return DateFormat("d MMM yyyy").format(dateTime);
  }
}