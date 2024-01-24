import 'package:flutter/material.dart';

import 'screens/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'OpenIn-Test',
      home: Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
