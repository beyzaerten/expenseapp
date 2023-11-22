import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem(
    this.expense, {
    Key? key,
    this.newExpense,
  }) : super(key: key);

  final Expense expense;

  final newExpense;
  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color(0xffffffff),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            widget.expense.getCategoryIcon(widget.expense.category),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.expense.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.normal)),
            ),
            const Spacer(),
            Column(
              children: [
                Text('${widget.expense.price.toStringAsFixed(2)} ₺ ',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(widget.expense.formattedDate),
              ],
            )
          ],
        ),
      ),
    );
  }
}
