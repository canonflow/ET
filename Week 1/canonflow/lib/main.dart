import 'package:canonflow/screen/about.dart';
import 'package:canonflow/screen/basket.dart';
import 'package:canonflow/screen/highscore.dart';
import 'package:canonflow/screen/history.dart';
import 'package:canonflow/screen/home.dart';
import 'package:canonflow/screen/login.dart';
import 'package:canonflow/screen/quiz.dart';
import 'package:canonflow/screen/search.dart';
import 'package:canonflow/screen/student/addrecipe.dart';
import 'package:canonflow/screen/student/student-list.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

String ACTIVE_USER = "";

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_id") ?? "";

  return user_id;
}

void main() {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  checkUser()
    .then((String result) {
      if (result == "") {
        runApp(const MyLogin());
      } else {
        ACTIVE_USER = result;
        runApp(const MyApp());
      }
    });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        'about': (context) => const About(),
        'basket': (context) =>const Basket(),
        'student.list': (context) => StudentList(),
        'add.recipe': (context) => const AddRecipe(),
        'quiz': (context) => const Quiz(),
        'login': (context) => const Login(),
        'highscore': (context) => HighScore(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String smile = String.fromCharCodes(Runes('\u{1F60B}'));
  String angry = String.fromCharCodes(Runes('\u{1F621}'));
  String emo = "";

  // Week 2
  int _currentIndex = 0;

  // Week 6
  String _user_id = "";

  final List<Widget> _screens = [
    Home(),
    Search(),
    History()
  ];
  final List<String> _title = ['Home', 'Search', 'History'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser()
      .then((value) {
        setState(() {
          _user_id = value;
        });
      });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      emo += (_counter % 5 == 0) ? angry : smile;
    });
  }

  void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    main();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(_title[_currentIndex]),
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     //
      //     // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
      //     // action in the IDE, or press "p" in the console), to see the
      //     // wireframe for each widget.
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text('You have pushed the button this many times:'),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headlineMedium,
      //       ),
      //       Text(emo)
      //     ],
      //   ),
      // ),
      body: _screens[_currentIndex],
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer:  myDrawer(),
      // persistentFooterButtons: myPFB,
      bottomNavigationBar: myBottomNav(),
    );
  }

  BottomNavigationBar myBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      fixedColor: Colors.teal,
      items: [
        BottomNavigationBarItem(
          label: "Home",
          icon: Icon(Icons.home)
        ),
        BottomNavigationBarItem(
          label: "Search",
          icon: Icon(Icons.search)
        ),
        BottomNavigationBarItem(
          label: "History",
          icon: Icon(Icons.history)
        )
      ],
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }

  List<Widget> get myPFB {
    return <Widget>[
      ElevatedButton(
        onPressed: () {}, 
        child: const Icon(Icons.skip_previous),
      ),
      ElevatedButton(
        onPressed: () {}, 
        child: const Icon(Icons.skip_next)
      )
    ];
  }

  Drawer myDrawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("xyz"),
            accountEmail: Text(_user_id),
            currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://i.pravatar.cc/150")
            )
          ),
          ListTile(
            title:  const Text("Inbox"),
            leading:  const Icon(Icons.inbox),
            onTap: () {}
          ),
          ListTile(
            title:  const Text("My Basket"),
            leading:  const Icon(Icons.shopping_basket),
            onTap: () {
              Navigator.popAndPushNamed(context, "basket");
            }
          ),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.help),
            onTap: () {
              Navigator.popAndPushNamed(context, "about");
            },
          ),
          ListTile(
            title: const Text("Student List"),
            leading: const Icon(Icons.list),
            onTap: () {
              Navigator.popAndPushNamed(context, "student.list");
            },
          ),
          ListTile(
            title: const Text("Quiz"),
            leading: const Icon(Icons.access_alarm),
            onTap: () {
              Navigator.popAndPushNamed(context, "quiz");
            },
          ),
          ListTile(
            title: const Text(
              "HIGHSCORE",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.greenAccent
              ),
            ),
            leading: const Icon(Icons.sports_score_rounded),
            onTap: () {
              Navigator.pushNamed(context, 'highscore');
            },
          ),
          ListTile(
            title: const Text(
              "LOGOUT",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            leading: const Icon(Icons.logout_rounded),
            onTap: () {
              doLogout();
            },
          ),
        ],
      ),
    );
  }
}
