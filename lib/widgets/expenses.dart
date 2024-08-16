import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          const NewExpense(), // builder wants a function that takes a BuildContext argument (given to it automatically by flutter) which is the context of the showModalBottomSheet function and returns a widget to be displayed in the modal sheet
    );
  }

  // there is a globally available BuildContext object called context available since we're in a class that extends State.
  // when you're in a class that extends State, flutter automatically adds a BuildContext property called context to your class behind the scenes
  // so to say, it's provided by the State parent class; this context object belong to the widget using the State class
  // and this context property that is made available by flutter can be used for the context argument in the
  // showModalBottomSheet () function

  // Any BuildContext object (usually called context) is a kind of metadata collection; an object full of metadata
  // managed by flutter that belongs to a specific widget; so every widget has it's own BuildContext object; and that contains
  // metedata information about that widget and about that widget's position in the overall widget tree.

  @override
  Widget build(BuildContext context) {
    // this context argument is passed automatically by flutter and is not the one provided by State
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ), // to diplay a button that just has an icon
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            // without the expanded widget, since we have a column (technically ListView) inside of another column, flutter wouldn't know how to restrict the inner column and how to size it
            child: ExpensesList(
              expenses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
