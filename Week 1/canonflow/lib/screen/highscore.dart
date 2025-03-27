import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> checkTopUser() async {
  final prefs = await SharedPreferences.getInstance();
  String user = prefs.getString("TOP_USER") ?? "No user";
  return user;
}

Future<int> checkTopPoint() async {
  final prefs = await SharedPreferences.getInstance();
  int point = prefs.getInt("TOP_POINT") ?? 0;
  return point;
}

class HighScore extends StatefulWidget {
  const HighScore({ super.key });

  @override 
  State<StatefulWidget> createState() {
    return _HighScoreState();
  }
}

class _HighScoreState extends State<HighScore> {
  String _top_user = "No user";
  int _top_point = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
  }

  void _loadHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _top_user = prefs.getString("TOP_USER") ?? "No user";
      _top_point = prefs.getInt("TOP_POINT") ?? 0;
    });
  }

  @override
    Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Highscore"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "User: $_top_user",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Highscore: $_top_point",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22
              )
            ),
          ],
        ),
      ),
    );
  }
}

// class HighScore extends StatelessWidget {
//   HighScore({ super.key }) {
//     checkTopUser()
//       .then((user) {
//         top_user = user;
//       });

//     checkTopPoint()
//       .then((point) {
//         top_point = point;
//       });
//   }

//   late final String top_user;
//   late final int top_point;

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Highscore"),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(20),
//         margin: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(blurRadius: 12)
//           ],
//         ),
//         child: Column(
//           children: [
//             Text(
//               "User: $top_user",
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 16
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "Highscore: $top_point",
//               style: TextStyle(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 22
//               )
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }