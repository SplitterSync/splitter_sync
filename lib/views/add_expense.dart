import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitter_sync/views/home/home_page.dart';

class AddExpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Expense"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () {
                // This button could be used for logout, for example
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => HomePage()));
              },

              // Optional: Adds a small label when the user long presses the button
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 95.0, right: 95.0, top: 155.0, bottom: 15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.currency_pound),
                      labelText: "Amount",
                      hintText: "Enter Amount"),
                ),
              ),
              const Text("Paid By Rishi & split between Rishi,Fenyx & ASSINIX"),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Paid By")),
                  ElevatedButton(
                      onPressed: () {}, child: const Text("Split Between"))
                ],
              )
            ],
          ),
        ));
  }
}
