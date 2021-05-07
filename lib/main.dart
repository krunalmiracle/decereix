import 'dart:typed_data';

import 'package:decereix/Helpers/cat10Helper.dart';
import 'package:decereix/Helpers/helpDecode.dart';
import 'package:decereix/Provider/cat_provider.dart';
import 'package:decereix/Screens/cat10_screen.dart';
import 'package:decereix/Screens/cat21_screen.dart';
import 'package:decereix/Screens/catall_screen.dart';
import 'package:decereix/Screens/load_file.dart';
import 'package:decereix/Screens/map_screen.dart';
import 'package:decereix/models/cat21.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'Helpers/cat21Helper.dart';
import 'models/cat10.dart';

void main() {
  /// [runApp] which is a Dart funciton to initalize the [Widget Tree]
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that [Other Widgets] including [MyApp]
    /// can use, while mocking the providers. Which means change the state inside it.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    CatProvider _catProvider = Provider.of<CatProvider>(context, listen: true);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'DECEREIX'),
      builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currPage = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _currPage = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: CupertinoButton.filled(
                          child: Text('Load File'),
                          onPressed: () {
                            setState(() {
                              this._currPage = 0;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: CupertinoButton.filled(
                          child: Text('Cat 10'),
                          onPressed: () {
                            setState(() {
                              this._currPage = 1;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: CupertinoButton.filled(
                          child: Text('Cat 21'),
                          onPressed: () {
                            setState(() {
                              this._currPage = 2;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: CupertinoButton.filled(
                          child: Text('Cat All'),
                          onPressed: () {
                            setState(() {
                              this._currPage = 3;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        child: CupertinoButton.filled(
                          child: Text('Map'),
                          onPressed: () {
                            setState(() {
                              this._currPage = 4;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (_currPage == 0) ...[
              Expanded(
                flex: 8,
                child: Center(child: load_file(
                  onDataLoaded: (bool status) {
                    // Something...
                  },
                )),
              ),
            ] else if (_currPage == 1) ...[
              Expanded(
                flex: 8,
                child: Center(child: Cat10Table()),
              ),
            ] else if (_currPage == 2) ...[
              Expanded(
                flex: 8,
                child: Center(child: Cat21Table()),
              ),
            ] else if (_currPage == 3) ...[
              Expanded(
                flex: 8,
                child: Center(child: CatAllTable()),
              ),
            ] else if (_currPage == 4) ...[
              Expanded(
                flex: 8,
                child: Center(child: MapScreen()),
              ),
            ],
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
