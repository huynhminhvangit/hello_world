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

  Transaction _transaction =
      Transaction(content: '', amount: 0.0, createdAt: DateTime.now());

  List<Transaction> _transactions = <Transaction>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: _globalKey,
      title: 'Hello World App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("BoBon"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: this._save,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add transaction',
          child: Icon(Icons.add),
          onPressed: this._save,
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
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  TransactionList(transactions: _transactions)
                ],
              ),
            )),
      ),
    );
  }

  void _save() {
    final result = this._addTransaction();
    if (!result) {
      this._showMessage('Input invalid');
      return;
    }
    this._showMessage('Saved successfully', isUndo: true);
  }

  bool _addTransaction() {
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0.0 ||
        _transaction.amount.isNaN) return false;

    setState(() {
      _transaction.createdAt = DateTime.now();
      _transactions.add(_transaction);
      _transaction =
          Transaction(content: '', amount: 0.0, createdAt: DateTime.now());
      _contentEditingController.text = '';
      _amountEditingController.text = '';
    });
    return true;
  }

  void _showMessage(String message, {bool isUndo: false}) {
    final snackbar = SnackBar(
      content: Text(message),
      action: isUndo
          ? SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            )
          : null,
    );
    _globalKey.currentState!.showSnackBar(snackbar);
  }
}
