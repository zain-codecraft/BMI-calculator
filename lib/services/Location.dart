import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/services/Weather.dart';

class Location {

  late Weather myweather;
  late Position position;
  late double _latitiude;
   late double _longitude;
  Future get_current_location_and_location_weather() async{
    try {
      LocationPermission permission =  await Geolocator.requestPermission();
      position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      _latitiude=position.latitude;
      _longitude=position.longitude;
     // print("longitude: $_longitude latitude: $_latitiude");
      myweather=Weather(latitude: _latitiude, longitude: _longitude);
         return await myweather.getweather();


        
    }
    catch (e) {
      print(e);
    }
  }
  double get longitude => _longitude;

  set longitude(double value) {
    _longitude = value;
  }

  double get latitiude => _latitiude;

  set latitiude(double value) {
    _latitiude = value;
  }
}