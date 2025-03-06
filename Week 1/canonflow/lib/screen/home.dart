import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  const Home({ super.key });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      // body: const Center(
      //   child: Text("This is Home")
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./assets/images/wallpaper.jpg"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 300,
              alignment: Alignment(0, 0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("./assets/images/photo.jpg"),
                  fit: BoxFit.cover
                ),
                shape: BoxShape.circle
              ),
            ),
            const SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "\"One Touch of Nature Makes the Whole World Kin.\"",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              )
            ),
            const SizedBox(height: 20),
            Text(
              "- William Shakespeare",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            )
          ],
        ),
      )
    );
    
  }
}

