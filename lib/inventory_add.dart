import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class InventoryAdd extends StatefulWidget {
  const InventoryAdd({super.key});

  @override
  State<InventoryAdd> createState() => _InventoryAddState();
}

class _InventoryAddState extends State<InventoryAdd> {
  File? _pickedImage;
  final List<Map<String, dynamic>> _inventoryList = [];

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  void _showAddDialog({Map<String, dynamic>? existingItem, int? index}) {
    final nameController = TextEditingController(
      text: existingItem?['name'] ?? '',
    );
    final priceController = TextEditingController(
      text: existingItem?['price'] ?? '',
    );
    final quantityController = TextEditingController(
      text: existingItem?['quantity'] ?? '',
    );
    _pickedImage = existingItem?['image'];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(
              existingItem == null
                  ? "Add Inventory Item"
                  : "Edit Inventory Item",
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Item Name"),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Price"),
                  ),
                  TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Quantity"),
                  ),
                  const SizedBox(height: 10),
                  _pickedImage != null
                      ? Image.file(_pickedImage!, height: 100)
                      : SizedBox(),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: Icon(Icons.image),
                    label: Text("Pick Image"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final newItem = {
                    'name': nameController.text,
                    'price': priceController.text,
                    'quantity': quantityController.text,
                    'image': _pickedImage,
                    'timestamp':
                        existingItem != null
                            ? existingItem['timestamp']
                            : DateTime.now(),
                  };

                  setState(() {
                    if (index != null) {
                      _inventoryList[index] = newItem;
                    } else {
                      _inventoryList.add(newItem);
                    }
                  });

                  Navigator.of(ctx).pop();
                },
                child: Text("Save"),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  void _showOptionsDialog(int index) {
    showDialog(
      context: context,
      builder:
          (ctx) => SimpleDialog(
            title: Text("Choose an action"),
            children: [
              SimpleDialogOption(
                child: Text("Edit"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _showAddDialog(
                    existingItem: _inventoryList[index],
                    index: index,
                  );
                },
              ),
              SimpleDialogOption(
                child: Text("Delete"),
                onPressed: () {
                  setState(() {
                    _inventoryList.removeAt(index);
                  });
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd – hh:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Inventory')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child:
                _inventoryList.isEmpty
                    ? Center(child: Text("No items added yet."))
                    : ListView.builder(
                      itemCount: _inventoryList.length,
                      itemBuilder: (context, index) {
                        final item = _inventoryList[index];
                        return Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading:
                                item['image'] != null
                                    ? Image.file(
                                      item['image'],
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                    : Icon(Icons.inventory, size: 50),
                            title: Text(item['name']),
                            subtitle: Text(
                              "Price: ${item['price']}\n"
                              "Quantity: ${item['quantity']}\n"
                              "Added: ${_formatTimestamp(item['timestamp'])}",
                            ),
                            isThreeLine: true,
                            onTap: () => _showOptionsDialog(index),
                          ),
                        );
                      },
                    ),
          ),
          Positioned(
            bottom: 30,
            right: 50,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(Icons.add),
                iconSize: 50,
                onPressed: () => _showAddDialog(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
