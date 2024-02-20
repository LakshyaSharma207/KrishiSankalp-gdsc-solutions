import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/api.dart';
import 'package:krishi_sankalp/api/auth.dart';
import 'package:krishi_sankalp/pages/export.dart';
import 'package:weather/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key,});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = AuthService().currentUser;

  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);

  Weather? _weather;
  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Mumbai").then((value) => {
      setState(() {
        _weather = value;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: const NavigationSidebar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: CropDisease(user: user),
              ),
              WeatherCard(weather: _weather),
              const Scan(),
            ],
          ),
        ),
      )
    );
  }
}