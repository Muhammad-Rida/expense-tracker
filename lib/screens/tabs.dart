import 'package:expense_tracker/db/expense_storage.dart';
import 'package:expense_tracker/expenses_app.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/chart.dart';
import 'package:expense_tracker/screens/filters_screen.dart';
import 'package:expense_tracker/widgets/main_drawer.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.registeredExpensesList});

  final List<Expense> registeredExpensesList;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  Map<Category, bool> _selectedFilters = {
    Category.food: true,
    Category.leisure: true,
    Category.work: true,
    Category.travel: true,
  };

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) async {
    setState(() {
      // now, when you want to use registeredExpensesList in the State class, you use the widget varaible
      widget.registeredExpensesList.add(expense);
    });
    // insert the new expense to the database
    insertExpense(expense);
  }

  void _openFiltersScreen() async {
    Navigator.pop(context);
    final result = await Navigator.push<Map<Category, bool>>(
      context,
      MaterialPageRoute(
        builder: (ctx) => FiltersScreen(
          currentFilters: _selectedFilters,
        ),
      ),
    );
    setState(() {
      _selectedFilters = result ??
          {
            Category.food: true,
            Category.leisure: true,
            Category.work: true,
            Category.travel: true,
          };
    });
  }

  void _deleteExpense(Expense expense) {
    int index = widget.registeredExpensesList.indexOf(expense);
    setState(() {
      widget.registeredExpensesList.remove(expense);
      // delete the expense from the database
      deleteExpense(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              widget.registeredExpensesList.insert(index, expense);
              // insret the expense again if the user revert the action
              insertExpense(expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var filteredExpenses = widget.registeredExpensesList.where((expense) {
      if (_selectedFilters[Category.food]!) {
        if (expense.category == Category.food) {
          return true;
        }
      }
      if (_selectedFilters[Category.work]!) {
        if (expense.category == Category.work) {
          return true;
        }
      }
      if (_selectedFilters[Category.leisure]!) {
        if (expense.category == Category.leisure) {
          return true;
        }
      }
      if (_selectedFilters[Category.travel]!) {
        if (expense.category == Category.travel) {
          return true;
        }
      }
      return false;
    }).toList();
    Widget activePage = ExpensesApp(
      registeredExpensesList: filteredExpenses,
      onDeleteExpense: _deleteExpense,
    );
    var activeAppBar = AppBar(
      title: Text('Expenses List'),
      actions: [
        IconButton(
          onPressed: _openAddExpenseOverlay,
          icon: Icon(Icons.add),
        ),
      ],
    );
    if (_selectedIndex == 1) {
      activePage = ChartScreen(
        expensesList: widget.registeredExpensesList,
      );
      activeAppBar = AppBar(
        title: Text('Expenses Chart'),
      );
    }
    return Scaffold(
      appBar: activeAppBar,
      body: activePage,
      drawer: MainDrawer(
        onFiltersTap: _openFiltersScreen,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.payments),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Chart',
          )
        ],
        onTap: _selectPage,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
