import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      // card automatically adds a margin between it and the widgets arount it
      child: Padding(
        // card doesn't have a padding (spacing between borders of a parent widget and it's child) option for it's child so we need to do this
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize:
                      18), // access the titleLarge theme settings that was set up globally by accessing the context of the parent object to which these themes were being applied; and then set this theme of titleLarge to the current text widget; we also override the font size of the titleLarge theme;
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(), // can be used to tell flutter to create a widget that takes up all the available space between the two widgets it's placed between
                Row(
                  children: [
                    Icon(categoryIcons[expense
                        .category]), // Icon widget displays the icon passed to it (which is of type IconData); Icons.<icon_name> can be passed to it (since it returns an object of type IconData)
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense
                        .formattedDate), // calling a getter function does not require ()
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
