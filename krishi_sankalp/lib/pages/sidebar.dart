import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:krishi_sankalp/pages/export.dart';
import '../auth.dart';

class NavigationSidebar extends StatelessWidget {
  NavigationSidebar({
    super.key,
  });

  final User? user = AuthService().currentUser;

  Future<void> signOut() async{
    await AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10)
          ),
          buildListTile(context, Icons.home, 'Home', HomePage()),
          buildListTile(context, Icons.person_2_rounded, 'Profile', Profile()),
          buildListTile(context, Icons.person_off, 'krushi', Profile()),
          Text(user?.email ?? 'User Email'),
          FloatingActionButton(
            onPressed: signOut,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.logout), 
                Text("Sign Out"), 
              ],
            ),
          ),
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
