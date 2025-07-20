import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateInfoPage extends StatefulWidget {
  const UpdateInfoPage({super.key});

  @override
  State<UpdateInfoPage> createState() => _UpdateInfoPageState();
}

class _UpdateInfoPageState extends State<UpdateInfoPage> {
  // Controllers for TextFields
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController incomeController = TextEditingController();

  // Firebase Auth to get the current user ID
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  // Method to update user information in Firestore
  Future<void> updateUserInfo() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final nickname = nicknameController.text.trim();
    final balance = double.tryParse(balanceController.text.trim()) ?? 0.0;
    final income = double.tryParse(incomeController.text.trim()) ?? 0.0;

    if (nickname.isEmpty || balance <= 0 || income <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields with valid data')),
      );
      return;
    }

    try {
      // Update Firestore with user data
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'nickname': nickname,
        'totalBalance': balance,
        'monthlyIncome': income,
      }, SetOptions(merge: true)); // Merges with existing data if any

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Information updated successfully!')),
      );
      Navigator.pop(context); // Go back to the previous screen
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating information: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Four.png',
              fit: BoxFit.cover,
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

          const Padding(
            padding: EdgeInsets.only(top: 78, left: 60),
            child: Text(
              'Update Information',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'ABeeZee',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 220, left: 25, right: 25),
            child: Column(
              children: [
                TextField(
                  controller: nicknameController,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Nick Name',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: balanceController,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Total Balance',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: incomeController,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Income Per Month',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding:  EdgeInsets.only(top: 440, bottom: 318, left: 290),
            child: ElevatedButton(
              onPressed: updateUserInfo,
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
    );
  }
}
