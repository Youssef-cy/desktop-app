import 'package:flutter/material.dart';
import 'package:to_do_app/second..dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController marketController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 45),
          child: Container(
            height: 450,
            width: 350,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 1, 81, 73),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "create your market",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    controller: marketController,
                    decoration: InputDecoration(
                      hintText: 'Enter your Market name',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      hintText: 'Enter your location',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'create your password',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 0, 0, 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text.trim();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Second(userName: name),
                      ),
                    );
                  },
                  child: Text(
                    "Sign in for Market",
                    style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 255, 226, 226),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
