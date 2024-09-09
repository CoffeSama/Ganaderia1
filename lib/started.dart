import 'package:flutter/material.dart';
import 'Verificacion.dart';

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
      home: Started(),
    );
  }
}

// Pantalla `Started` con el logo
class Started extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.21, -0.98),
            end: Alignment(-0.21, 0.98),
            colors: [
              Color(0xFF273514),
              Color(0xFF3D5116),
              Color(0xFF54691A),
              Color(0xFF6A7B1D),
              Color(0xFF717A41),
              Color(0xFF6D7939),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: screenWidth * 0.5,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Logo.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Texto de bienvenida
            Text(
              'Bienvenido a Agricultura \ny Ganadería',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // Botón "Get Started"
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  // Navegar a la página de Verificación cuando se presione el botón
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Verificacion()), // Llamar a Verificacion
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenHeight * 0.025,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
