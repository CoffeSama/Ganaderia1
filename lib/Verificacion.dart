import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'VCode.dart'; // Importa la pantalla VCode (OTP)
import 'Login.dart'; // Importa la pantalla de login

class Verificacion extends StatelessWidget {
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
            // Imagen de verificación
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Login movil.png'),
                ),
                borderRadius: BorderRadius.circular(20),
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

            // Texto de "Enter your Mobile Number"
            Text(
              'Enter your Mobile Number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                fontFamily: 'Poppins',
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Campo de número de teléfono
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Número de teléfono',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'BO',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Botón "Get Started" con color verde
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  // Navegar a la pantalla VCode
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VCode()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.green, // Mismo color que el botón de Login
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight * 0.025,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Texto para login
            GestureDetector(
              onTap: () {
                // Navegar a la pantalla de Login
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          Login()), // Aquí navega a la pantalla Login
                );
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ya tienes cuenta? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.02,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
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
          ],
        ),
      ),
    );
  }
}
