import 'package:flutter/material.dart';
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
            color: (index % 2 == 0) ? Colors.blue : Colors.green,
            elevation: 10,
            child: ListTile(
              leading: const Icon(Icons.access_alarm),
              title: Text(
                transactions[index].content,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                transactions[index].amount.toString(),
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              onTap: () {},
            ),
          );
        });
  }

  @override
  Widget build(Object context) {
    return Container(
      height: 500,
      child: _buildListView(),
    );
  }
}
