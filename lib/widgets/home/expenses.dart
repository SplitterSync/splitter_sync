import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter_sync/state/expense_provider.dart';

class ExpensesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Expenses Activity')),
        body: Consumer<ExpenseProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: provider.expenses.length,
                itemBuilder: (context, index) {
                  final expense = provider.expenses[index];
                  return ListTile(
                    title: Text(expense.description),
                    subtitle: Text('Paid by ${expense.paidBy}, Amount: \$${expense.amount}'),
                    trailing: Text(expense.role),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses(),
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
