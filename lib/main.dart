import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'Providers/image_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => MyImageProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("File Upload"),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}
