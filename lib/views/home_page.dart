import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter_sync/views/login_page.dart';
import '../state/user_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome, ${user?.name ?? 'Unknown'}"),
            Text("Email: ${user?.email ?? 'No email'}"),
            MaterialButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginPage()));
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 5), // Adjust padding as needed
        child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          backgroundColor: Colors.blue,
          icon: const Icon(Icons.add, color: Colors.white),
          label: const Text(
            "Add Expense",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          tooltip: 'Add Expenses',
        ),
      ),
    );
  }
}
