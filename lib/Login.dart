import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'Signup.dart';
import 'Dashboard.dart';
import 'Authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final double totalBalance = 10000.0;

  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void login() async{
    String email = emailController.text.trim();
    String password = passController.text.trim();

    var user = await Authentication().loginWithEmailPassword(email, password);

    if(user != null){
      double totalBalance = await fetchTotalBalance(user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen(totalBalance: totalBalance,)),
      );

      print("Login Successfully");
    } else{
      print("Login Failed");
    }
  }

  Future<double> fetchTotalBalance(String userId) async{
    var fetch = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return fetch.data()?['totalBalance'] ?? 0.0;
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
            padding: EdgeInsets.only(top: 75, left: 25),
            child: Image.asset('assets/images/Logo.png'),
          ),
          Padding(
            padding: EdgeInsets.only(top: 215, left: 25, right: 118),
            child: Text(
              'You are just one step away!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'ABeeZee',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 280, left: 25, right: 25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nicknameController,
                    autofocus: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Nick Name',
                      hintStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your nickname';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    autofocus: false,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    autofocus: false,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your E-mail Address';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 470, left: 290),
            child: ElevatedButton(
              onPressed: login,
              child: Text(
                'Login',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontFamily: 'ABeeZee',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 540, left: 80),
            child: Row(
              children: [
                Text(
                  'New on ExpenseX? ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'ABeeZee',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text(
                    'Sign-up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'ABeeZee',
                      fontStyle: FontStyle.italic,
                    ),
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
