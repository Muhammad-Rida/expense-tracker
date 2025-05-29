import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/screens/expense_details.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: const Color.fromARGB(108, 155, 39, 176),
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => ExpenseDetails(
                        expense: expense,
                      )));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(expense.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\$${expense.amount.toStringAsFixed(2)}"),
                  //Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcon[expense.category]),
                      SizedBox(width: 8),
                      Text(expense.formattedDate)
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
