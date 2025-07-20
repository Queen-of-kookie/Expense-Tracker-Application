import 'package:cloud_firestore/cloud_firestore.dart';

class Expense {
  final String id; // Document ID
  final String userId; // User ID
  final String description;
  final String category; // Category
  final DateTime date; // Date of expense
  final double amount; // Expense amount

  Expense({
    required this.id,
    required this.userId,
    required this.description,
    required this.category,
    required this.date,
    required this.amount,
  });

  // Convert document snapshot to model
  factory Expense.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Expense(
      id: doc.id,
      userId: data['userId'] ?? '',
      description: data['description'] ?? '',
      category: data['category'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      amount: data['amount'] ?? 0.0,
    );
  }

  // Convert model to map
  Map<String, dynamic> toDocument() {
    return {
      'description': description,
      'amount': amount,
      'category': category,
      'date': date,
      'userId': userId,
    };
  }
}
