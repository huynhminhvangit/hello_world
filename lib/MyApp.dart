import 'package:flutter/material.dart';
import 'package:hello_world/TransactionList.dart';
import 'package:hello_world/transaction.dart';

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

  Transaction _transaction = Transaction(content: '', amount: 0.0);

  List<Transaction> _transactions = <Transaction>[];

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
            child: SingleChildScrollView(
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
                        _transaction.content = value;
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
                        _transaction.amount = double.tryParse(value) ?? 0;
                      });
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _transactions.add(_transaction);
                        _transaction = Transaction(content: '', amount: 0.0);
                        _contentEditingController.text = '';
                        _amountEditingController.text = '';
                      });

                      final snackbar = SnackBar(
                        content: Text('Saved successfully'),
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
                  TransactionList(transactions: _transactions)
                ],
              ),
            )),
      ),
    );
  }
}
