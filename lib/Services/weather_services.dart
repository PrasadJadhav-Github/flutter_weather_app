// This file handles API calls (Networking layer)

import 'dart:convert'; // Converts JSON string to Map
import 'package:http/http.dart' as http; // HTTP requests
import 'package:flutter_weather_app/Model/weather_model.dart'; // Weather model

class WeatherServices {

  // OpenWeather API key
  final String apiKey = '2a1f644c2dabaf00ce523716f51ebe39';

  // Function to fetch weather data
  // Returns a Future because API calls are asynchronous
  Future<Weather> fetchWeather(String cityName) async {

    // API URL with city name and API key
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey',
    );

    // Send GET request to API
    final response = await http.get(url);

    // If request is successful
    if (response.statusCode == 200) {
      // Decode JSON and convert to Weather object
      return Weather.fromJson(json.decode(response.body));
    }
    // If request fails
    else {
      throw Exception('Failed to load weather data');
    }
  }
}
