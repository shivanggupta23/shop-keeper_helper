import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_keeper_helper/model/transaction_model.dart';
import 'package:shop_keeper_helper/provider/transaction_provider.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key}) : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController totalPaidController = TextEditingController();
  final TextEditingController partiallyPaidController = TextEditingController();
  final TextEditingController photoController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    serviceController.dispose();
    totalPaidController.dispose();
    partiallyPaidController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var transactionProvider = Provider.of<TransactionProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Add Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Details:'),
              TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name')),
              TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(labelText: 'Mobile Number')),
              SizedBox(height: 20),
              Text('Transaction Details:'),
              TextFormField(
                  controller: serviceController,
                  decoration: InputDecoration(labelText: 'Service')),
              TextFormField(
                  controller: totalPaidController,
                  decoration: InputDecoration(labelText: 'Total Paid Amount')),
              TextFormField(
                  controller: partiallyPaidController,
                  decoration:
                      InputDecoration(labelText: 'Partially Paid Amount')),
              TextFormField(
                  controller: photoController,
                  decoration: InputDecoration(labelText: 'Photo (optional)')),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    var transaction = TransactionModel(
                      name: nameController.text,
                      mobileNumber: mobileController.text,
                      service: serviceController.text,
                      totalPaidAmount: double.parse(totalPaidController.text),
                      partiallyPaidAmount:
                          double.parse(partiallyPaidController.text),
                      photo: photoController.text,
                    );

                    await transactionProvider.addTransaction(transaction);
                    Navigator.pop(context);
                  } catch (e) {
                    // Handle parsing errors
                    print('Error: $e');
                  }
                },
                child: Text('Save Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
