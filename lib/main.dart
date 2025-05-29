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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Pass the registered expenses to ExpensesApp to be displyed in the ListView
      home: TabsScreen(registeredExpensesList: registeredExpenses),
    );
  }
}
