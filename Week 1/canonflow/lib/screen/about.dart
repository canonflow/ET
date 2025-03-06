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
      // body: const Center(
      //   child: Text("This is About")
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            containerAspectRatio(),
            containerEdgeInsets(),
            containerBoxDecoration(),
            rowImages(),
            Divider(height: 20),
            rowImagesWithScroll(),
            const SizedBox(height: 20),
            containerStack(),
            Container(
              height: 500,
              child: GridView.count(
                crossAxisCount: 3,
                children: cats(),
              ),
            )
          ],
        ),
      )
    );
  }

  List<Widget> cats() {
    List<Widget> temp = [];
    int cnt = 0;
    while (cnt < 15) {
      Widget w = Image.network("https://loremflickr.com/120/120?lock="+ cnt.toString());
      temp.add(w);
      cnt++;
    }

    return temp;
  }

  Container containerStack() {
    return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network("https://loremflickr.com/420/320?images=12"),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset("./assets/images/missing.png"),
                )
              ],
            ),
          );
  }

  SingleChildScrollView rowImagesWithScroll() {
    return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  Image.network('https://i.pravatar.cc/100?img=4'),
                  Image.network('https://i.pravatar.cc/100?img=5'),
                  Image.network('https://i.pravatar.cc/100?img=6'),
                  Image.network('https://i.pravatar.cc/100?img=7'),
                  Image.network('https://i.pravatar.cc/100?img=8'),
                  Image.network('https://i.pravatar.cc/100?img=9'),
              ],
            )
          );
  }

  Row rowImages() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image.network("https://i.pravatar.cc/100?img=1"),
              Image.network("https://i.pravatar.cc/100?img=2"),
              Image.network("https://i.pravatar.cc/100?img=3")
            ],
          );
  }

  Container containerBoxDecoration() {
    return Container(
            width: 400,
            height: 400,
            margin: EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://i.pravatar.cc/400?img=60"),
                fit: BoxFit.cover
              ),
              border: Border.all(
                color: Colors.indigo,
                width: 10
              ),
              shape: BoxShape.rectangle,
              // borderRadius: BorderRadius.all(Radius.circular(36)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                bottomRight: Radius.circular(100)
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  color: Colors.black
                )
              ]
            ),
          );
  }

  Container containerEdgeInsets() {
    return Container(
            color: Colors.cyan,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            height: 300,
            width: 300,
            child: Card(
              child: Align(
                child: Text("Hello World"),
                alignment: Alignment.center,
              )
            ),
          );
  }

  Container containerAspectRatio() {
    return Container(
            color: Colors.yellow,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 50),
            width: 200.0,
            height: 200.0,
            child: AspectRatio(
              aspectRatio: 4/1,
              child: Container(
                color: Colors.red,
              )
            )
          );
  }
}

