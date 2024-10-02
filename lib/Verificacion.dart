import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'VCode.dart';
import 'Login.dart';

class Verificacion extends StatefulWidget {
  @override
  _VerificacionState createState() => _VerificacionState();
}

class _VerificacionState extends State<Verificacion> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = '';
  String _phoneNumber = '';
  bool _isLoading = false;

  // Método para enviar el OTP al número ingresado
  Future<void> _sendOTP() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: _phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _isLoading = false;
          });

          // Mostrar mensajes de error específicos
          String errorMsg;
          if (e.code == 'invalid-phone-number') {
            errorMsg = 'Número de teléfono no válido.';
          } else {
            errorMsg = 'Error al enviar OTP: ${e.message}';
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMsg)),
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            _verificationId = verificationId;
            _isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VCode(verificationId: verificationId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 60),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al intentar enviar OTP: $e')),
      );
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
                  setState(() {
                    _phoneNumber = phone.completeNumber;
                  });
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.08,
              child: ElevatedButton(
                onPressed: _phoneNumber.isNotEmpty && !_isLoading
                    ? () {
                        _sendOTP();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
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
