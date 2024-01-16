import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishi_sankalp/pages/export.dart';

class Scan extends StatelessWidget {
  const Scan({super.key});

  Future<void> pickImage(ImageSource source, BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if(pickedFile != null) {
      if (!context.mounted) return;
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => DetectionPage(imagePath: pickedFile.path)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Check your crop', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              SizedBox(
                width: 1000,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () => pickImage(ImageSource.camera, context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 90,),
                        Icon(Icons.camera_alt, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Take a picture', style: TextStyle(fontSize: 18 ,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: 1000,
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () => pickImage(ImageSource.gallery, context),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(width: 90,),
                        Icon(Icons.upload, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Upload a Picture', style: TextStyle(fontSize: 18 ,color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}