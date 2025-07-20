import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Login.dart';
import 'SplashScreen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreenPBL(),
    );
  }
}

class FrontScreenPBL extends StatelessWidget {
  const FrontScreenPBL({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 600; // Mobile vs tablet/desktop

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Three.png',
              fit: BoxFit.cover,
            ),
          ),

          // Content Column
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 25.0 : screenSize.width * 0.1,
              vertical: isSmallScreen ? 75.0 : screenSize.height * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                Image.asset(
                  'assets/images/Logo.png',
                  width: isSmallScreen ? 150.0 : 200.0,
                ),
                const Spacer(),
                // Welcome Text
                Text(
                  'Welcome To',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 31.0 : 38.0,
                    fontFamily: 'ABeeZee',
                  ),
                ),
                // ExpenseX Text
                Text(
                  'ExpenseX.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 30.0 : 40.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BrunoACE',
                  ),
                ),
                SizedBox(height: isSmallScreen ? 10.0 : 20.0),
                // Subtitle
                Text(
                  'The best way to track your expenses.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isSmallScreen ? 20.0 : 24.0,
                    fontFamily: 'ABeeZee',
                  ),
                ),
                SizedBox(height: isSmallScreen ? 40.0 : 60.0),
                // Navigation Button (aligned to bottom-right)
                Align(
                  alignment: Alignment.centerRight,
                  child: CircleAvatar(
                    radius: isSmallScreen ? 45.0 : 60.0,
                    backgroundColor: Colors.white,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        size: isSmallScreen ? 40.0 : 50.0,
                        color: Colors.black,
                      ),
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

// class FrontScreenPBL extends StatelessWidget {
//
//   const FrontScreenPBL({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background image fills the entire screen
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/pbl/Background Three.png',
//               fit: BoxFit.cover, // Ensures the image covers the entire screen
//             ),
//           ),
//
//           Padding(
//             padding: EdgeInsets.only(top: 75,left: 25),
//             child: Image.asset('assets/images/pbl/Logo.png'),
//           ),
//
//           Padding(
//             padding: EdgeInsets.only(top: 700,right: 208, left: 25),
//             child: Text(
//               'Welcome To',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 31,
//                   fontFamily: 'ABeeZee'
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: EdgeInsets.only(top: 750,right: 190, left: 25),
//             child: Text(
//               'ExpenseX.',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'BrunoACE'
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: EdgeInsets.only(top: 800, bottom: 40, left: 25),
//             child: Text(
//               'The best way to track your expenses.',
//               style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontFamily: 'ABeeZee'
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: EdgeInsets.only(top: 700, left: 300),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               maxRadius: 45,
//               child: IconButton(
//                 onPressed: (){
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen())
//                   );
//                 },
//                 icon: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 65,
//                 ),
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
