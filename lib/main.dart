import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'counter.dart';
import 'paginatedDataTable.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var listItem = ['Counter', 'PaginatedDataTable'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: Drawer(child: Center(child: Text("Drawer"))),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black38),
                ),
              ),
              child: ListTile(
                leading: const Icon(Icons.queue_play_next),
                title: Text('$index'),
                subtitle: Text(listItem[index].toString()),
                onTap: () {
                  switch (listItem[index]) {
                    case 'Counter':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CounterPage(title: "CounterPage"),
                          ));
                      break;
                    case 'PaginatedDataTable':
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaginatedDataTablePage(
                                title: "PaginatedTablePage"),
                          ));
                      break;
                    default:
                      break;
                  }
                },
              ));
        },
        itemCount: listItem.length,
      ),
    );
  }
}
