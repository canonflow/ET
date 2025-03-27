import 'package:canonflow/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String _user_id = "";

  void doLogin() async {
    if (_user_id != "") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("user_id", _user_id);
      main();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login")
      ),
      body: Container(
        height: 300,
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
                  _user_id = v;
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