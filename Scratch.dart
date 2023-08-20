import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart'as http;

void main()async{
getweather();

}

void task1(){
  print("task 1 complete");
}

Future<String> task2()async{
  Duration Sleep = const Duration(seconds: 3);
   late Future<String> result;
    await Future.delayed(Sleep,(){
      print("task 2 complete");
      result=Future.value("Task2 result");

    });
  return result;
}
void task3(String task2data){

  print("task 3 complete $task2data");
      }
void getweather()async{
  Uri uri=Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=72.33&lon=-0.29&appid=94f382e4fc281660407c338e534c7ca2');
  http.Response response=  await http.get(uri);
  print(jsonDecode(response.body)['weather'][0]['id']);
}

