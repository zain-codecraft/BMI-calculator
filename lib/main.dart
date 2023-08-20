import 'package:flutter/material.dart';
import 'package:clima/LoadingScreen.dart';
import 'package:clima/LocationScreen.dart';
import 'package:clima/CityScreen.dart';
import 'package:flutter/services.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );

  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/loading_screen':(context)=>LoadingScreen(),

        '/city_screen':(context)=>CityScreen(),
      },
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}