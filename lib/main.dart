import 'package:flutter/material.dart';
import 'started.dart'; // Importar el archivo started.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agricultura y Ganadería',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: Started(), // Aquí llamamos a la pantalla `Started`
    );
  }
}
