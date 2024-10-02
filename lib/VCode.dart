import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth
import 'CreateA.dart'; // Asegúrate de importar la pantalla CreateA

class VCode extends StatefulWidget {
  final String verificationId; // Recibe la verificación ID

  VCode({required this.verificationId});

  @override
  _VCodeState createState() => _VCodeState();
}

class _VCodeState extends State<VCode> {
  String currentOTP = ""; // Almacenar el OTP ingresado por el usuario
  bool isLoading = false; // Controlar el estado de carga

  // Método para verificar el OTP
  Future<void> _verifyOTP() async {
    setState(() {
      isLoading = true; // Mostrar un indicador de carga
    });

    try {
      // Crear credencial usando el OTP y el verificationId
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: currentOTP,
      );

      // Iniciar sesión con la credencial
      await FirebaseAuth.instance.signInWithCredential(credential);

      // Si el OTP es correcto, navegar a CreateA
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CreateA()),
      );
    } on FirebaseAuthException catch (e) {
      // Mostrar un mensaje de error si el OTP es incorrecto
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al verificar el OTP: ${e.message}')),
      );
    } finally {
      setState(() {
        isLoading = false; // Dejar de mostrar el indicador de carga
      });
    }
  }

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
                length: 6, // Cambiar la longitud del OTP a 6
                onChanged: (value) {
                  setState(() {
                    currentOTP = value; // Actualizar el valor del OTP
                  });
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

            // Botón "Confirmar" que verifica el OTP
            ElevatedButton(
              onPressed: currentOTP.length == 6 && !isLoading
                  ? () {
                      _verifyOTP(); // Verificar el OTP cuando se presiona el botón
                    }
                  : null, // Desactivar el botón si el OTP no está completo
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.3, vertical: 15),
              ),
              child: isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : Text(
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
