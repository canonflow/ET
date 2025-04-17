import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
class Animasi extends StatefulWidget {
  const Animasi({super.key});
  @override
  State<Animasi> createState() => _AnimasiState();
}

class _AnimasiState extends State<Animasi> {

  bool _animated = false;
  double _opacity = 1.0, _left = 0, _top = 0, _wh = 40;
  late Timer _timer, _timer2;
  int _posisi = 1;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      Duration(seconds: 3), 
      (timer) {
        setState(() {
          _animated = !_animated;
          

          // ANIMATED POSITION
          _posisi++;
          if (_posisi > 4) _posisi = 1;
          if (_posisi == 1) {
            _left = 300;
            _top = 0;
            _wh = 40;
          }

          if (_posisi == 2) {
            _left = 0;
            _top = 0;
            _wh = 40;
          }

          if (_posisi == 3) {
            _left = 0;
            _top = 200;
            _wh = 160;
          }

          if (_posisi == 4) {
            _left = 300;
            _top = 200;
            _wh = 160;
          }
        });
      }
    );

    _timer2 = Timer.periodic(
      Duration(seconds: 5), (timer) {
        setState(() {
          _opacity = 1.0 - _opacity;
        });
      }
    );
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('animation test'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // ===== ANIMATING TEXT =====
              AnimationTitle("ANIMATING TEXT"),
              AnimatedDefaultTextStyle(
                style: _animated ?
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 60
                  ) :
                  const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ), 
                duration: const Duration(seconds: 1),
                child: const Center(
                  child: const Text("HELLO"),
                ), 
              ),

              TextButton(
                onPressed:() {
                  setState(() {
                    _animated = !_animated;
                  });
                }, 
                child: const Text("Animate")
              ),

              SizedBox(height: 20),

              // ===== ANIMATING ALIGN =====
              AnimationTitle("ANIMATING ALIGN"),
              SizedBox(
                width: 250,
                height: 250,
                child: AnimatedAlign(
                  alignment: _animated ? Alignment.topRight : Alignment.bottomLeft, 
                  duration: const Duration(seconds: 3),
                  curve: Curves.fastOutSlowIn,
                  child: ClipOval(
                    child: Image.network(
                      'https://i.pravatar.cc/100',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // ===== ANIMATING OPACITY ====
              AnimationTitle("ANIMATING OPACITY"),
              SizedBox(
                width: 250.0,
                height: 250.0,
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: const Duration(seconds: 5),
                  child:
                      Image.network('https://i.pravatar.cc/240?img=6'),
                )
              ),

              SizedBox(height: 20),

              // ===== ANIMATING CONTAINER =====
              AnimationTitle("ANIMATING CONTAINER"),
              AnimatedContainer(
                height: _animated ? 200 : 300,
                width: _animated ? 300 : 200,
                duration: const Duration(seconds: 3),
                decoration: _animated ?
                  BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/400?img=1'),
                      fit: BoxFit.cover
                    ),
                    border: Border.all(color: Colors.blue, width: 10),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30)
                  ) :
                  BoxDecoration(
                    image: const DecorationImage(
                      image: NetworkImage('https://i.pravatar.cc/400?img=15'),
                      fit: BoxFit.cover
                    ),
                    border: Border.all(color: Colors.red, width: 1),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  curve: Curves.fastOutSlowIn,
              ),

              SizedBox(height: 20),

              // ===== ANIMATING CROSSFADE =====
              AnimationTitle("ANIMATING CROSSFADE"),
              Center(
                child: AnimatedCrossFade(
                  firstChild: const Image(
                    image: NetworkImage('https://i.pravatar.cc/400?img=1'),
                    fit: BoxFit.fitWidth,
                    width: 200,
                    height: 240
                  ), 
                  secondChild: const Image(
                    image: NetworkImage('https://i.pravatar.cc/400?img=15'),
                    fit: BoxFit.fitWidth,
                    width: 200,
                    height: 240
                  ), 
                  crossFadeState: _animated ? CrossFadeState.showFirst : CrossFadeState.showSecond, 
                  duration: Duration(seconds: 3)
                ),
              ),

              SizedBox(height: 20),

              // ===== ANIMATING CROSSFADE =====
              AnimationTitle("ANIMATING SWITCHER"),
              AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return RotationTransition(
                    turns: animation,
                    child: child,
                  );
                },
                child: _animated ? widget1() : widget2(),
              ),

              SizedBox(height: 20),

              // ===== ANIMATING POSITION =====
              AnimationTitle("ANIMATING POSITION"),
              Container(
                width: 400,
                height: 300,
                child: Stack(
                  children: [
                    Image.asset(
                      "./assets/images/city.jpeg",
                      scale: 0.5,
                    ),
                    AnimatedPositioned(
                      duration: Duration(seconds: 3),
                      curve: Curves.fastOutSlowIn,
                      left: _left,
                      top: _top,
                      child: AnimatedContainer(
                        duration: Duration(seconds: 3),
                        width: _wh,
                        height: _wh,
                        child: Image.asset("./assets/images/ufo.gif"), 
                      )
                    )
                  ],
                ),
              ),

              SizedBox(height: 20),

              // ===== ANIMATING TWEEN =====
              AnimationTitle("ANIMATING TWEEN"),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 5 * math.pi), 
                duration: Duration(seconds: 20), 
                builder: (_, double angle, _) {
                  return Transform.rotate(
                    angle: angle,
                    child: Image.asset("./assets/images/earth.png"),
                  );
                }
              ),
              SizedBox(height: 16),
              TweenAnimationBuilder(
                tween: ColorTween(begin: Colors.blue, end: Colors.red), 
                duration: Duration(seconds: 10),
                child: Image.asset("./assets/images/earth.png"), 
                builder: (_, Color? color, Widget? child) {
                  return ColorFiltered(
                    colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                    child: child,
                  );
                }
              )
            ]
          )
        )
      );
  }

 Container AnimationTitle(String title) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 12),
    child: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Colors.teal
      ),
    )
   );
 }

 Widget widget1() {
  return ElevatedButton(
    onPressed: () {},
    child: const Text(
      "Click me!",
      style: TextStyle(
        fontSize: 30
      ),
    )
  );
 }

 Widget widget2() {
  return TextButton(
    onPressed: () {},
    child: const Text(
      "Click me!",
      style: TextStyle(
        fontSize: 30
      ),
    )
  );
 }
}
