import 'package:flutter/material.dart';
import 'package:clima/services/Location.dart';
import 'package:clima/LocationScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  Location location=Location();


 @override
void initState(){
  super.initState();
    // TODO: implement initState
    _navigatetolocationscreen();
  }

  Future _navigatetolocationscreen()async{
   var weatherdata=await location.get_current_location_and_location_weather();
   Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationScreen(locationweather: weatherdata)));


  }



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
          child: SpinKitFadingFour(
            color: Colors.white,
            size: 100,
          ),
        ),
    );

  }





  }






