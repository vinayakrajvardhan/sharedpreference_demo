import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String name = '';
  @override
  void initState() {
    _readCounter();
    super.initState();
  }

  _incrementCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _counter++;
      preferences.setInt("counterKey", _counter);
      preferences.setString("stringValue", "want to join ");
    });
  }

  _removeCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("counterKey");
      preferences.remove("stringValue");
      preferences.clear();
    });
    _readCounter();
  }

  _readCounter() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    setState(() {
      _counter = preference.getInt("counterKey") ?? 0;
      name = preference.getString("stringValue") ?? 'hello back again';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${name}',
              style: TextStyle(fontSize: 60, color: Colors.black),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _removeCounter,
            tooltip: 'Delete',
            child: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
