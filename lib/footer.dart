import 'package:flutter/material.dart';
class MyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.blue, // Color de fondo del footer
      child: Container(
        height: 50.0, // Altura del footer
        child: Center(
          child: Text(
            'Derechos reservados © Innahealt 2024 ', // Texto del footer
            style: TextStyle(
              color: Colors.white, // Color del texto
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
