import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
// commented out part is when downloading model from firebase

class ClassifierModel {
  late Interpreter _interpreter;
  late List<String> _labels;

  ClassifierModel(){
    loadModelAndLabels();
  }
  Future<void> loadModelAndLabels() async {
    await loadModel();
    loadLabels();
  }

  Future<void> loadModel({Interpreter? interpreter}) async {
    // var localModel = await FirebaseModelDownloader.instance.getModel(
    //   'Crop-Detector',
    //   FirebaseModelDownloadType.localModel,
    //   FirebaseModelDownloadConditions(
    //     iosAllowsCellularAccess: true,
    //     iosAllowsBackgroundDownloading: false,
    //     androidChargingRequired: false,
    //     androidWifiRequired: true,
    //     androidDeviceIdleRequired: false,
    //   ),
    // );
    try{
      // _interpreter = interpreter ?? await Interpreter.fromFile(localModel.file);
      _interpreter = interpreter ?? await Interpreter.fromAsset('model.tflite');
      _interpreter.allocateTensors();
      print(_interpreter.getInputTensor(0).shape);
      print(_interpreter.getOutputTensor(0).shape);
    } catch(err){
      print("Error while creating interpreter: $err");
    }
  }

  Future<void> loadLabels() async {
    try {
      _labels = await FileUtil.loadLabels('assets/labels.txt');
    } catch(err) {
      print("Failed to load labels: $err");
    }
  }

  Future<String> predict(String imagePath) async {
    // Resize the image to 256x256 as per the model input size
    img.Image image = img.decodeImage(File(imagePath).readAsBytesSync())!;
    img.Image resizedImage = img.copyResize(image, width: 256, height: 256);

    // Convert the resized image to a 1D Float32List.
    Float32List inputBytes = Float32List(1 * 256 * 256 * 3);
    int pixelIndex = 0;
    for (int y = 0; y < resizedImage.height; y++) {
      for (int x = 0; x < resizedImage.width; x++) {
        int pixel = resizedImage.getPixel(x, y);
        inputBytes[pixelIndex++] = img.getRed(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getGreen(pixel) / 127.5 - 1.0;
        inputBytes[pixelIndex++] = img.getBlue(pixel) / 127.5 - 1.0;
      }
    }

    // Reshape to input format specific for model. 
    final input = inputBytes.reshape([1, 256, 256, 3]);

    // Output container for 38 labels
    final output = Float32List(1 * 38).reshape([1, 38]);

    // Run data through the model
    _interpreter.run(input, output);

    // Get index of the maximum value from the output data. Model output is bunch of probabilities
    final predictionResult = output[0] as List<double>;
    int maxIndex = predictionResult.indexWhere((double element) => element == predictionResult.reduce(max));
    String predictedLabel = _labels[maxIndex]; 

    // Return the predicted label 
    return predictedLabel;
  }
}

