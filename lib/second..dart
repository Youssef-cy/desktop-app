import 'package:flutter/material.dart';
import 'package:to_do_app/add.dart';
import 'package:to_do_app/employees.dart';
import 'package:to_do_app/inventory_add.dart';

class Second extends StatefulWidget {
  final String userName;

  const Second({super.key, required this.userName});

  @override
  State<Second> createState() => _SecondState();
}

class _SecondState extends State<Second> {
  List<Map<String, dynamic>> employeesList = [];
  List<Map<String, dynamic>> inventoryList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Welcome ${widget.userName} 👋"),
        centerTitle: true,
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 70,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final newEmployee = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Add()),
                    );
                    if (newEmployee != null) {
                      setState(() {
                        employeesList.add(newEmployee);
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.inventory),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InventoryAdd()),
                    );
                    if (result != null &&
                        result is List<Map<String, dynamic>>) {
                      setState(() {
                        inventoryList = result;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => Employees(employees: employeesList),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard Overview",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      _buildSummaryCard(
                        title: "Total Employees",
                        count: employeesList.length,
                        icon: Icons.people,
                        color: Colors.blueAccent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Employees(employees: employeesList),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      _buildSummaryCard(
                        title: "Inventory Items",
                        count: inventoryList.length,
                        icon: Icons.inventory_2,
                        color: Colors.green,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InventoryAdd(),
                            ),
                          );
                          if (result != null &&
                              result is List<Map<String, dynamic>>) {
                            setState(() {
                              inventoryList = result;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(icon, size: 50, color: color),
                SizedBox(height: 16),
                Text(
                  "$count",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
