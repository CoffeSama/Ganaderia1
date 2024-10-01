import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
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
            // Círculo de la imagen del usuario en la esquina superior derecha
            Positioned(
              right: 20,
              top: 40,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200"),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Colors.white,
                    width: 4,
                  ),
                ),
              ),
            ),

            // Sección de información del usuario
            Positioned(
              left: 40,
              top: 150,
              child: Container(
                width: screenWidth * 0.8,
                height: screenHeight * 0.6,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Matias Bravo Vargas',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),

                      // Número de móvil
                      buildUserInfo('Mobile Number', '+591 XXXXX XXXXX'),
                      SizedBox(height: 30),

                      // Correo electrónico
                      buildUserInfo('Email', 'sahajmaniya111@gmail.com'),
                      SizedBox(height: 30),

                      // Dirección
                      buildUserInfo('Address', '--------------------'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfo(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          info,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
