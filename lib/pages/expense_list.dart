import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList(
    this.expenses,
    this.onRemove, {
    Key? key,
  }) : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemove;

  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<Expense> removedExpenses = [];

  void undoRemove(int index) {
    Expense removedExpense = removedExpenses.removeLast();
    setState(() {
      widget.expenses.insert(index, removedExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 150, child: Text('Grafik ')),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.expenses.length,
            itemBuilder: (context, index) {
              return Dismissible(
                movementDuration: const Duration(seconds: 1),
                key: ValueKey(widget.expenses[index]),
                child: ExpenseItem(widget.expenses[index]),
                onDismissed: (direction) {
                  Expense removedExpense = widget.expenses[index];
                  widget.onRemove(removedExpense);
                  setState(() {
                    removedExpenses.add(removedExpense);
                  });

                  final snackBar = SnackBar(
                    content: const Text('Expense removed'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        setState(() {
                          undoRemove(index);
                        });
                      },
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              );
            },
          ),
        )
      ],
    );
  }
}
