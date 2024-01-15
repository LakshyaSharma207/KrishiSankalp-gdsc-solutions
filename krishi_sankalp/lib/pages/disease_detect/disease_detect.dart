import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/export.dart';

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
      body: Center(
        child: Column(
          children: [
            const Text('Flutter is ', style: TextStyle(fontWeight: FontWeight.bold,),),
            const SizedBox(height: 10,),
            Image.asset('assets/2Gb.gif'),
          ],
        ),
      ),
    );
  }
}