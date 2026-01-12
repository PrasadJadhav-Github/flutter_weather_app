// Home screen UI + state management

import 'package:flutter/material.dart';
import 'package:flutter_weather_app/Model/weather_model.dart';
import 'package:flutter_weather_app/Services/weather_services.dart';
import 'package:flutter_weather_app/Widget/weather_card.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen> {

  // Service instance to call API
  final WeatherServices _weatherServices = WeatherServices();

  // Controller to read text input
  final TextEditingController _controller = TextEditingController();

  // Loading indicator flag
  bool _isLoading = false;

  // Weather data variable (nullable)
  Weather? _weather;

  // Function to fetch weather data
  void _getWeather() async {

    // Start loading
    setState(() {
      _isLoading = true;
    });

    try {
      // Fetch weather using city name
      final weather = await _weatherServices.fetchWeather(_controller.text);

      // Update UI with fetched data
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      // Show error message if API fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error fetching weather data')),
      );

      // Stop loading on error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        // Full screen size
        width: double.infinity,
        height: double.infinity,

        // Background gradient based on weather condition
        decoration: BoxDecoration(
          gradient:
          _weather != null &&
              _weather!.description.toLowerCase().contains('rain')
              ? const LinearGradient(
            colors: [Colors.grey, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : _weather != null &&
              _weather!.description.toLowerCase().contains('clear')
              ? const LinearGradient(
            colors: [Colors.orangeAccent, Colors.blueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : const LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),

            child: Column(
              children: [

                const SizedBox(height: 25),

                // App title
                const Text(
                  'Weather App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 25),

                // City input field
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter Your City Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Button to fetch weather
                ElevatedButton(
                  onPressed: _getWeather,
                  child: const Text('Get Weather', style: TextStyle(fontSize: 18)),
                ),

                // Loading indicator
                if (_isLoading)
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(color: Colors.white),
                  ),

                // Weather card (only shown if data exists)
                if (_weather != null)
                  WeatherCard(weather: _weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
