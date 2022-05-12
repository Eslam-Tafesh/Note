import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../page/notes_page.dart';
import 'MyCustomRoute.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,
    theme: ThemeData(
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    ),
      home: const MyHomePage(title: 'Note App'),
  );
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            CustomPageRoute(
                NotesPage()
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery. of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home : Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("images/logo.png",width: 200,height: 200,),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pushReplacement(context,
                          CustomPageRoute(
                              NotesPage()
                          ));

                    },
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 300),
                      child: SizedBox(

                          width: size.width*60/100,
                          height: 40,

                          child: Center(child: Text("Get Started",style: TextStyle(fontSize: 20, color: Colors.white),))),
                    )
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

