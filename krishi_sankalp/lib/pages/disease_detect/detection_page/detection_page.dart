import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:krishi_sankalp/pages/disease_detect/detection_page/information.dart';
import 'package:krishi_sankalp/classifier/classifier_model.dart';

class DetectionPage extends StatefulWidget {
  const DetectionPage({super.key, required this.imagePath});
  final String imagePath;

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  final classifier = ClassifierModel();
  String _results = '';

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Future<void> initialise() async {
        var results = await classifier.predict(widget.imagePath);
        setState(() {
          _results = results;
        });
      }
      initialise();
      return null;
    }, []);

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
            _results == '' ? const Text('') : Text('This image is "$_results"'),
            DiseaseInfo(results: _results,),
          ],
        ),
      )
    );
  }
}
