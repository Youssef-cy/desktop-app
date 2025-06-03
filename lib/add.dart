import 'dart:io';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:image_picker/image_picker.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController employee_id = TextEditingController();
  final TextEditingController employee_name = TextEditingController();
  final TextEditingController employee_location = TextEditingController();
  final TextEditingController employee_shift = TextEditingController();
  final TextEditingController employee_reward = TextEditingController();
  final TextEditingController employee_position = TextEditingController();

  File? _image;
  bool _dragging = false;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _onDropFiles(List<String> paths) {
    if (paths.isEmpty) return;

    final file = File(paths.first);

    final validExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.bmp'];
    final ext = file.path.toLowerCase();

    if (validExtensions.any((e) => ext.endsWith(e))) {
      setState(() {
        _image = file;
        _dragging = false;  
      });
    } else {
      setState(() {
        _dragging = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please drop a valid image file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(child: Text("Add Your Employee")),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة الموظف مع دعم السحب والإفلات
            DropTarget(
              onDragEntered: (details) {
                setState(() {
                  _dragging = true;
                });
              },
              onDragExited: (details) {
                setState(() {
                  _dragging = false;
                });
              },
              onDragDone: (details) {
                _onDropFiles(
                  details.urls.map((uri) => uri.toFilePath()).toList(),
                );
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 185),
                    child: Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              _dragging ? Colors.blue[100] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(15),
                          image:
                              _image != null
                                  ? DecorationImage(
                                    image: FileImage(_image!),
                                    fit: BoxFit.cover,
                                  )
                                  : null,
                        ),
                        child:
                            _image == null
                                ? Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.teal,
                                )
                                : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.upload),
                    label: const Text("Choose Image"),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 40),

            // نموذج بيانات الموظف
            Padding(
              padding: const EdgeInsets.only(top: 185, left: 250),
              child: Center(
                child: Container(
                  width: 650,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      // الصف الأول
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField(employee_name, "Employee Name"),
                          _buildTextField(employee_id, "Employee ID"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // الصف الثاني
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField(employee_location, "Location"),
                          _buildTextField(employee_shift, "Shift"),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // الصف الثالث
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextField(employee_position, "Position"),
                          _buildTextField(employee_reward, "Reward"),
                        ],
                      ),
                      const SizedBox(height: 40),

                      // عند الضغط على زر "Add Employee"
                      ElevatedButton(
                        onPressed: () {
                          if (employee_name.text.isNotEmpty) {
                            // نرجع البيانات للصفحة السابقة (Second)
                            Navigator.pop(context, {
                              'name': employee_name.text,
                              'id': employee_id.text,
                              'location': employee_location.text,
                              'shift': employee_shift.text,
                              'position': employee_position.text,
                              'reward': employee_reward.text,
                              'image': _image, // ممكن تضيفها لو حابب
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please fill at least the employee name",
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text("Add Employee"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return SizedBox(
      width: 280,
      height: 55,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}

extension on DropDoneDetails {
  get urls => null;
}
