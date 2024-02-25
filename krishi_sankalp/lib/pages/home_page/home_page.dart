import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  Position? _currentPosition;

  Weather? _weather;
  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    } 

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } 

    return true;
  } 
  
  Future<void> _fetchWeatherData() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) {
      print("no permission");
      return;
    }
    try {
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
          setState(() => _currentPosition = position);
        }).catchError((err) {
            debugPrint(err);
        });
      final Weather weather = await _wf.currentWeatherByLocation(_currentPosition!.latitude, _currentPosition!.longitude);
      setState(() {
        _weather = weather;
      });
    } catch (err) {
      print('Error fetching weather: $err');
    }
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