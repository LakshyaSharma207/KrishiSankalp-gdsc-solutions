import 'package:flutter/material.dart';

class DiseaseInfo extends StatelessWidget {
  const DiseaseInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'Crop Name:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Something', 
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          Text(
            'Treatments:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '1. do this\n2. do that.', 
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}