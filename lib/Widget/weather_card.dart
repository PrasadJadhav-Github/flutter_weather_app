// Import Cupertino widgets (iOS-style widgets)
// Not strictly required here, but often used for iOS compatibility
import 'package:flutter/cupertino.dart';

// Import Material widgets (Android / Material Design widgets)
import 'package:flutter/material.dart';

// Import Weather model to access weather data
import 'package:flutter_weather_app/Model/weather_model.dart';

// Used to format date and time (sunrise & sunset)
import 'package:intl/intl.dart';

// Used for animated weather illustrations
import 'package:lottie/lottie.dart';

// StatelessWidget because UI depends only on data passed to it
// No internal state changes inside this widget
class WeatherCard extends StatelessWidget {

  // Weather object passed from HomeScreen
  // Contains all weather-related information
  final Weather weather;

  // Constructor with required weather parameter
  const WeatherCard({super.key, required this.weather});

  // Function to convert Unix timestamp to readable time
  // API gives time in seconds, Flutter needs milliseconds
  String formatTime(int timestamp) {

    // Convert timestamp (seconds → milliseconds)
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    // Format time into 12-hour format with AM/PM
    return DateFormat('hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {

    // Stack widget allows layering widgets on top of each other
    // Currently only one layer is used, but stack allows future extensions
    return Stack(
      children: [

        // Main card container
        Container(

          // Margin outside the card
          margin: const EdgeInsets.all(16),

          // Padding inside the card
          padding: const EdgeInsets.all(16),

          // Card styling
          decoration: BoxDecoration(
            color: Colors.white, // Card background color
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),

          // Column to arrange weather details vertically
          child: Column(

            // Align children from the top
            mainAxisAlignment: MainAxisAlignment.start,

            children: [

              // Lottie animation based on weather description
              Lottie.asset(

                // If description contains 'rain', show rain animation
                weather.description.contains('rain')
                    ? 'assets/rain.json'

                // If description contains 'clear', show sunny animation
                    : weather.description.contains('clear')
                    ? 'assets/sunny.json'

                // Otherwise show cloudy animation
                    : 'assets/cloudy.json',

                // Size of the animation
                height: 150,
                width: 150,
              ),

              // City name text
              Text(
                weather.cityName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              // Space between widgets
              SizedBox(height: 10),

              // Temperature display
              Text(
                // Display temperature with one decimal and °C
                '${weather.temperature.toStringAsFixed(1)}°C',

                // Larger bold text for temperature
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),

              // Space between widgets
              SizedBox(height: 10),

              // Weather description (clear sky, rain, etc.)
              Text(
                weather.description,
                style: Theme.of(context).textTheme.titleMedium,
              ),

              // Space before humidity & wind section
              SizedBox(height: 20),

              // Row to display humidity and wind side-by-side
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // Humidity text
                  Text(
                    'Humidity: ${weather.humidity}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  // Wind speed text
                  Text(
                    'Wind: ${weather.windSpeed} m/s',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              // Space before sunrise & sunset section
              SizedBox(height: 20),

              // Row for sunrise and sunset information
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  // Sunrise column
                  Column(
                    children: [

                      // Sunrise icon
                      Icon(Icons.wb_sunny_outlined, color: Colors.orange),

                      // Sunrise label
                      Text(
                        'Sunrise',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      // Formatted sunrise time
                      Text(
                        formatTime(weather.sunrise),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),

                  // Sunset column
                  Column(
                    children: [

                      // Sunset icon
                      Icon(Icons.nights_stay_outlined, color: Colors.purple),

                      // Sunset label
                      Text(
                        'Sunset',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                      // Formatted sunset time
                      Text(
                        formatTime(weather.sunset),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
