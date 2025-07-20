
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'widgets/ExpenseModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateExpensePage extends StatefulWidget {
  final Expense expense;
  final Function(Expense) onExpenseUpdated;

  const UpdateExpensePage({
    super.key,
    required this.expense,
    required this.onExpenseUpdated,
  });

  @override
  State<UpdateExpensePage> createState() => _UpdateExpensePageState();
}

class _UpdateExpensePageState extends State<UpdateExpensePage> {
  late final TextEditingController _descriptionController;
  late final TextEditingController _amountController;
  late String _selectedCategory;
  late DateTime _selectedDate;
  final _formKey = GlobalKey<FormState>();
  bool _isUpdating = false;

  static const List<String> _categories = [
    'Food',
    'Transportation',
    'Shopping',
    'Entertainment',
    'Bills',
    'Others',
  ];

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.expense.description);
    _amountController = TextEditingController(text: widget.expense.amount.toStringAsFixed(2));
    _selectedCategory = widget.expense.category;
    _selectedDate = widget.expense.date;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _updateExpense() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isUpdating) return;

    setState(() => _isUpdating = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final updateData = {
        'description': _descriptionController.text.trim(),
        'amount': double.parse(_amountController.text.trim()),
        'category': _selectedCategory,
        'date': Timestamp.fromDate(_selectedDate),
        'userId': user.uid,
      };

      final expensesCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('expenses');

      final query = await expensesCollection
          .where(FieldPath.documentId, isEqualTo: widget.expense.id)
          .limit(1)
          .get();

      if (query.docs.isEmpty) {
        throw Exception('Expense document not found');
      }

      await expensesCollection.doc(query.docs.first.id).update(updateData);

      final updatedExpense = Expense(
        id: query.docs.first.id,
        userId: user.uid,
        description: updateData['description'] as String,
        amount: updateData['amount'] as double,
        category: updateData['category'] as String,
        date: _selectedDate,
      );

      widget.onExpenseUpdated(updatedExpense);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expense updated successfully!')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Update failed: ${e.toString()}')),
      );
      debugPrint('Update error: $e');
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() => _selectedDate = pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isUpdating
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Four.png',
              fit: BoxFit.cover,
            ),
          ),

          // Back Button
          Padding(
            padding: const EdgeInsets.only(top: 75, left: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.scale(
                scale: 1.5,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),

          // Title
          Padding(
            padding: const EdgeInsets.only(top: 78, left: 60),
            child: Text(
              'Update Expense',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'ABeeZee',
              ),
            ),
          ),

          // Form Content
          Padding(
            padding: const EdgeInsets.only(top: 180, left: 25, right: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Description Field
                  TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) =>
                    value?.isEmpty ?? true ? 'Required field' : null,
                  ),
                  const SizedBox(height: 20),

                  // Amount Field
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Amount (PKR)',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) return 'Required field';
                      final amount = double.tryParse(value!);
                      if (amount == null) return 'Invalid number';
                      if (amount <= 0) return 'Must be greater than 0';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Category Dropdown
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    items: _categories
                        .map((category) => DropdownMenuItem(
                      value: category,
                      child: Text(
                        category,
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _selectedCategory = value ?? 'Others'),
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
                  const SizedBox(height: 20),

                  // Date Picker
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Date',
                        labelStyle: TextStyle(color: Colors.white70),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('MMMM dd, yyyy').format(_selectedDate),
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(Icons.calendar_today, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Update Button
                  Padding(
                    padding: const EdgeInsets.only(left: 200),
                    child: ElevatedButton(
                      onPressed: _isUpdating ? null : _updateExpense,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontFamily: 'ABeeZee',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}