import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenseapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final void Function(Expense expense) onAdd;

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amoutController = TextEditingController();
  DateTime now = DateTime.now();
  DateTime? _selectedDate;
  Category selectedCategory = Category.food;

  void _openDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate == null ? now : _selectedDate!,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              onPrimary: Colors.white,
              onSurface: Colors.black,
              primary: Color.fromARGB(255, 155, 78, 248),
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  fontFamily: 'Quicksand',
                ),
                foregroundColor: Colors.white,
                backgroundColor:
                    Color.fromARGB(255, 155, 78, 248), //Background color
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: Colors.transparent,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _addNewExpense() {
    final amount = double.tryParse(_amoutController.text);
    if (amount == null ||
        amount < 0 ||
        _nameController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: const Text('Validation Error'),
            content: const Text('Please fill all blank area'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tamam'),
              ),
            ],
          );
        }),
      );
    } else {
      Expense newExpense = Expense(
          name: _nameController.text,
          price: amount,
          date: _selectedDate!,
          category: selectedCategory);

      widget.onAdd(newExpense);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Expense Name',
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          TextField(
            controller: _amoutController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              prefixText: '₺',
            ),
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Date',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(_selectedDate == null
                      ? 'Tarih Seçiniz'
                      : DateFormat.yMd().format(_selectedDate!)),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: IconButton(
                    onPressed: () => _openDatePicker(),
                    icon: const Icon(Icons.calendar_month)),
              ),
            ],
          ),
          const Divider(
            height: 30,
            thickness: 1,
            color: Colors.grey,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text('Kategori Seçiniz'),
                ],
              ),
              const Spacer(),
              DropdownButton(
                value: selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                      value: category, child: Text(category.name.toString()));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) selectedCategory = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(120, 44),
                  foregroundColor: Color.fromARGB(255, 24, 25, 27),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Vazgeç'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 180, 78, 248),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(120, 44)),
                onPressed: () {
                  _addNewExpense();
                },
                child: const Text("Kaydet"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
