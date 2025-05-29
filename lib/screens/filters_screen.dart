import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Category, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _workFilterSet = true;
  var _leisureFilterSet = true;
  var _foodFilterSet = true;
  var _travelFilterSet = true;

  @override
  void initState() {
    _workFilterSet = widget.currentFilters[Category.work]!;
    _travelFilterSet = widget.currentFilters[Category.travel]!;
    _foodFilterSet = widget.currentFilters[Category.food]!;
    _leisureFilterSet = widget.currentFilters[Category.leisure]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        leading: BackButton(
          onPressed: () {
            var result = {
              Category.food: _foodFilterSet,
              Category.leisure: _leisureFilterSet,
              Category.work: _workFilterSet,
              Category.travel: _travelFilterSet,
            };
            Navigator.pop(context, result);
          },
        ),
      ),
      body: Column(children: [
        SwitchListTile(
          value: _workFilterSet,
          onChanged: (isChecked) {
            setState(() {
              _workFilterSet = isChecked;
            });
          },
          title: Text('Work'),
          subtitle: Text('Only include work expenses.'),
          contentPadding: EdgeInsets.only(
            left: 30,
            right: 20,
          ),
        ),
        SwitchListTile(
          value: _leisureFilterSet,
          onChanged: (isChecked) {
            setState(() {
              _leisureFilterSet = isChecked;
            });
          },
          title: Text('Leisure'),
          subtitle: Text('Only include leisure expenses.'),
          contentPadding: EdgeInsets.only(
            left: 30,
            right: 20,
          ),
        ),
        SwitchListTile(
          value: _foodFilterSet,
          onChanged: (isChecked) {
            setState(() {
              _foodFilterSet = isChecked;
            });
          },
          title: Text('Food'),
          subtitle: Text('Only include food expenses.'),
          contentPadding: EdgeInsets.only(
            left: 30,
            right: 20,
          ),
        ),
        SwitchListTile(
          value: _travelFilterSet,
          onChanged: (isChecked) {
            setState(() {
              _travelFilterSet = isChecked;
            });
          },
          title: Text('Travel'),
          subtitle: Text('Only include travel expenses.'),
          contentPadding: EdgeInsets.only(
            left: 30,
            right: 20,
          ),
        )
      ]),
    );
  }
}
