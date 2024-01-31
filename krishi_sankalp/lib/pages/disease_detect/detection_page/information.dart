import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:krishi_sankalp/api/auth.dart';

class DiseaseInfo extends StatelessWidget {
  const DiseaseInfo({super.key, required this.results});
  final String results;

  @override
  Widget build(BuildContext context) {
    final User? user = AuthService().currentUser;
    List<String> parts = results.split('___');
    String cropName = parts[0].replaceAll('_', ' ');
    String disease = parts[1].replaceAll('_', ' ');
    String treatment = '';

    useEffect(() {
      void addDashboard() async {
        try {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('userEmail', isEqualTo: user?.email)
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            FirebaseFirestore.instance
                .collection('diseaseInfo')
                .where('disease', isEqualTo: disease)
                .get()
                .then((QuerySnapshot querySnapshot) {
                  for (var doc in querySnapshot.docs) {
                    treatment = doc['Treatment1'];
                  }
                });

            DocumentSnapshot userDocument = querySnapshot.docs.first;
            await userDocument.reference.collection('cropDiseases').add({
              'cropName': cropName,
              'disease': disease,
              'hasTreated': false,
              'treatment': treatment,
            });
          }
        } catch (err) {
          print('Failed to add cropdisease: $err');
        }
      }
      addDashboard();
      return null;
    }, []);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text(
            'Crop Name / Disease',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$cropName / $disease', 
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Treatments:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
           StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('diseaseInfo')
                .where('disease', isEqualTo: disease)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No treatment information available.');
              }
              List treatments = snapshot.data!.docs
                  .map((doc) => doc['Treatment1'] + '\n' + doc['Treatment2'])
                  .toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (String treatment in treatments)
                    Text(
                      '=> $treatment',
                      style: const TextStyle(fontSize: 16),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}