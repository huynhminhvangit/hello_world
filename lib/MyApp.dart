import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  final _contentEditingController = new TextEditingController();
  final _amountEditingController = new TextEditingController();

  String _content = '';
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _globalKey,
      title: 'Hello World App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("BoBon"),
        ),
        body: SafeArea(
          minimum: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _contentEditingController,
                decoration: InputDecoration(
                  labelText: 'Content',
                ),
                onChanged: (value) {
                  this.setState(() {
                    _content = value;
                  });
                },
              ),
              TextField(
                controller: _amountEditingController,
                decoration: InputDecoration(
                  labelText: 'Amount(money)',
                ),
                onChanged: (value) {
                  this.setState(() {
                    _amount = double.tryParse(value) ?? 0;
                  });
                },
              ),
              TextButton(
                onPressed: () {
                  final snackbar = SnackBar(
                    content:
                        Text('Content = $_content, money\'s amount = $_amount'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                      },
                    ),
                  );
                  _globalKey.currentState!.showSnackBar(snackbar);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
