import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polio/screen/display.dart';
import 'screen/formscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FormScreen(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         body: TabBarView(
//           children: [FormScreen(), DisplayScreen()],
//         ),
//         backgroundColor: Colors.blue,
//         bottomNavigationBar: TabBar(
//           tabs: [
//             Tab(
//               text: "บันทึกคะแนนสอบ",
//             ),
//             Tab(
//               text: "รายชื่อนักเรียน",
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
