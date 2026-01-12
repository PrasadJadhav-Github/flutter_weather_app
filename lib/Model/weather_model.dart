// This file defines the Weather MODEL
// Model = structure of data coming from API

class Weather {
  // City name (example: London)
  final String cityName;

  // Temperature value
  final double temperature;

  // Weather condition description (clear sky, rain, etc.)
  final String description;

  // Humidity percentage
  final int humidity;

  // Wind speed value
  final double windSpeed;

  // Sunrise time (Unix timestamp)
  final int sunrise;

  // Sunset time (Unix timestamp)
  final int sunset;

  // Constructor
  // required keyword ensures all fields must be passed
  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
    required this.sunset,
  });

  // Factory constructor
  // Used to convert JSON data into a Weather object
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      // API key: "name"
      cityName: json['name'],


      // Weather is a list in API response, so we take first item
      description: json['weather'][0]['description'],

      // Convert num to double safely
      temperature: (json['main']['temp'] as num).toDouble(),

      // Humidity value
      humidity: json['main']['humidity'],

      // Wind speed conversion
      windSpeed: (json['wind']['speed'] as num).toDouble(),

      // Sunrise timestamp
      sunrise: json['sys']['sunrise'],

      // Sunset timestamp
      sunset: json['sys']['sunset'],
    );
  }
}
