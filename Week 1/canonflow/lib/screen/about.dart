import 'package:flutter/material.dart';


class About extends StatelessWidget {
  const About({ super.key });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
      ),
      body: const Center(
        child: Text("This is About")
      ),
    );
    
  }
}

