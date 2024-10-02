import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Perfil extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Obtener el usuario actual
    User? user = _auth.currentUser;

    // Si el usuario no está autenticado, mostrar un mensaje
    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text('Usuario no autenticado'),
        ),
      );
    }

    // Obtener la referencia al documento del usuario en Firestore
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('user').doc(user.uid);

    return FutureBuilder<DocumentSnapshot>(
      future: userDoc.get(),
      builder: (context, snapshot) {
        // Mostrar un indicador de carga mientras se obtiene el documento
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Si ocurre un error al obtener el documento
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error al obtener los datos del usuario'),
            ),
          );
        }

        // Si el documento no existe
        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Scaffold(
            body: Center(
              child: Text('El documento del usuario no existe'),
            ),
          );
        }

        // Acceder a los datos del documento
        Map<String, dynamic>? userData =
            snapshot.data!.data() as Map<String, dynamic>?;

        // Verificar si los campos existen antes de acceder a ellos
        String correo = userData != null && userData.containsKey('email')
            ? userData['email']
            : user.email ?? 'Correo no disponible';
        String nombre = userData != null && userData.containsKey('name')
            ? userData['name']
            : 'Sin nombre';
        String apellido = userData != null && userData.containsKey('surname')
            ? userData['surname']
            : 'Sin apellido';
        String telefono = userData != null && userData.containsKey('phone')
            ? userData['phone']
            : 'No disponible';

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
                        image: NetworkImage(
                            userData != null && userData.containsKey('photoUrl')
                                ? userData['photoUrl']
                                : "https://picsum.photos/200"),
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
                            '$nombre $apellido', // Mostrar nombre y apellido juntos
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30),

                          // Número de móvil
                          buildUserInfo('Número de Teléfono', telefono),
                          SizedBox(height: 30),

                          // Correo electrónico
                          buildUserInfo('Correo Electrónico', correo),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget para mostrar la información del usuario
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
