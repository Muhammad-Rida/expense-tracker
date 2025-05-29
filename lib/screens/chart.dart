import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({
    super.key,
    required this.expensesList,
  });

  final List<Expense> expensesList;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(
        expensesList,
        Category.food,
      ),
      ExpenseBucket.forCategory(
        expensesList,
        Category.work,
      ),
      ExpenseBucket.forCategory(
        expensesList,
        Category.leisure,
      ),
      ExpenseBucket.forCategory(
        expensesList,
        Category.travel,
      ),
    ];
  }

  double get maxTotalExpense {
    double max = 0;
    for (ExpenseBucket bucket in buckets) {
      if (bucket.totalExpenses > max) {
        max = bucket.totalExpenses;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(29, 124, 77, 255),
            const Color.fromARGB(115, 124, 77, 255)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (ExpenseBucket bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          Row(
            children: Category.values
                .map(
                  (category) => Expanded(
                    child: Icon(
                      categoryIcon[category],
                      color: const Color.fromARGB(190, 104, 58, 183),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
