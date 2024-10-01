import 'package:flutter/material.dart';

class CreateA extends StatelessWidget {
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
        child: Stack(
          children: [
            Positioned(
              left: screenWidth * 0.05,
              top: screenHeight * 0.12,
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight *
                    0.75, // Ajuste del alto para dejar espacio al botón
                decoration: ShapeDecoration(
                  color: Color(0xFFD9D9D9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLabel('Nombres'),
                      _buildInputField(screenWidth, screenHeight),
                      _buildLabel('Apellidos'),
                      _buildInputField(screenWidth, screenHeight),
                      _buildLabel('Correo Electrónico'),
                      _buildInputField(screenWidth, screenHeight),
                      _buildLabel('Contraseña'),
                      _buildInputField(screenWidth, screenHeight),
                      _buildLabel('Confirmar Contraseña'),
                      _buildInputField(screenWidth, screenHeight),
                    ],
                  ),
                ),
              ),
            ),
            // Botón "Registrar"
            Positioned(
              left: screenWidth * 0.25,
              top: screenHeight * 0.88, // Ajuste de la posición del botón
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    // Acción de registro
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green, // Mismo color que el botón de Login
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1,
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  child: Text(
                    'Registrar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.03,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  Widget _buildInputField(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFD6E3C0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
