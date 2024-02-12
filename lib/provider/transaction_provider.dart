import 'package:flutter/material.dart';
import 'package:shop_keeper_helper/transaction_database.dart';
import 'package:shop_keeper_helper/model/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];

  Future<List<TransactionModel>> get transactions async => _transactions;

  Future<void> addTransaction(TransactionModel transaction) async {
    final db = await TransactionDatabase.instance.database;
    await db.insert('transactions', transaction.toMap());

    _transactions.add(transaction);
    notifyListeners();
  }

  Future<void> loadTransactions() async {
    final db = await TransactionDatabase.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    _transactions = List.generate(maps.length, (index) {
      return TransactionModel.fromMap(maps[index]);
    });

    notifyListeners();
  }

  double calculateTotalIncome(List<TransactionModel> transactions) {
    // Placeholder logic: Sum up total paid amounts from transactions
    return transactions.fold(
        0.0, (sum, transaction) => sum + transaction.totalPaidAmount);
  }

  double calculateTotalExpense(List<TransactionModel> transactions) {
    // Placeholder logic: Sum up partially paid amounts from transactions
    return transactions.fold(
        0.0, (sum, transaction) => sum + transaction.partiallyPaidAmount);
  }

  double calculateToBeReceived(List<TransactionModel> transactions) {
    // Placeholder logic: Sum up amounts to be received based on your business rules
    return transactions.fold(
        0.0,
        (sum, transaction) =>
            sum +
            (transaction.totalPaidAmount - transaction.partiallyPaidAmount));
  }

  double calculateToBePaid(List<TransactionModel> transactions) {
    // Placeholder logic: Sum up amounts to be paid based on your business rules
    return transactions.fold(
        0.0, (sum, transaction) => sum + (transaction.partiallyPaidAmount));
  }
}
