import 'package:flutter/material.dart';
import 'package:to_do_app/inventory.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/orders.dart';
import 'package:to_do_app/settings.dart';

class First extends StatefulWidget {
  final String userName;

  const First({super.key, required this.userName});

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  List<Map<String, dynamic>> inventoryList = [];

  // استدعاء البيانات من صفحة الإنفنتوري
  Future<void> fetchInventoryData(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Inventory(userName: widget.userName),
      ),
    );

    if (result != null && result is List<Map<String, dynamic>>) {
      setState(() {
        inventoryList = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Padding(
          padding: const EdgeInsets.only(left: 700),
          child: Text("${widget.userName} 👋"),
        ),
      ),
      body: Row(
        children: [
          // الشريط الجانبي الأيسر
          Container(
            width: 60,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Settings()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.archive),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Orders()),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.inventory),
                  onPressed: () {
                    fetchInventoryData(context); // تحميل البيانات
                  },
                ),
              ],
            ),
          ),

          // محتوى العناصر على شكل مربعات
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
                  inventoryList.isEmpty
                      ? Center(
                        child: Text(
                          "there's no item yet ",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                      )
                      : GridView.builder(
                        itemCount: inventoryList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 1.2,
                        ),
                        itemBuilder: (context, index) {
                          final item = inventoryList[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.widgets,
                                    size: 40,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    item['name'] ?? 'name undefind',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "quantity: ${item['quantity'] ?? 0}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    "price: ${item['price'] ?? 0} \$",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
