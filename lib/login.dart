import 'package:flutter/material.dart';
import 'package:ganaderia_app/CreateA.dart';
import 'Home.dart'; // Importa la pantalla Home
import 'CreateA.dart'; // Importa la pantalla Registro

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: screenHeight,
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
              SizedBox(height: screenHeight * 0.1), // Espaciado inicial

              // Logo
              Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo.png'), // Coloca tu logo aquí
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                  height: screenHeight * 0.05), // Espaciado después del logo

              // Título
              Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: screenHeight * 0.04,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Campo de correo electrónico
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Campo de contraseña
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Botón "Login"
              Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    // Navegar a la pantalla de Home
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.025,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),

              // Enlace para registro
              GestureDetector(
                onTap: () {
                  // Navegar a la pantalla de registro
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateA()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'No tienes una cuenta? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      TextSpan(
                        text: 'Regístrate',
                        style: TextStyle(
                          color: Color(0xFF07FFE1),
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05), // Espaciado final
            ],
          ),
        ),
      ),
    );
  }
}
