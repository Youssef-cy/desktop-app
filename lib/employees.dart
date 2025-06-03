import 'dart:io';
import 'package:flutter/material.dart';

class Employees extends StatefulWidget {
  final List<Map<String, dynamic>> employees;

  const Employees({super.key, required this.employees});

  @override
  State<Employees> createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  void _showOptionsDialog(int index) {
    final emp = widget.employees[index];

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text("Employee: ${emp['name']}"),
            content: Text("Do you want to delete or edit this employee?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _editEmployee(index);
                },
                child: Text("Edit"),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.employees.removeAt(index);
                  });
                  Navigator.of(ctx).pop();
                },
                child: Text("Delete", style: TextStyle(color: Colors.red)),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  void _editEmployee(int index) async {
    final emp = widget.employees[index];
    final nameController = TextEditingController(text: emp['name']);
    final idController = TextEditingController(text: emp['id']);
    final positionController = TextEditingController(text: emp['position']);
    final shiftController = TextEditingController(text: emp['shift']);
    final salaryController = TextEditingController(text: emp['salary']);

    await showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text("Edit Employee"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(labelText: "ID"),
                  ),
                  TextField(
                    controller: positionController,
                    decoration: InputDecoration(labelText: "Position"),
                  ),
                  TextField(
                    controller: shiftController,
                    decoration: InputDecoration(labelText: "Shift"),
                  ),
                  TextField(
                    controller: salaryController,
                    decoration: InputDecoration(labelText: "Salary"),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.employees[index] = {
                      ...emp,
                      'name': nameController.text,
                      'id': idController.text,
                      'position': positionController.text,
                      'shift': shiftController.text,
                      'salary': salaryController.text,
                    };
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employees List"),
        backgroundColor: Colors.grey[200],
      ),
      body:
          widget.employees.isEmpty
              ? Center(child: Text("No employees added yet."))
              : ListView.builder(
                itemCount: widget.employees.length,
                itemBuilder: (context, index) {
                  final emp = widget.employees[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: ListTile(
                      leading:
                          emp['image'] != null
                              ? Image.file(
                                emp['image'] as File,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                              : Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                      title: Text(emp['name'] ?? 'No Name'),
                      subtitle: Text(
                        "ID: ${emp['id'] ?? 'N/A'}\n"
                        "Position: ${emp['position'] ?? 'N/A'}\n"
                        "Shift: ${emp['shift'] ?? 'N/A'}\n"
                        "Salary: ${emp['salary'] ?? 'N/A'}",
                      ),
                      isThreeLine: true,
                      onTap: () => _showOptionsDialog(index),
                    ),
                  );
                },
              ),
    );
  }
}
