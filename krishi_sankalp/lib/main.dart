import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sankalp/api/auth.dart';
import 'package:krishi_sankalp/pages/export.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
// error regarding com.google.android.gms.providerinstaller.dynamite does not affect app. Its related to google play services.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'krishi sankalp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 77, 50)),
        ),
      home: const ScreenSaver(),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        }
      },
    );
  }
}

class ScreenSaver extends StatelessWidget {
  const ScreenSaver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png'),
            const SizedBox(height: 100,),
            Row(
              children: [
                const SizedBox(width: 20,),
                Expanded(
                  child: FloatingActionButton(
                    focusColor: const Color.fromRGBO(79, 133, 8, 1),
                    backgroundColor: const Color.fromRGBO(100, 167, 10, 1),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AuthWrapper()),
                      );
                    },
                    child: const Text('Get Started', style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(width: 20,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
