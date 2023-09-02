import 'package:dynamic_color/dynamic_color.dart';
import 'package:pengui_scripter/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){
  runApp(MyApp());  
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return DynamicColorBuilder(builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) { 
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: lightDynamic,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkDynamic,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
     },);
  }
}