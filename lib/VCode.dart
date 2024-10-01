import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'CreateA.dart'; // Asegúrate de importar la pantalla CreateA

class VCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String currentOTP = ""; // Almacenar el OTP

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
            Text(
              'Verification Code',
              style: TextStyle(
                color: Colors.black,
                fontSize: screenHeight * 0.03,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Please enter the OTP which\nyou have received on your mobile number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: screenHeight * 0.02,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            // Pin Code Fields para OTP
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PinCodeTextField(
                appContext: context,
                length: 4, // Longitud del OTP
                onChanged: (value) {
                  currentOTP = value;
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: screenWidth * 0.15,
                  fieldWidth: screenWidth * 0.15,
                  activeFillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            SizedBox(height: screenHeight * 0.04),
            Text(
              '1:59',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.3),
                fontSize: screenHeight * 0.02,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Resend OTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFFE59130),
                fontSize: screenHeight * 0.02,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            // Botón "Confirmar" que navega a CreateA
            ElevatedButton(
              onPressed: () {
                // Navegar a la pantalla CreateA cuando se confirme el OTP
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateA()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.3, vertical: 15),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                  fontSize: screenHeight * 0.025,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
