<<<<<<< HEAD
import 'dart:io';

import 'package:expense_tracker/db/expense_storage.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/tabs.dart';
import 'package:flutter/material.dart';
// install and import sqflite_common_ffi if you are running a windows application
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // a line required before any async code in main
  WidgetsFlutterBinding.ensureInitialized();
  // Change the database factory if you are running a windows application
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  // Load the expenses from the database
  List<Expense> expensesList = await loadExpenses();
  // pass the loaded expenses to MyApp, which will pass it to ExpensesApp
  runApp(MyApp(
    registeredExpenses: expensesList,
  ));
}

class MyApp extends StatelessWidget {
  final List<Expense> registeredExpenses;

  const MyApp({
    super.key,
    required this.registeredExpenses,
  });
=======
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
>>>>>>> ece43b9fe1590fd809cc1ac7b291e32cd25651ec

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      // Pass the registered expenses to ExpensesApp to be displyed in the ListView
      home: TabsScreen(registeredExpensesList: registeredExpenses),
=======
      home: Scaffold(
        appBar: AppBar(title: const Text('My Widget')),
        body: const Center(child: Text('Hello, World!')),
      ),
>>>>>>> ece43b9fe1590fd809cc1ac7b291e32cd25651ec
    );
  }
}
