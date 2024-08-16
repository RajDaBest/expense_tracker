import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  /* String _enteredTitle = '';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  } */

  final _titleController =
      TextEditingController(); // text editing controller is a class that is optimized for handling user inputs

  final _amountController = TextEditingController();

  // when you create a text editing controller, you also have to tell flutter to delete that controller when the widget it is created in is
  // not needed anymore (for ex, when modal overlay is closed); otherwise, it will live on in memory even when the widget is not visible anymore consuming memory
  // to avoid this do this:

  @override
  void dispose() {
    // called just before a widget and it's state are going to be destroyed
    _titleController.dispose(); // disposes the controller
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller:
                _titleController, // specify the input controller to the field; now the input of this text field will be exclusively handled by the specified controller; each text field must have a unique TextEditingContoller for handling it's input if the input is being handled in this way
            // inputs given to the fields will now be stored and managed by the specified controller
            // onChanged:
            //    _saveTitleInput, // the function passed to onChanged is executed everytime the text inside the field changes and this function is passed an argument of type String automatically by flutter which has the new text that the old text in the field was changed to
            // allows user to enter some text
            maxLength:
                50, // maximum permissible length of the text being entered
            keyboardType: TextInputType
                .text, // controls which virtual keyboard should be opened when the user taps on the input field; standard text keyboard is the default so this line isnt technically required
            decoration: const InputDecoration(
              // to add a label to the Text input field, we do this
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText:
                        '\$ ', // just shows this string in front of the actual thing being entered
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                // Row inside of a row would cause problems; use expanded to resolve
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .end, // aligns the children of the row to the end of the row horizontally
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // vertically centre the children of the row
                  children: [
                    const Text('Selected Date'),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context); // this function wants the current context as it's argument; simply removes the overlay from the screen
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  print(_titleController
                      .text); // text method of a TextEditingController object returns the last saved String in the object
                  print(_amountController.text);
                },
                child: const Text(
                  'Save Expense',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/* 

By default, a row widget takes as much space as is required to fit all of it's children. When another row is placed inside a row
an overflow error can occur since both of them try to take as much space as possible for their children.

This can be solved by wrapping the inner row with Expanded. Expanded makes the inner row take up only the space available to it with
respect to the other children of the outer row.

Same problem is with a TextField inside of a row. TextField tries to take up as much horizontal space as possible which can lead to overflow errors.
Wrapping it with expanded helps again since expanded restricts it to use only the space made available to it. 

*/