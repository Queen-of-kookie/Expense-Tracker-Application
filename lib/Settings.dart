import 'AboutUs.dart';
import 'Dashboard.dart';
import 'package:flutter/material.dart';
import 'UpdateInfo.dart';

class SettingsPage extends StatelessWidget {
  final double totalBalance;

  const SettingsPage({super.key, required this.totalBalance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Three.png',
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 75, left: 5),
            child: Align(
              alignment: Alignment.topLeft,
              child: Transform.scale(
                scale: 1.5,
                child: BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => DashboardScreen(totalBalance: totalBalance)),
                    );
                  },
                ),
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(top: 78, left: 65),
              child: Text(
                'Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'ABeeZee'
                ),
              )
          ),

          Padding(
            padding: EdgeInsets.only(top: 250, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Update Information',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'ABeeZee'
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UpdateInfoPage())
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios, size: 25, color: Colors.white)
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'About Us',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'ABeeZee'
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AboutUsPage())
                          );
                        },
                        icon: Icon(Icons.arrow_forward_ios, size: 25, color: Colors.white)
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'Rate App',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'ABeeZee'
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => RateAppPage())
                          // );
                        },
                        icon: Icon(Icons.arrow_forward_ios, size: 25, color: Colors.white)
                    ),
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'Delete Account',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontFamily: 'ABeeZee'
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                        },
                        icon: Icon(Icons.arrow_forward_ios, size: 25, color: Colors.white)
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}