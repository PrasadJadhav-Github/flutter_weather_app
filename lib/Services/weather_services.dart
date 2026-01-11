import 'dart:convert';
import 'package:flutter_weather_app/Model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherServices {

  final String apiKey = '2a1f644c2dabaf00ce523716f51ebe39';

  Future<Weather> fetchWeather(String cityName)async{
    final url =Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response =await http.get(url);

    if(response.statusCode==200){
      return Weather.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load weather data');
    }
  }

}