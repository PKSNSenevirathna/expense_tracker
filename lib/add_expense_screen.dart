import 'package:flutter/material.dart';
import 'expense_model.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = "";
  double amount = 0.0;
  String category = "Food";
  DateTime selectedDate = DateTime.now();

  void submitData() {
    if (_formKey.currentState!.validate()) {
      Expense newExpense = Expense(
        title: title,
        amount: amount,
        category: category,
        date: selectedDate,
      );
      Navigator.pop(context, newExpense);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Title", border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? "Enter a title" : null,
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(labelText: "Amount", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty || double.tryParse(value) == null ? "Enter a valid amount" : null,
                onChanged: (value) => amount = double.parse(value),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: category,
                decoration: InputDecoration(border: OutlineInputBorder()),
                items: ["Food", "Transport", "Shopping", "Bills"].map((String category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) => setState(() => category = value!),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () => _selectDate(context),
                child: Text("Select Date: ${selectedDate.toLocal()}".split(' ')[0]),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                child: Text("Submit", style: TextStyle(color: Colors.white)),
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
