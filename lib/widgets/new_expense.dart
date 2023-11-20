import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key, required this.addExpenseList}) : super(key: key);

  final Function(Expense) addExpenseList;
  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.education;

  void _openDatePicker() async {
    DateTime now = DateTime.now();
    DateTime oneyearsago = DateTime(now.year - 10, now.month, now.day);

    // showDatePicker(
    //         context: context,
    //         initialDate: now,
    //         firstDate: oneyearsago,
    //         lastDate: now)
    //     .then((value) {
    //   print(value);

    DateTime? selectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate == null ? now : _selectedDate!,
        firstDate: oneyearsago,
        lastDate: now);

    setState(() {
      _selectedDate = selectedDate;
    });
    print("26. satır çalıştı");
  }

  //   //await showDatePicker(
  //      // context: context,
  //       initialDate: now,
  //       firstDate: oneyearsago,
  //       lastDate: now);

  //   print("26. satır çalıştı");
  // }

  void _addNewExpense() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null ||
        amount < 0 ||
        _nameController.text.isEmpty ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("validation error"),
              content: const Text("please fill all blank areas"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("okay "))
              ],
            );
          });
    } else {
      // valid bir değer
      // listeye ekleme yapılması gereken nokta..

      // Listeye eklenecek veriler kullanıcıdan alındı
      Expense newExpense = Expense(
          name: _nameController.text,
          price: amount,
          date: _selectedDate!,
          category: _selectedCategory);

      widget.addExpenseList(newExpense);

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Expense Name")),
          ),
          Row(
            children: newMethod,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values.map((category) {
                    return DropdownMenuItem(
                        value: category, child: Text(category.name.toString()));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) _selectedCategory = value;
                    });
                  })
            ],
          ),
          const Divider(
            height: 50,
            thickness: 1,
            color: Color.fromARGB(255, 199, 120, 120),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 112, 248),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(110, 35),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("vazgeç")),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 112, 248),
                    foregroundColor: Colors.white,
                    fixedSize: const Size(110, 35),
                  ),
                  onPressed: () {
                    _addNewExpense();
                  },
                  child: const Text("Kaydet")),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> get newMethod {
    return [
      Expanded(
        child: TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration:
              const InputDecoration(label: Text("Amount"), prefixText: "₺"),
        ),
      ),
      const SizedBox(
        width: 30,
      ),
      Expanded(
        child: Row(
          children: [
            IconButton(
              onPressed: () => _openDatePicker(),
              icon: const Icon(Icons.calendar_month),
            ),
            Text(_selectedDate == null
                ? "Tarih Seçiniz"
                : DateFormat.yMd().format(_selectedDate!)),
          ],
        ),
      ),
    ];
  }
}
