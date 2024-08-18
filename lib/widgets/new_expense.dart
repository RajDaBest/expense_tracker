import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense newExpense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  _NewExpenseState();

  /* String _enteredTitle = '';

  void _saveTitleInput(String inputValue) {
    _enteredTitle = inputValue;
  } */

  final _titleController =
      TextEditingController(); // text editing controller is a class that is optimized for handling user inputs

  final _amountController = TextEditingController();

  Category _selectedCategory = Category.leisure; // default category

  DateTime? _selectedDate;

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParce tries to convert the string given to it into a double; returns the double if successful; returns null if the string is not a valid number
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    // trim can be called on a string to remove the leading and following white spaces in the string; returns a string itself

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context, // context of the state class
        builder: (ctx) => AlertDialog(
          // context ctx of the widget being passed to the builder; this context will be passed automatically by flutter
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    Expense newExpense = Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory);

    widget.onAddExpense(newExpense);

    Navigator.pop(context);
  }

  void _presentDatePicker() async {
    final currentDate = DateTime.now();
    final firstDate = DateTime(
        currentDate.year - 1,
        currentDate.month,
        currentDate
            .day); // the year month and day of a DateTime object can be accessed and set like this
    final pickedDate = await showDatePicker(
      // await makes flutter halt the execution of this function the future returns it's result, which is then stored in the variable pickedDate; await can only be used in presence of async
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    ); // takes in the context of the widget it's being displayed in

    setState(() {
      _selectedDate = pickedDate;
    });

    // showDatePicker returns a value of type DateTime? wrapped in Future, i.e, returns a value of type Future<DateTime?>, i.e, a Future<DateTime?> object
    // A future object is simply an object from the future; it's an object that wraps a value of some data type which you don't have yet but which you will have in the future

    /* var futureObject = showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: currentDate,
    );

    futureObject.then((value) {});
 */
    // each future object has a then () method, which takes a function having a parameter of the type of the future object as it's argument, and executes this function when the future object gets the value it's waiting for (called the result of the future) by passing this value as an argument to the function passed to it
  }

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
      padding: const EdgeInsets.fromLTRB(16, 48, 16,
          16), // 48 from the top to avoid obscuring the contents of the modal overlay (since it's full screen) by device camera and stuff
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
                    Text(
                      _selectedDate == null
                          ? 'No Date Selected'
                          : formatter.format(_selectedDate!),
                    ), // the exclamatory sign in front of a variable that can be null forces dart to assume that it can't be null
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // Category.values returns a List of type Category that has all the values of the enum Category in the order in which they were specified in the enum definition
              // DropdownMenuItem (value: <value>, child: <Widget>) returns a DropdownMenuItem widget of type DropdownMenuItem <type_of_<value>> and associates the value <value> with that widget (the value can be of any type, its a dynamic type)
              // items argument wants a List of DropdownMenuItem <dynamic> values that will be placed in the dropdown menu in the order they appear in the list. the type <dynamic> will be the common type of the dropdownmenuitem object in the list
              // onChanged wants a function as it's argument (this function should be void Function (<type_of_<value>?>)?) and calls this function once a DropdownMenuItem is selected in the menu and passes value associated to that DropdownMenuItem widget that was selected, to that function
              // calling the .name getter on any enum value returns that enum value as a string
              DropdownButton(
                value:
                    _selectedCategory, // currently selected drop down menu item will be set to show _selectedCategory, which is indeed the currently selected drop down menu item; without this, no item will be shown on the button even if it was selected
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
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
                  _submitExpenseData();
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