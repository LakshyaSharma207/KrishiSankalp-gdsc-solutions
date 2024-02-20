import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather: ${weather?.weatherDescription ?? ""}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'City: ${weather?.areaName}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Temperature: ${weather?.temperature?.celsius?.toStringAsFixed(1) ?? ""}°C',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Humidity: ${weather?.humidity?.toStringAsFixed(1) ?? ""}%',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Wind Speed: ${weather?.windSpeed?.toStringAsFixed(1) ?? ""} m/s',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
