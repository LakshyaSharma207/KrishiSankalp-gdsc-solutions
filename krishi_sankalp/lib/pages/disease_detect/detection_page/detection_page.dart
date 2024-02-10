import 'dart:io';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/classifier/classifier_model.dart';
import 'package:krishi_sankalp/pages/export.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final classifier = ClassifierModel();
  String _results = 'no_results';

  Future<void> _initializeResults() async {
    try {
      var results = await classifier.predict(widget.imagePath);
      setState(() {
        _results = results;
      });
    } catch (error) {
      print('Error initializing results: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detection Results',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: Card(
        elevation: 5,
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            Image.file(
              File(widget.imagePath),
              height: 200,
            ),
            const SizedBox(height: 15,),
            FloatingActionButton(
              onPressed: () {
                _results == 'no_results' ? _initializeResults() : null;
              },
              child: const Text('Analyze Image'),
            ),
            // Text('This image is "$_results"'), // for debugging
            _results == 'no_results' 
              ? Expanded(child: Center(child: Text(_results))) 
              : DiseaseInfo(results: _results,),
          ],
        ),
      )
    );
  }
}
