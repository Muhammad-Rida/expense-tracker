import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';

class ExpensesApp extends StatefulWidget {
  // registeredExpensesList is not anymore a private fixed list, it is now loaded from the database and passed to ExpenseApp from main.dart
  const ExpensesApp({
    super.key,
    required this.registeredExpensesList,
    required this.onDeleteExpense,
  });

  final List<Expense> registeredExpensesList;
  final void Function(Expense) onDeleteExpense;

  @override
  State<ExpensesApp> createState() {
    return _ExpensesAppState();
  }
}

class _ExpensesAppState extends State<ExpensesApp> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          'No expenses found! Add some, or select a different filter',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
    if (widget.registeredExpensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: widget.registeredExpensesList,
        onDeleteExpense: widget.onDeleteExpense,
      );
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
