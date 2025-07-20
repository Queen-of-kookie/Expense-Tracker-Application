import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1F1313),
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF1F1313),
      //   title: Padding(
      //     padding: const EdgeInsets.only(top: 20),
      //     child: Text(
      //       'About Us',
      //       style: TextStyle(
      //           fontFamily: 'ABeeZee',
      //           fontSize: 28,
      //           color: Colors.white
      //       ),
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 75, left: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Transform.scale(
                    scale: 1.5,
                    child: BackButton(color: Colors.white),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 75, left: 20),
                child: Text(
                  'About Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'ABeeZee',
                  ),
                ),
              ),
            ],
          ),

          SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Our Mission",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "To simplify personal finance by combining powerful AI tools with a user-friendly design.",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  "Key Features",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "- Smart expense categorization\n"
                      "- Overspending alerts\n"
                      "- Monthly savings tips\n"
                      "- Visual reports & AI forecasts",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  "Technologies Used",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Icon(Icons.phone_android, size: 30, color: Colors.white), // Flutter icon
                    SizedBox(width: 10),
                    Icon(Icons.cloud, size: 30, color: Colors.white),         // Firebase
                    SizedBox(width: 10),
                    Icon(Icons.smart_toy, size: 30, color: Colors.white),      // AI / ML
                  ],
                ),

                const SizedBox(height: 16),
                Text(
                  "Developed By",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Ayesha — Computer Science Student\nPassionate about AI and mobile app development.",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
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
