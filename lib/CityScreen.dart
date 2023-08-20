import 'package:clima/LoadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/Constants.dart';
import 'package:clima/LocationScreen.dart';
import 'package:clima/services/Weather.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
     String city='';
  late Weather weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints:const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context,[LoadingScreen()]);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(

                padding: const EdgeInsets.all(20.0),
                child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                  decoration: ktextfieldinputdecoration,
                  onChanged: (value){
                        city=value;
                  },
                ),
              ),
              TextButton(
                onPressed: () async{
                    weather=Weather.city(city: city);
                   var myweather=await weather.getweather();
                   //LocationScreen location=LocationScreen(locationweather: myweather);
                    if(city!='') {
                      Navigator.pop(context, [city]);
                    }
                    else{
                      Navigator.pop(context);
                    }
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
