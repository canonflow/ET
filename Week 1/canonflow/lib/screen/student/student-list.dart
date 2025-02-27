import 'package:canonflow/screen/student/student-detail.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class StudentList extends StatelessWidget {
  StudentList({ super.key }) {
    nums = [
      random.nextInt(70) + 1,
      random.nextInt(70) + 1,
      random.nextInt(70) + 1
    ];
  }
  final Random random = Random.secure();
  late final List<int> nums;  // Use late because it's initialize in the constructor


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => StudentDetail(nums[0]))
                );
              }, 
              child: Text('Student #${nums[0]}'),
            ),
            const SizedBox(height: 16),  // Spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => StudentDetail(nums[1]))
                );
              }, 
              child: Text('Student #${nums[1]}')
            ),
            const SizedBox(height: 16),  // Spacing
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => StudentDetail(nums[2]))
                );
              }, 
              child: Text('Student #${nums[2]}')
            )
          ],
        )
      ),
    );
  }
}

