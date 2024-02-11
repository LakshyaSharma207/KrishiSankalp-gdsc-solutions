import 'dart:convert';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class CropPredictor {
  late Interpreter _interpreter;
  Map<String, int> locationEncoding = {};
  Map<String, int> marketEncoding = {};
  Map<String, int> seasonEncoding = {};

  CropPredictor() {
    loadModel();
    loadEncoding();
  }

  Future<void> loadModel({Interpreter? interpreter}) async {
    var localModel = await FirebaseModelDownloader.instance.getModel(
      'Yield-Predictor',
      FirebaseModelDownloadType.localModel,
      FirebaseModelDownloadConditions(
        iosAllowsCellularAccess: true,
        iosAllowsBackgroundDownloading: false,
        androidChargingRequired: false,
        androidWifiRequired: true,
        androidDeviceIdleRequired: false,
      ),
    );
    try {
      _interpreter = interpreter ?? await Interpreter.fromFile(localModel.file);
      _interpreter.allocateTensors();
    } catch (err) {
      print("Error while creating interpreter: $err");
    }
  }
  
  void loadEncoding() async{
    try {
      // Load location data from location_data.json
      String locationJsonString = await rootBundle.loadString('assets/location_data.json');
      List<dynamic> locationJson = jsonDecode(locationJsonString);
      for (var element in locationJson) {
        locationEncoding[element['location']] = element['location_encoded'];
      }

      // Load market data from market_data.json
      String marketJsonString = await rootBundle.loadString('assets/market_data.json');
      List<dynamic> marketJson = jsonDecode(marketJsonString);
      for (var element in marketJson) {
        marketEncoding[element['market']] = element['market_encoded'];
      }

      // Load season data from season_data.json
      String seasonJsonString = await rootBundle.loadString('assets/season_data.json');
      List<dynamic> seasonJson = jsonDecode(seasonJsonString);
      for (var element in seasonJson) {
        seasonEncoding[element['season']] = element['season_encoded'];
      }
      } catch (error) {
      print("Error loading encoding data: $error");
    }
  }

  Future<String> predictCropYield(String location, String market, String season) async {
    try {
      // Preprocessing
      int locationEncoded = locationEncoding[location] ?? -1;
      if (locationEncoded == -1) {
        return 'Invalid location';
      }

      int marketEncoded = marketEncoding[market] ?? -1;
      if (marketEncoded == -1) {
        return 'Invalid market';
      }

      int seasonEncoded = seasonEncoding[season] ?? -1;
      if (seasonEncoded == -1) {
        return 'Invalid season';
      }
      /// Prepare input data. Testing with double but int works fine too
      List<double> input = [locationEncoded.toDouble(), marketEncoded.toDouble(), seasonEncoded.toDouble()];

      // Prepare output data
      List<double> output = List.filled(_interpreter.getOutputTensors()[0].shape.reduce((a, b) => a * b), 0.0);

      // Run inference
      _interpreter.run([input], output);

      // Return outputData;
      return 'working';

    } catch (error) {
      print("Error during inference: $error");
      return 'error';
    }
  }
}