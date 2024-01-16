import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sankalp/pages/export.dart';

class DiseaseDetect extends StatelessWidget {
  const DiseaseDetect({super.key});

  void startCamera() async {
    final picker = ImagePicker();
    await picker.pickImage(source: ImageSource.camera);
  }

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
            const Image(image: AssetImage('assets/image-placeholder.png')),
            const SizedBox(height: 280,),
            FloatingActionButton(
              backgroundColor: Colors.grey,
              shape: const CircleBorder(eccentricity: 0, side: BorderSide(width: 7,)),
              onPressed: startCamera,
            ),
          ],
        ),
      ),
    );
  }
}
