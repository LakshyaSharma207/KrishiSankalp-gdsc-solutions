import 'package:flutter/material.dart';
import 'package:krishi_sankalp/pages/export.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Krushi Sankalp'),
      ),
      drawer: NavigationSidebar(),
      body: const Center(
        child: Text('krushi sankalp')),
    );
  }
}
