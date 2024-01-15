import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishi_sankalp/pages/export.dart';
import '../../api/auth.dart';

class NavigationSidebar extends StatelessWidget {
  NavigationSidebar({ super.key, });
  final User? user = AuthService().currentUser;

  Future<void> signOut() async{
    await AuthService().signOut();
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
          buildListTile(context, Icons.person_2_rounded, 'Profile', Profile()),
          buildListTile(context, Icons.photo_camera_rounded, 'Detect Disease', const DiseaseDetect()),
          buildListTile(context, Icons.person_off, 'krushi', Profile()),
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