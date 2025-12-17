<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

const categoryIcon = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

// Create a map to convert every string to a Category enum
const categoryName = {
  'food': Category.food,
  'leisure': Category.leisure,
  'work': Category.work,
  'travel': Category.travel,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      // use the initializer list to set the id to a unique id,
      // or to the id retreived from the database
      // ?? checks if the parameter id is null or not
      id})
      : id = id ?? Uuid().v4();

  final String id;
=======
import 'package:uuid/uuid.dart';

class Expense {
  final String id = Uuid().v4();
>>>>>>> ece43b9fe1590fd809cc1ac7b291e32cd25651ec
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

<<<<<<< HEAD
  String get formattedDate {
    return DateFormat.yMd().format(date);
  }

// Create a getter to create a map for every expense object.
// This map is used to insert data into the database.
  Map<String, Object?> get expenseMap {
    return {
      'id': id,
      'amount': amount,
      'title': title,
      'category': category.name,
      'date': date.millisecondsSinceEpoch,
    };
  }
}

// A new class that sums up all the expenses in one category to display them in the chart
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // add an extra named constructor to filter out expenses that belong to a specific category
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (Expense e in expenses) {
      sum += e.amount;
    }
    return sum;
  }
}
=======
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}

enum Category { food, travel, entertainment, utilities, others }

final List<Expense> _registeredExpensesList = [
  Expense(
    amount: 5,
    date: DateTime.now(),
    title: 'Burger',
    category: Category.food,
  ),
];
>>>>>>> ece43b9fe1590fd809cc1ac7b291e32cd25651ec
