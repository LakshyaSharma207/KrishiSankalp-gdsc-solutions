import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sankalp/pages/export.dart';

class DiseaseDetect extends StatelessWidget {
  const DiseaseDetect({super.key});

  void startCamera(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if(pickedFile != null) {
      if (!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetectionPage(imagePath: pickedFile.path)));
    }
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
      drawer: const NavigationSidebar(),
      body: Center(
        child: Column(
          children: [
            const Image(image: AssetImage('assets/image-placeholder.png')),
            const SizedBox(height: 280,),
            FloatingActionButton(
              onPressed: () => startCamera(context),
              child: const Icon(Icons.camera),
            ),
          ],
        ),
      ),
    );
  }
}
