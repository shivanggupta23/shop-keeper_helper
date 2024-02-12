import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dashboard_page.dart';
import 'add_transaction_page.dart';
import 'provider/transaction_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionProvider(),
      child: MaterialApp(
        title: 'Flutter Shopkeeper\'s Helper',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Choose the appropriate starting page here
        home: DashboardPage(),
        routes: {
          // '/': (context) => AddTransactionPage(), // This line might not be necessary
          '/add': (context) => AddTransactionPage(),
        },
      ),
    );
  }
}
