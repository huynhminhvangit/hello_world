import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: (index % 2 == 0) ? Colors.purpleAccent : Colors.pinkAccent,
            elevation: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 10)),
                    Text(
                      transactions[index].content.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      Intl()
                          .date('yyyy/MM/dd HH:mm:ss')
                          .format(transactions[index].createdAt),
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10)),
                  ],
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${transactions[index].amount.toString()}\$',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(Object context) {
    return _buildListView();
  }
}
