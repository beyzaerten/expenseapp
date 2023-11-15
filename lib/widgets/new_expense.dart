import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({Key? key}) : super(key: key);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controller
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; // Seçilen tarihi saklamak için değişken

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            maxLength: 50,
            decoration: const InputDecoration(labelText: "Harcama Adı"),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Tutar",
              prefixText: "₺",
            ),
          ),
          IconButton(
            onPressed: () async {
              // Tarih seçiciyi göster ve kullanıcının bir tarih seçmesini bekle
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );

              // Kullanıcı bir tarih seçtiyse seçilen tarihi güncelle
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            icon: const Icon(Icons.calendar_today),
          ),
          Text(
            _selectedDate == null
                ? "Tarih Seçiniz.."
                : "Seçilen Tarih: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}",
          ),
          ElevatedButton(
            onPressed: () {
              // Buton basımını işle, _selectedDate'i gerektiği gibi kullanın
              if (_selectedDate != null) {
                print("Kayıt başarılı: ${_nameController.text}");
                print("Seçilen Tarih: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}");
              } else {
                print("Lütfen bir tarih seçin.");
              }
            },
            child: const Text("Kaydet"),
          ),
        ],
      ),
    );
  }
}
