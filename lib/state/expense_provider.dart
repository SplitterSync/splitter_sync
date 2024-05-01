import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter_sync/models/expense_model.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;

  // ExpenseProvider() {
  //   fetchExpenses(); // Call fetch when provider is created
  // }

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;



  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // Assuming the token is stored with this key

    if (token == null) {
      _isLoading = false;
      notifyListeners();
      throw Exception('Authentication token not found.');
    }

    try {
      final response = await http.get(
        Uri.parse('https://splitter-sync-api.vercel.app/expenses/activity'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Use token for Authorization
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> expensesJson = jsonDecode(response.body);
        _expenses = expensesJson.map((json) => Expense.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load expenses with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to make API call: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
