import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importa Firebase Auth
import 'package:ganaderia_app/CreateA.dart'; // Asegúrate de que el nombre del archivo y la ruta sean correctos
import 'Home.dart'; // Importa la pantalla Home

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isPasswordVisible = false;  // Variable para controlar la visibilidad de la contraseña

  // Método para autenticar al usuario con Firebase
  Future<void> _loginUser() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Si el login es exitoso, navega a la pantalla Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No existe usuario con este correo.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'La contraseña es incorrecta.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }

      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Método para restablecer la contraseña
  Future<void> _resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se ha enviado un correo de restablecimiento de contraseña.')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el correo de restablecimiento: ${e.message}')),
      );
    }
  }

  // Mostrar un diálogo para ingresar el correo electrónico y restablecer la contraseña
  void _showResetPasswordDialog() {
    final TextEditingController _resetEmailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Restablecer Contraseña'),
          content: TextField(
            controller: _resetEmailController,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              hintText: 'Introduce tu correo electrónico',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final email = _resetEmailController.text.trim();
                if (email.isNotEmpty) {
                  _resetPassword(email);
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, introduce tu correo')),
                  );
                }
              },
              child: Text('Enviar'),
            ),
          ],
        );
      },
    );
  }

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
          child: Form(
            key: _formKey,
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
                SizedBox(height: screenHeight * 0.05), // Espaciado después del logo

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
                  child: TextFormField(
                    controller: _emailController,
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu correo';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Introduce un correo válido';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),

                // Campo de contraseña con ver/ocultar contraseña
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,  // Usar la variable para ocultar/mostrar contraseña
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
                      suffixIcon: IconButton(  // Botón para ver/ocultar contraseña
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, introduce tu contraseña';
                      } else if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // Enlace para "¿Olvidaste tu contraseña?"
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: screenWidth * 0.1),
                    child: GestureDetector(
                      onTap: () {
                        _showResetPasswordDialog(); // Mostrar el diálogo para restablecer contraseña
                      },
                      child: Text(
                        '¿Olvidaste tu contraseña?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.02,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Botón "Login"
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.08,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              _loginUser();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          )
                        : Text(
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
