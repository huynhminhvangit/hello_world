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
  final _contentEditingController = new TextEditingController();
  final _amountEditingController = new TextEditingController();

  Transaction _transaction =
      Transaction(content: '', amount: 0.0, createdAt: DateTime.now());

  List<Transaction> _transactions = <Transaction>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction management"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add transaction',
        child: Icon(Icons.add),
        onPressed: this._onButtonShowModalSheet,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Container(
          child: TransactionList(transactions: _transactions),
        ),
      ),
    );
  }

  void _save() {
    final result = this._addTransaction();
    if (!result) {
      return;
    }
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

  void _onButtonShowModalSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Column(
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
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            this._save();
                            Navigator.pop(context);
                          },
                          child: Text('Save'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            backgroundColor: Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
