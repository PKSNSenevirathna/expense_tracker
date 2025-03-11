import 'package:flutter/material.dart';
import 'add_expense_screen.dart';
import 'expense_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  double getTotalExpenses() {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  Icon getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Icon(Icons.fastfood, color: Colors.orange);
      case "Transport":
        return Icon(Icons.directions_bus, color: Colors.blue);
      case "Shopping":
        return Icon(Icons.shopping_cart, color: Colors.green);
      case "Bills":
        return Icon(Icons.receipt_long, color: Colors.red);
      default:
        return Icon(Icons.category);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),),
        backgroundColor: Colors.cyanAccent.shade100,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Card(
                margin: EdgeInsets.all(10),
                color: Colors.blueAccent,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Total Expenses: \$${getTotalExpenses().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: expenses.isEmpty
                    ? Center(child: Text("No expenses yet!", style: TextStyle(fontSize: 18, color: Colors.black54)))
                    : ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 5,
                        child: ListTile(
                          leading: getCategoryIcon(expenses[index].category),
                          title: Text(expenses[index].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          subtitle: Text("\$${expenses[index].amount.toStringAsFixed(2)} - ${expenses[index].category}"),
                          trailing: Text("${expenses[index].date.toLocal()}".split(' ')[0]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddExpenseScreen()),
          );
          if (result != null) {
            addExpense(result);
          }
        },
      ),
    );
  }
}
