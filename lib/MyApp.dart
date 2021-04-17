import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  String name;
  int age;

  MyApp({required this.name, required this.age});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String _value = '';

  final textEditingController = TextEditingController();

  @override
  void initState() {
    print("run initState()");
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    print("run build()");
    return MaterialApp(
      title: 'Hello World App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("BoBon"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  _value,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: textEditingController,
                  onChanged: (text) => this.setState(() {
                    _value = text;
                  }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(10),
                      ),
                    ),
                    labelText: 'Enter your name',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // When I know "the app is in background/foreground mode"?
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print("App is in Background mode");
    } else {
      print("App is in Foreground mode");
    }
  }

  @override
  void dispose() {
    print("run dispose()");
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
