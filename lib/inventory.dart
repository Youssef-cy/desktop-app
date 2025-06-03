import 'package:flutter/material.dart';
import 'data.dart';

class Inventory extends StatelessWidget {
  const Inventory({super.key, required String userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),
      body: ValueListenableBuilder<List<InventoryItem>>(
        valueListenable: inventoryListNotifier,
        builder: (context, inventoryList, _) {
          if (inventoryList.isEmpty) {
            return Center(child: Text("No inventory items added yet."));
          }

          return GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: inventoryList.length,
            itemBuilder: (context, index) {
              final item = inventoryList[index];
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    item.image != null
                        ? Image.file(item.image!, height: 80)
                        : Icon(Icons.inventory, size: 60),
                    SizedBox(height: 10),
                    Text(
                      item.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Text("Price: ${item.price}"),
                    Text("Qty: ${item.quantity}"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
