import 'package:flutter/material.dart';
import 'dart:math';


class StudentDetail extends StatelessWidget {
  final int number;
  const StudentDetail(this.number, { super.key });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student Detail"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Student #$number", 
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://i.pravatar.cc/300?img=$number",
                fit: BoxFit.cover,
              ),
            )
          ],
        )
      ),
    );
  }
}

