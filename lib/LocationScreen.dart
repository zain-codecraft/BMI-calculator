import 'package:flutter/material.dart';
import 'package:clima/utilities/Constants.dart';
import 'dart:convert';
import 'package:clima/WeatherCondition.dart';
import 'package:clima/services/Location.dart';
import 'package:clima/CityScreen.dart';
import 'package:clima/services/Weather.dart';

class LocationScreen extends StatefulWidget {
  var locationweather;
  LocationScreen({required this.locationweather}){}

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Location mylocation;
 late  int temprature;
 late String city;
 late int condition;
 late var currentlocationweather;
 late String weathermessage;
 late String weatherIcon;
 //late Icon myicon;
@override
  void initState(){
  super.initState();
  mylocation=Location();
  if(widget.locationweather==null){
    temprature=0;
    weathermessage='CANNOT FETCH WEATHER AT THE MOMENT';
    weatherIcon='';
  }
  else {
    print('in the else of init method ');
    double temp=jsonDecode(widget.locationweather)['main']['temp'];
    temprature=temp.toInt();
    city = jsonDecode(widget.locationweather)['name'];
    condition = jsonDecode(widget.locationweather)['weather'][0]['id'];
    weathermessage=WeatherModel.getMessage(temprature)+' in '+city;
    weatherIcon=WeatherModel.getWeatherIcon(condition);
    print(widget.locationweather);

  }




  //myicon=jsonDecode(widget.locationweather)['weather'][0]['icon'];


}
void updateui()async{
  await update_location();
   setState(() {
    //update_location();
  });


}
Future update_location()async{
  currentlocationweather= await mylocation.get_current_location_and_location_weather();
  if(currentlocationweather==null){
    temprature=0;
    weathermessage='CANNOT FETCH WEATHER AT THE MOMENT';
    weatherIcon='';
  }
  else {
    double temp = jsonDecode(currentlocationweather)['main']['temp'];
    temprature = temp.toInt();
    city = jsonDecode(currentlocationweather)['name'];
    condition = jsonDecode(currentlocationweather)['weather'][0]['id'];
    weathermessage=WeatherModel.getMessage(temprature)+' in '+city;
    weatherIcon=WeatherModel.getWeatherIcon(condition);
  }

}
  void update_city_weather(String city)async{
        Weather a=Weather.city(city: city);
        widget.locationweather=await a.getweather();
       setState(() {
         if (widget.locationweather == null) {
           temprature = 0;
           weathermessage = 'CANNOT FETCH WEATHER AT THE MOMENT';
           weatherIcon = '';
         }
         else {
           double temp = jsonDecode(widget.locationweather)['main']['temp'];
           temprature = temp.toInt();
           city = jsonDecode(widget.locationweather)['name'];
           condition = jsonDecode(widget.locationweather)['weather'][0]['id'];
           weathermessage = WeatherModel.getMessage(temprature) + ' in ' + city;
           weatherIcon = WeatherModel.getWeatherIcon(condition);
         }
       });
     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      updateui();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      List<String>? resultList = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));

                      if (resultList != null && resultList.isNotEmpty) {
                        // Use the first element of the resultList as the value (assuming you expect a single String)
                        String value = resultList[0];
                        update_city_weather(value);
                      } else {
                        print('result was null or empty');
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child:  Row(
                  children: <Widget>[
                    Text(
                      temprature.toString()+'°',
                      style: kTempTextStyle,
                    ),
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,

                  )
                  ],
                ),
              ),
               Padding(
                padding:const  EdgeInsets.only(right: 15.0),
                child: Text(
                  weathermessage,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}