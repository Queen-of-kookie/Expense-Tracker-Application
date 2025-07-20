import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'Settings.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'widgets/ExpenseModel.dart';
import 'widgets/ExpenseTile.dart';
import 'AddExpense.dart';

class DashboardScreen extends StatefulWidget {
  final double totalBalance;
  const DashboardScreen({super.key,required this.totalBalance});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Expense> expenses = [];// List to store added expenses

  late double totalBalance;
  double spentAmount = 0;
  double remainingBalance = 0;

  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    totalBalance = widget.totalBalance;
    remainingBalance = totalBalance;
  }

  void _calculateBalance(List<Expense> expenses) {
    spentAmount = expenses.fold(0, (sum, expense) => sum + expense.amount);
    remainingBalance = totalBalance - spentAmount;
  }

  void addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
      spentAmount += expense.amount;
      remainingBalance = totalBalance - spentAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: Color(0xFF1F1313),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: ListTile(
                leading: Icon(Icons.account_circle, size: 40, color: Colors.white,),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 22,
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 60),
              child: ListTile(
                leading: Icon(Icons.home, size: 26, color: Colors.white,),
                title: Text(
                  'Home',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'ABeeZee',
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                },
              ),
            ),

            ListTile(
              leading: Icon(Icons.analytics_outlined,size: 26, color: Colors.white,),
              title: Text(
                'Expense Analysis',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ABeeZee',
                    color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.auto_awesome, size: 26, color: Colors.white,),
              title: Text(
                'AI Assistant',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ABeeZee',
                    color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: Icon(Icons.settings, size: 26, color: Colors.white,),
              title: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'ABeeZee',
                    color: Colors.white
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage(totalBalance: totalBalance)),
                );
              },
            ),

            Padding(
              padding: const EdgeInsets.only(top: 400),
              child: ListTile(
                leading: Icon(Icons.logout, size: 36,color: Colors.white,),
                title: Text(
                  'LOGOUT',
                  style: TextStyle(
                      fontFamily: 'ABeeZee',
                      fontSize: 22,
                      color: Colors.white
                  ),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/Background Five.png',
              fit: BoxFit.cover,
            ),
          ),

          // Header with logo and settings
          Padding(
            padding: EdgeInsets.only(top: 60, left: 170),
            child: Row(
              children: [
                Image.asset('assets/images/Logo.png', height: 50, width: 50),
                Spacer(),
                IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: Icon(Icons.menu, size: 40, color: Colors.white),
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.pushReplacement(
                //       context,
                //       MaterialPageRoute(builder: (context) => SettingsPage(totalBalance: totalBalance)),
                //     );
                //   },
                //   icon: Icon(Icons.settings_outlined, size: 40, color: Colors.white),
                // ),
              ],
            ),
          ),

          // Dashboard title
          Padding(
            padding: EdgeInsets.only(top: 115, left: 10),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'ABeeZee',
                fontSize: 26,
              ),
            ),
          ),

          // Balance Card
          Container(
            width: 400,
            height: 200,
            margin: EdgeInsets.only(top: 170, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(
                colors: [
                  Colors.red.shade700,
                  Colors.red.shade600,
                  Colors.red.shade500,
                  Colors.red.shade400,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 7,
                ),
              ],
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text('Total Balance', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 38, left: 20),
                  child: Text('${totalBalance.toStringAsFixed(0)} PKR', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 75, left: 10),
                  child: Text('Spent', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 100, left: 20),
                  child: Text('${spentAmount.toStringAsFixed(0)} PKR', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 134, left: 10),
                  child: Text('Remaining Balance', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 162, left: 20),
                  child: Text('${remainingBalance.toStringAsFixed(0)} PKR', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 160),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: remainingBalance,
                          color: Colors.grey.shade50,
                          showTitle: true,
                          title: '${((remainingBalance / totalBalance) * 100).toStringAsFixed(1)}%',
                          radius: 35,
                        ),
                        PieChartSectionData(
                          value: spentAmount,
                          color: Colors.red.shade200,
                          showTitle: true,
                          title: '${((spentAmount / totalBalance) * 100).toStringAsFixed(1)}%',
                          radius: 35,
                        ),
                      ],
                      centerSpaceRadius: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Recent Entries and Add Button
          Padding(
            padding: EdgeInsets.only(top: 400, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Recent Entries',
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddExpensePage(
                              currentBalance: remainingBalance, // Pass the actual remaining balance
                              onBalanceUpdated: (newBalance) {
                                setState(() {
                                  remainingBalance = newBalance;
                                  spentAmount = totalBalance - remainingBalance;
                                });
                              },
                            ),
                          ),
                        );

                        if (result is Expense) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(userId)
                              .collection('expenses')
                              .add(result.toDocument());
                        }
                      },
                      icon: Icon(Icons.add, size: 40, color: Colors.white),
                    )
                  ],
                ),
                Expanded(
                  child:
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .collection('expenses')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        print('Loading data...');
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        print('No data found');
                        return const Center(
                          child: Text('No expenses found.', style: TextStyle(color: Colors.white)),
                        );
                      }

                      final expenses = snapshot.data!.docs
                          .map((doc) => Expense.fromSnapshot(doc))
                          .toList();
                      print('Fetched ${expenses.length} expenses');
                      _calculateBalance(expenses);

                      return ListView.builder(
                        itemCount: expenses.length,
                        itemBuilder: (context, index) {
                          return ExpenseTile(
                            expense: expenses[index],
                            onDelete: () async {
                              try {
                                // Delete from Firebase first
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userId)
                                    .collection('expenses')
                                    .doc(expenses[index].id)
                                    .delete();

                                // Then update the local state
                                setState(() {
                                  expenses.removeAt(index);
                                  _calculateBalance(expenses); // Recalculate balances
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Expense deleted successfully')),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Failed to delete expense: $e')),
                                );
                                debugPrint('Delete error: $e');
                              }
                            },
                            onEdit: (updatedExpense) {
                              setState(() {
                                expenses[index] = updatedExpense;
                                _calculateBalance(expenses);
                              });
                            },
                          );
                        },
                      );
                    },
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
