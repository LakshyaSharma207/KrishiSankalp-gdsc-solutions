import 'dart:io';

import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/export.dart';

class DetectionPage extends StatelessWidget {
  const DetectionPage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detection Results', style: TextStyle(color: Colors.white),),
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
            const SizedBox(height: 5,),
            Image.file(
              File(imagePath),
              height: 200, 
            ),
            DiseaseInfo(),
          ],
        ),
      ),
    );
  }
}