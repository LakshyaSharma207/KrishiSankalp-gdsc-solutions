import 'package:flutter/material.dart';
import '../export.dart';
// import 'package:url_launcher/url_launcher.dart'; // external app

class CropPrediction extends StatefulWidget {
  const CropPrediction({super.key});

  @override
  State<CropPrediction> createState() => _CropPredictionState();
}

class _CropPredictionState extends State<CropPrediction> {
  final TextEditingController cropController = TextEditingController();
  final TextEditingController tempController = TextEditingController();
  final TextEditingController rainController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  String _yieldResult = '';

  Future<void> predictYield() async{
    var yieldResult = 'not good';
    setState(() {
      _yieldResult = yieldResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predict Yield', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: const NavigationSidebar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cropController,
              decoration: const InputDecoration(
                label: Text('Crop Name'),
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tempController,
              decoration: const InputDecoration(
                label: Text('Temperature / Taapmaan'),
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: rainController,
              decoration: const InputDecoration(
                label: Text('Rainfall (mm)'),
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: sizeController,
              decoration: const InputDecoration(
                label: Text('Farm Size'),
                labelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 120,),
                Expanded(
                  child: FloatingActionButton(
                    onPressed: predictYield,
                    child: const Text('Predict Yield'),
                  ),
                ),
                const SizedBox(width: 120,),
              ],
            ),
            const SizedBox(height: 16,),
            _yieldResult == '' ? const Text("") : Text("Yield Result is $_yieldResult")
          ]
        ),
      ),
    );
  }
}