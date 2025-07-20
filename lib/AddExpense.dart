import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key, required this.currentBalance, required this.onBalanceUpdated});

  final double currentBalance;
  final Function(double) onBalanceUpdated;

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String? selectedCategory;
  DateTime? selectedDate;

  bool isDropdownOpen = false;

  final List<String> categories = [
    'Food',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills',
    'Others',
  ];

  final userId = FirebaseAuth.instance.currentUser?.uid;

  Future<void> addExpense(String name, double amount, String category, DateTime date) async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    if (amount > widget.currentBalance) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exceeded Balance'),
            content: Text(
                'This expense exceeds your current balance of ${widget.currentBalance.toStringAsFixed(2)}.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('expenses')
          .add({
        'name': name,
        'amount': amount,
        'category': category,
        'date': Timestamp.fromDate(date),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense added successfully!')),
      );

      print('Expense added successfully');
    } catch (e) {
      print('Add Expense Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Four.png',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 78, left: 60),
            child: const Text(
              'Add Expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'ABeeZee',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 75, left: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.scale(
                scale: 1.5,
                child: const BackButton(color: Colors.white),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 180, left: 25, right: 25),
            child: Column(
              children: [
                // Amount Field
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 15),

                // Name Field
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 15),


                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  items: categories
                      .map((category) => DropdownMenuItem(
                    value: category,
                    child: Text(
                      category,
                      style: TextStyle(color: Colors.white),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedCategory = value ?? 'Others'),
                  dropdownColor: Colors.grey[800],
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: Colors.white70),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                ),


                const SizedBox(height: 15),

                // Date Picker
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedDate != null
                              ? "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}"
                              : 'Select Date',
                          style: const TextStyle(color: Colors.black87),
                        ),
                        const Icon(Icons.calendar_today, color: Colors.black87),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final amount = double.tryParse(amountController.text.trim()) ?? 0.0;

                    if (name.isNotEmpty &&
                        amount > 0 &&
                        selectedCategory != null &&
                        selectedDate != null) {
                      addExpense(name, amount, selectedCategory!, selectedDate!);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: const Text(
                    'Add Expense',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
