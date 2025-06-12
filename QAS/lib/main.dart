import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qas_160422041_et/class/course.dart';
import 'package:qas_160422041_et/detail.dart';
import 'package:qas_160422041_et/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<String> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user_id = prefs.getString("user_email") ?? "";

  return user_id;
}

String ACTIVE_USER = "";

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
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
      home: const MyHomePage(title: 'QAS 160422041'),
      routes: {

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

  // Bottom Nav
  int _currentIndex = 0;

  List<Course> _courses = [];
  final List<Widget> _screens = [
    // Home(),
    // Search(),
    // History()
  ];
  final List<String> _title = ['Home', 'Search', 'History'];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void doLogout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('_user_email');
    main();
  }

  Future<void> bacaData() async {
    final response = await http
        .get(Uri.parse("https://ubaya.xyz/flutter/160422041/qas/courses.php"));

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json['result'] == 'success') {
        for (var course in json['data']) {
          Course c = Course.fromJson(course);
          _courses.add(c);
        }
      } else {
        _courses.clear();
      }
    } else {
      throw Exception('Failed to read API');
    }
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }


  @override
  Widget build(BuildContext context) {

    Widget courseData() {
      if (_courses.length == 0) {
        return const CircularProgressIndicator();
      } else {
        return Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _courses.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(children: [
                          Text(_courses[index].name),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(courseId: _courses[index].id),
                                  )
                                );
                              },
                              child: Text("DETAIL"),
                          )
                        ])
                      ),
                    ),
                  );
                }
            )
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        // title: Text(_title[_currentIndex]),
      ),
      // body: _screens[_currentIndex],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Courses",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
              courseData(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      // drawer:  myDrawer(),
      // bottomNavigationBar: myBottomNav(),
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
              accountEmail: Text(ACTIVE_USER),
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
          ListTile(
            title: const Text(
              "Animasi",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red
              ),
            ),
            leading: const Icon(Icons.access_time),
            onTap: () {
              Navigator.pushNamed(context, "animation");
            },
          ),
          ListTile(
            title: const Text(
              "Popular Movie",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.movie),
            onTap: () {
              Navigator.pushNamed(context, "popular-movie");
            },
          ),
          ListTile(
            title: const Text(
              "Popular Actor",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.pushNamed(context, "popular-actor");
            },
          ),
          ListTile(
            title: const Text(
              "New Popular Movie",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const Icon(Icons.add),
            onTap: () {
              Navigator.pushNamed(context, "popular-movie-add");
            },
          ),
        ],
      ),
    );
  }
}
