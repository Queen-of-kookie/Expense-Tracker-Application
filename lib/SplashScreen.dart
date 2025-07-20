import 'dart:async';
import 'Login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Dashboard.dart';

class SplashScreenPBL extends StatefulWidget{
  const SplashScreenPBL({super.key});

  @override
  State<SplashScreenPBL> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPBL> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5), (){
      checkLoginStatus();
    }
    );
  }
  Future<double> fetchTotalBalance(String userId) async{
    var fetch = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return fetch.data()?['totalBalance'] ?? 0.0;
  }

  void checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    User? user = FirebaseAuth.instance.currentUser;
    print("Current user: $user");

    if (user != null) {
      // ✅ Logged in
      double totalBalance = await fetchTotalBalance(user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(totalBalance: totalBalance,)),
      );
    } else {
      // ❌ Not logged in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder( // Ensures correct context for MediaQuery
        builder: (context) {
          final screenSize = MediaQuery.of(context).size;
          final isPortrait = screenSize.height > screenSize.width;
          print("Current user: ${FirebaseAuth.instance.currentUser}");

          return Stack(
            children: [
              // Background Image (Responsive)
              Positioned.fill(
                child: FittedBox(
                  fit: BoxFit.contain, // No cropping, maintains aspect ratio
                  child: SizedBox(
                    width: isPortrait ? screenSize.width : screenSize.height,
                    height: isPortrait ? screenSize.height : screenSize.width,
                    child: Image.asset(
                      'assets/images/Splash screen.png',
                      fit: BoxFit.cover, // Cover while preserving aspect
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body:
//     Container(
//       decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage('assets/images/pbl/Splash screen.png'),
//             fit: BoxFit.cover,
//           )
//       ),
//     ),
//   );
// }
}
