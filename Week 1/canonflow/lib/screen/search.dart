import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  const Search({ super.key });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: const Center(
        child: Text("This is Search")
      ),
    );
    
  }
}