import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'krishi sankalp',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        ),
      home: const MyAppHome(),
    );
  }
}

class MyAppHome extends StatelessWidget {
  const MyAppHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sidebar'),
      ),
      drawer: const NavigationDrawer(),
      body: const Center(
        child: Text('krushi sankalp')),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(10)
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const MyAppHome(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_2_rounded), 
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Profile(),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_off), 
            title: const Text('krushi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Profile(),
              ));
            },
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      // drawer: const NavigationDrawer(), // to add drawer to page
      body: Center(
        child: Column(
          children: [
            const Text('Flutter is '),
            const SizedBox(height: 10,),
            Image.asset('assets/2Gb.gif'),
          ],
        ),
      ),
    );
  }
}
        // return Image.network("https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExZjQ5bjZ2bWt3Z2tuZ3J5dGltaWlnM3M4OHM1aHhsY3p5b2dpZ3pndCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/aR6JyO12RkwE5P7lxb/giphy.gif");