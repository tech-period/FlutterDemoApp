import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class CounterPage extends StatefulWidget {
  CounterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;
  CountEntry _dbCounter = new CountEntry(DateTime.now(), 0);
  final _mainReference = FirebaseDatabase.instance.reference().child("count");

  void _incrementCounter() {
    setState(() {
      _counter++;
      _mainReference.push().set(CountEntry(DateTime.now(), _counter).toJson());

    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  initState() {
    super.initState();
    _mainReference.onChildAdded.listen(_getCount);
  }

  _getCount(Event e){
    setState(() {
      _dbCounter = new CountEntry.fromSnapShot(e.snapshot);
    });
  }
  String _getDate(DateTime d){
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(d);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              'Datetime:' + _dbCounter.count.toString(), // + _getDate(_dbCounter!.dateTime),
            ),
            TextButton(onPressed: _resetCounter, child: Text("リセット")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CountEntry {
  String? key;
  DateTime dateTime;
  int count;

  CountEntry(this.dateTime, this.count);

  CountEntry.fromSnapShot(DataSnapshot snapshot):
        key = snapshot.key,
        dateTime = new DateTime.fromMillisecondsSinceEpoch(snapshot.value["date"]),
        count = snapshot.value["count"];

  toJson() {
    return {
      "date": dateTime.millisecondsSinceEpoch,
      "count": count,
    };
  }
}
