class Expense {
  final String id;
  final String description;
  final int totalAmount;
  final String paidBy;
  final List<String> splitAmong;
  final String role;
  final int amount;

  Expense({
    required this.id,
    required this.description,
    required this.totalAmount,
    required this.paidBy,
    required this.splitAmong,
    required this.role,
    required this.amount,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['_id'],
      description: json['description'],
      totalAmount: json['totalAmount'],
      paidBy: json['paidBy'],
      splitAmong: List<String>.from(json['splitAmong']),
      role: json['role'],
      amount: json['amount'],
    );
  }
}
