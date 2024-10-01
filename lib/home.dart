import 'package:flutter/material.dart';
import 'Perfil.dart'; // Pantalla de perfil (User Profile)

// HomeScreen, la pantalla principal donde se muestran las categorías
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _buildBackgroundGradient(),
        child: Stack(
          children: [
            _buildUserProfileIcon(context),
            _buildSearchBar(screenWidth),
            _buildCategoryGrid(screenWidth),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  // Función que construye el ícono de perfil en la esquina superior derecha
  Widget _buildUserProfileIcon(BuildContext context) {
    return Positioned(
      top: 40,
      right: 20,
      child: GestureDetector(
        onTap: () {
          // Navegar a la pantalla de perfil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Perfil()),
          );
        },
        child: CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(
              "https://picsum.photos/200"), // Placeholder para la imagen del usuario
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  // Función que construye la barra de búsqueda
  Widget _buildSearchBar(double screenWidth) {
    return Positioned(
      left: 26,
      top: 83,
      child: Container(
        width: screenWidth * 0.9,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, color: Colors.grey),
            ),
            Text(
              'Search any categories',
              style: TextStyle(
                color: Colors.black.withOpacity(0.6),
                fontSize: 15,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Función que construye la cuadrícula de categorías
  Widget _buildCategoryGrid(double screenWidth) {
    return Positioned(
      left: 20,
      top: 150,
      child: Container(
        width: screenWidth * 0.9,
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildCategoryCard('Pesticidas', 'https://picsum.photos/100'),
            _buildCategoryCard('Animales', 'https://picsum.photos/100'),
            _buildCategoryCard('Alimento', 'https://picsum.photos/100'),
            _buildCategoryCard('Semillas', 'https://picsum.photos/100'),
            _buildCategoryCard('Remates', 'https://picsum.photos/100'),
            _buildCategoryCard('Servicios', 'https://picsum.photos/100'),
          ],
        ),
      ),
    );
  }

  // Función que construye una tarjeta de categoría individual
  Widget _buildCategoryCard(String category, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(imageUrl, width: 90, height: 90, fit: BoxFit.cover),
          SizedBox(height: 10),
          Text(
            category,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Función que construye la barra de navegación inferior
  Widget _buildBottomNavigationBar() {
    return Positioned(
      left: 0,
      bottom: 0,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.home, color: Colors.black, size: 30),
            Icon(Icons.category, color: Colors.black, size: 30),
            Icon(Icons.shopping_cart, color: Colors.black, size: 30),
            Icon(Icons.person, color: Colors.black, size: 30),
          ],
        ),
      ),
    );
  }

  // Función que construye el fondo degradado
  BoxDecoration _buildBackgroundGradient() {
    return BoxDecoration(
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
      borderRadius: BorderRadius.circular(50),
    );
  }
}
