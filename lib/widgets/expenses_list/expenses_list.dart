import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) => ExpenseItem(
        // itemBuilder takes a function that takes in two arguments, context and index, and returns a Widget that should be displayed in the list view
        expense: expenses[index],
      ),
      itemCount: expenses
          .length, // index runs from zero to itemCount - 1, and the item builder creates the widgets it has been given in increasing order of index (when that widget is being accessed or about to be accessed)
    );
  }
}

/* 

if you have lists of unclear length that could potentially get quite long, column is not ideal
because with column, all the widgets that are added to column will be created behind the scenes by
flutter whenever the widget that outputs the column becomes active. this costs a lot of performance.

in such situations, the ListView widget should be used instead of column.

ListView (children: [],)

this still behaves like column in that it creates everything when it's parent becomes active
with the added benefit that it's children become scrollable automatically.

ListView.builder (itemBuilder: ,)

this tells flutter to still create a scrollable list of widgets but only build the individual items in the
list of widgets when they are visible or about to become visible on the screen.
 
*/