import 'dart:convert';

import 'package:canonflow/class/cart.dart';
import 'package:canonflow/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

class ViewCart extends StatefulWidget {
  const ViewCart({super.key});

  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  final dbHelper = DatabaseHelper.instance;
  List? _rsCart;

  Future<String> _bacaData() async {
    _rsCart = (await dbHelper.viewCart())!;
    setState(() {});

    if (_rsCart == null) {
      throw Exception('Failed to load data');
    } else {
      return "sukses";
    }
  }

  void _submit() async {
    _rsCart = await dbHelper.viewCart();
    String items = "";
    _rsCart?.forEach((item) {
      items = items +
          item['movie_id'].toString() +
          ',' +
          item['jumlah'].toString() +
          "|";
    });

    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/checkout.php"),
        body: {'user_id': ACTIVE_USER, 'items': items});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        dbHelper.emptyCart().then((value) => _bacaData());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Sukses Checkout')));
      }
    } else {
         log('Error: ${response.statusCode} - ${response.body}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan pada server')),
      );
    }
  }

  @override
  void initState() {
    _bacaData();
  }

  Widget _itemCart(index) {
    return Column(children: <Widget>[
      Text(_rsCart?[index]['title']),
      Row(
        children: [
          if (int.parse(_rsCart?[index]['jumlah']) > 0 )
            ElevatedButton(
              onPressed: () {
                dbHelper
                .kurangJumlah(_rsCart?[index]['movie_id'])
                .then((value) => _bacaData());
              }, 
              child: Text("-")
            ),
            SizedBox(width: 10),
          Text('jumlah=' + _rsCart?[index]['jumlah']),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              dbHelper
                .tambahJumlah(_rsCart?[index]['movie_id'])
                .then((value) => _bacaData());
            },
            child: Text("+")
          )
        ],
      ),
      Divider(),
    ]);
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 300,
                child: _rsCart != null
                  ? ListView.builder(
                      itemCount: _rsCart?.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return _itemCart(index);
                      }
                    )
                  : Text('belum ada data')
              ),
              ElevatedButton(
                onPressed: () {
                  _submit();
                }, 
                child: Text("Checkout")
              )
            ],
          )
        )
    );
  }
}