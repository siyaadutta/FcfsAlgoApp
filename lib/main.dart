import 'package:fcfs_sch_app/algo.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int curr_vid = 0;
  List<TextEditingController> controller_at = [];
  List<TextEditingController> controller_bt = [];

  List<Map<String, int>> _books = [
    {'id': 100, 'at': 0, 'bt': 20},
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('FCFS SCHEDULING ALGORITHM')),
        ),
        body: ListView(
          children: [_createDataTable(), _editData(), _go()],
        ),
      ),
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  Widget _go() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            var at=[];
            var bt=[];
            for (int i = 0; i < curr_vid; i++) at.add(controller_at[i].text);
            for (int i = 0; i < curr_vid; i++) bt.add(controller_bt[i].text);
            main_algo(curr_vid, bt, at);
          });
        },
        child: Text('GO'));
  }

  Widget _editData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _books.removeLast();
                  curr_vid--;
                });
              },
              child: Text('-'),
            ),
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _books.add({'id': curr_vid + 1, 'at': 10, 'bt': 20});
                  curr_vid++;
                  print(_books);
                });
              },
              child: Icon(Icons.add)),
        ))
      ],
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Process Id')),
      DataColumn(label: Text('Arrival Time')),
      DataColumn(label: Text('Burst Time')),
    ];
  }

  List<DataRow> _createRows() {
    int count = 0;
    controller_at.clear();
    controller_bt.clear();
    for (int i = 0; i < curr_vid; i++) controller_at.add(TextEditingController());
    for (int i = 0; i < curr_vid; i++) controller_bt.add(TextEditingController());
    var lst=[];
    return _books
        .map((book) => DataRow(cells: [
              DataCell(Text('#' + book['id'].toString())),
              DataCell(TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                 controller: controller_at[count],
                onSaved: (var value) {
                  // book['at'] = int.parse(controller_at[count].text);
                },
              )),
              DataCell(TextFormField(
                keyboardType: TextInputType.number,
                // controller: controller_bt[count],
                onSaved: (var value) {
                  // book['bt'] = int.parse(controller_bt[count].text);
                },
              )),
            ]))
        .toList();
  }
}
