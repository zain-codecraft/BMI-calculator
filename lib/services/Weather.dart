import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clima/services/Location.dart';
import 'dart:convert';

class Weather {

  late final double latitude;
  late final double longitude;
  late final String api;

  //late  String apicity='api.openweathermap.org/data/2.5/weather?q=,uk&APPID=94f382e4fc281660407c338e534c7ca2';
  late String city;

  Weather({required this.latitude, required this.longitude}) {
    api =
    'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=94f382e4fc281660407c338e534c7ca2&units=metric';
  }

  Weather.city({required String this.city}){
    this.api =
    'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=94f382e4fc281660407c338e534c7ca2&units=metric';
  }

  Future getweather() async {
    Uri uri = Uri.parse(api);
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return response.body;
    }
    else {
      return null;
    }
  }
}