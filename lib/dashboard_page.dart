import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_keeper_helper/model/transaction_model.dart';
import 'package:shop_keeper_helper/provider/transaction_provider.dart';

import 'add_transaction_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildText(
                context,
                'Total Income',
                (transactions) => Provider.of<TransactionProvider>(context)
                    .calculateTotalIncome(transactions)),
            _buildText(
                context,
                'Total Expense',
                (transactions) => Provider.of<TransactionProvider>(context)
                    .calculateTotalExpense(transactions)),
            _buildText(
                context,
                'To Be Received',
                (transactions) => Provider.of<TransactionProvider>(context)
                    .calculateToBeReceived(transactions)),
            _buildText(
                context,
                'To Be Paid',
                (transactions) => Provider.of<TransactionProvider>(context)
                    .calculateToBePaid(transactions)),
            SizedBox(height: 20),
            Text('List of Transactions:'),
            Expanded(
              child: _buildTransactionList(context),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTransactionPage(),
                  ),
                ).then((_) {
                  // This function will be called when returning from AddTransactionPage
                  Provider.of<TransactionProvider>(context, listen: false)
                      .loadTransactions();
                });
              },
              child: Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context, String label,
      double Function(List<TransactionModel>) valueFunction) {
    return FutureBuilder<List<TransactionModel>>(
      future: Provider.of<TransactionProvider>(context).transactions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          double value = valueFunction(snapshot.data!);
          return Text('$label: $value');
        }
      },
    );
  }

  Widget _buildTransactionList(BuildContext context) {
    return FutureBuilder<List<TransactionModel>>(
      future: Provider.of<TransactionProvider>(context).transactions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<TransactionModel> transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              var transaction = transactions[index];
              return ListTile(
                title: Text(transaction.service),
                subtitle: Text('Paid: ${transaction.totalPaidAmount}'),
              );
            },
          );
        }
      },
    );
  }
}
