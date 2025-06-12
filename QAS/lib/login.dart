import 'package:qas_160422041_et/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyLogin extends StatelessWidget {
  const MyLogin({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
            primarySwatch: Colors.blue
        ),
        home: Login()
    );
  }
}

class Login extends StatefulWidget {
  const Login({ super.key });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login> {

  String _user_email = "";
  String _user_password = "";
  String _error_login = "";

  void doLogin() async {
    // if (_user_id != "") {
    //   final prefs = await SharedPreferences.getInstance();
    //   prefs.setString("user_id", _user_id);
    //   main();
    // }
    final response = await http.post(
        Uri.parse("https://ubaya.xyz/flutter/160422041/qas/login.php"),
        body: {'email': _user_email, 'password': _user_password});
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        final prefs = await SharedPreferences.getInstance();
        // prefs.setString("user_id", _user_email);
        prefs.setString("user_email", json['email']);
        main();
      } else {
        setState(() {
          _error_login = "Incorrect user or password";
        });
      }
    } else {
      throw Exception('Failed to read API');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Login")
      ),
      body: Container(
        height: 400,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 1),
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 5)
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter valid email id as absc@gmail.com"
                ),
                onChanged: (v) {
                  _user_email = v;
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      hintText: "Enter secure password"
                  ),
                  onChanged: (v) {
                    _user_password = v;
                  },
                )
            ),
            // Padding(
            //   padding: EdgeInsets.all(10),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       border: OutlineInputBorder(),
            //       labelText: "Username",
            //       hintText: "Enter your username"
            //     ),
            //     onChanged: (v) {
            //       _user_id = v;
            //     },
            //   ),
            // ),
            (_error_login != "") ?
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(_error_login, style: TextStyle(color: Colors.red)),
            ) :
            Padding(padding: EdgeInsets.all(0)),

            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 50,
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: ElevatedButton(
                    onPressed: () {
                      doLogin();
                    },
                    child: Text(
                        'Login',
                        style: TextStyle(fontSize: 25)
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );

  }
}