import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importa Firebase Core
import 'firebase_options.dart'; // Importa el archivo generado de configuración de Firebase
import 'started.dart'; // Importa el archivo started.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura que Flutter esté inicializado correctamente
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Usa las opciones correctas según la plataforma
  );
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
