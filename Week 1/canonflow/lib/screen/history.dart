import 'package:flutter/material.dart';


class History extends StatelessWidget {
  const History({ super.key });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: const Center(
        child: Text("This is History")
      ),
    );
    
  }
}