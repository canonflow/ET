import 'dart:convert';

import 'package:canonflow/class/popactor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class PopularActor extends StatefulWidget {
  const PopularActor({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PopularActorState();
  }
}

String _temp = 'waiting API respond…';
 Future<String> fetchData() async {
  final response = await http
    .get(Uri.parse("https://ubaya.xyz/flutter/160422041/actorlist.php"));
  if (response.statusCode == 200) {
   return response.body;
  } else {
   throw Exception('Failed to read API');
  }
 }


class _PopularActorState extends State<PopularActor> {

  List<PopActor> PAs = [];

  bacaData() {
    Future<String> data = fetchData();
    data.then((val) {
      Map json = jsonDecode(val);
      for (var mov in json['data']) {
        PopActor pm = PopActor.fromJson(mov);
        PAs.add(pm);
      }

      setState(() {
        _temp = PAs[2].name;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Actor') 
      ),
      body: ListView(
        children:  <Widget>[
          // Text(_temp)
          Container(
            height: MediaQuery.of(context).size.height - 200,
            child: DaftarPopActor(PAs),
          )
        ]
      )
    );
  }

  Widget DaftarPopActor(popActs) {
    if (popActs != null) {
      return ListView.builder(
        itemCount: popActs.length,
        itemBuilder: (BuildContext context, int index) {
          // return Text(popMovs[index].title.toString());
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.person, size: 30),
                  title: Text(popActs[index].name),
                ),
                SizedBox(height: 8)
              ],
            ),
          );
        }
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
