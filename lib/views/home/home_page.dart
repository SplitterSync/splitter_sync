import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter_sync/views/login_page.dart';
import '../../state/user_provider.dart';
import '../../state/expense_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
    });

    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // This button could be used for logout, for example
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
            tooltip:
                'Logout', // Optional: Adds a small label when the user long presses the button
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<ExpenseProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  itemCount: provider.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = provider.expenses[index];
                    return ListTile(
                      title: Text(expense.description),
                      subtitle: Text('Paid by ${expense.paidBy}'),
                      trailing: Text('${expense.role} \$ ${expense.amount}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here for adding expenses
        },
        backgroundColor: Colors.blue,
        icon: Icon(Icons.add, color: Colors.white),
        label: Text("Add Expense",
            style: TextStyle(color: Colors.white, fontSize: 15)),
        tooltip: 'Add Expenses',
      ),
    );
  }
}
