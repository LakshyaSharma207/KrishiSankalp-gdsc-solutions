import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishi_sankalp/pages/export.dart';
import '../../api/auth.dart';

class NavigationSidebar extends StatefulWidget {
  const NavigationSidebar({ super.key, });

  @override
  State<NavigationSidebar> createState() => _NavigationSidebarState();
}

class _NavigationSidebarState extends State<NavigationSidebar> {
  final User? user = AuthService().currentUser;

  Future<void> signOut() async{
    await AuthService().signOut();
    setState(() {});
  }

   @override
  Widget build(BuildContext context) {
    return Drawer(
      surfaceTintColor: Colors.greenAccent,
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20)
          ),
          buildListTile(context, Icons.home, 'Home', HomePage()),
          buildListTile(context, Icons.person_2_rounded, 'Profile', const Profile()),
          buildListTile(context, Icons.photo_camera_rounded, 'Detect Disease', const DiseaseDetect()),
          buildListTile(context, Icons.person_off, 'Predict Yield', const CropPrediction()),
          buildListTile(context, Icons.add_business_rounded, 'Bazaar', Marketplace()),
          buildListTile(context, Icons.settings, 'Settings', const Placeholder()),
          buildListTile(context, Icons.help_outlined, 'Help', const Placeholder()),
          Expanded(child: Container()),
          Text(user?.email ?? 'User Email'),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 25.0,),
              Expanded(
                child:FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: signOut,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.logout, color: Colors.white), 
                      Text("Sign Out", style: TextStyle(color: Colors.white),), 
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 25.0,),
            ],
          ),
          const SizedBox(height: 15.0,),
        ],
      ),
    );
  }
}

ListTile buildListTile(BuildContext context, IconData icon, String title, Widget page) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: () {
      Navigator.pop(context);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => page,
      ));
    },
  );
}
