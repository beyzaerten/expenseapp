import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/pages/expense_list.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String _title = "Expense App";
  final List<Expense> expenses = [
    Expense(
        name: "Schnitzel",
        price: 100,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        name: 'Flutter Udemy Course',
        price: 200,
        date: DateTime.now(),
        category: Category.education),
    Expense(
        name: 'Balkan Tour',
        price: 12200,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });
  }

  // bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title, style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (ctx) => NewExpense(
                          onAdd: (expense) => addExpense(expense),
                        ));
              },
              icon: const Icon(Icons.add),
              iconSize: 20,
              color: Colors.white),
        ],
      ),
      body: ExpenseList(
        expenses,
        removeExpense,
      ),
    );
  }
}
