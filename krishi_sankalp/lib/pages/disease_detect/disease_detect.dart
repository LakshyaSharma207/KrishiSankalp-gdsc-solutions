import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/export.dart';
import 'package:camera/camera.dart';

class DiseaseDetect extends StatelessWidget {
  const DiseaseDetect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect Disease', style: TextStyle(color: Colors.white),),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      drawer: NavigationSidebar(),
      body: const Center(
        child: Column(
          children: [
            Text("hello world"),
          ],
        ),
      ),
    );
  }
}