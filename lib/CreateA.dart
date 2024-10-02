import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore
import 'package:flutter/services.dart'; // Importa servicios para input formatters
import 'package:ganaderia_app/login.dart';

class CreateA extends StatefulWidget {
  @override
  _CreateAState createState() => _CreateAState();
}

class _CreateAState extends State<CreateA> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  final RegExp passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  bool _isPasswordVisible = false;

  // Método para registrar el usuario en Firebase Authentication y Firestore
  Future<void> _registerUser() async {
    try {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Guardar los datos adicionales en Firestore
      await FirebaseFirestore.instance
          .collection('user')
          .doc(userCredential.user!.uid)
          .set({
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registro exitoso')),
      );

      // Navegar a la pantalla de Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'La contraseña es demasiado débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'El correo electrónico ya está en uso.';
      } else if (e.code == 'invalid-email') {
        message = 'El correo electrónico no es válido.';
      } else {
        message = 'Error al registrar: ${e.message}';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    super.dispose();
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
        child: Stack(
          children: [
            Positioned(
              left: screenWidth * 0.05,
              top: screenHeight * 0.12,
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.85,
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLabel('Nombre'),
                        _buildNameField(screenWidth, screenHeight),
                        _buildLabel('Apellido'),
                        _buildSurnameField(screenWidth, screenHeight),
                        _buildLabel('Teléfono'),
                        _buildPhoneField(screenWidth, screenHeight),
                        _buildLabel('Correo Electrónico'),
                        _buildEmailField(screenWidth, screenHeight),
                        _buildLabel('Contraseña'),
                        _buildPasswordField(
                            screenWidth, screenHeight, _passwordController),
                        _buildLabel('Confirmar Contraseña'),
                        _buildConfirmPasswordField(screenWidth, screenHeight),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.25,
              top: screenHeight * 0.90,
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.08,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registerUser();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
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

  Widget _buildNameField(double screenWidth, double screenHeight) {
    return _buildTextField(_nameController, 'Introduce tu nombre');
  }

  Widget _buildSurnameField(double screenWidth, double screenHeight) {
    return _buildTextField(_surnameController, 'Introduce tu apellido');
  }

  // Campo de teléfono
  Widget _buildPhoneField(double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFD6E3C0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone, // Muestra solo el teclado numérico
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly, // Restringe solo a números
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Introduce tu teléfono',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, introduce tu número de teléfono';
            } else if (!RegExp(r'^\d+$').hasMatch(value)) {
              return 'Introduce solo números';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildEmailField(double screenWidth, double screenHeight) {
    return _buildTextField(
        _emailController, 'Introduce tu correo electrónico', emailRegex);
  }

  Widget _buildPasswordField(double screenWidth, double screenHeight,
      TextEditingController controller) {
    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFD6E3C0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          controller: controller,
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, introduce una contraseña';
            } else if (!passwordRegex.hasMatch(value)) {
              return 'La contraseña debe tener al menos 8 caracteres, incluyendo una mayúscula, una minúscula y un carácter especial.';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(double screenWidth, double screenHeight) {
    return _buildTextField(_confirmPasswordController, 'Confirma tu contraseña',
        null, _passwordController);
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      [RegExp? regex, TextEditingController? matchController]) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFD6E3C0),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, introduce $hintText';
            }
            if (regex != null && !regex.hasMatch(value)) {
              return 'Formato inválido para $hintText';
            }
            if (matchController != null && value != matchController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
        ),
      ),
    );
  }
}
