import 'package:flutter/material.dart';
import 'package:measurer/model/user.dart';

class ViewChildrenPage extends StatelessWidget {
  final List<UserModel> childrenList;

  ViewChildrenPage({required this.childrenList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Niños'),
      ),
      body: ListView.builder(
        itemCount: childrenList.length,
        itemBuilder: (context, index) {
          Color cardColor = Colors.green; // Por defecto, color verde
          // Determinar el color según el nivel de riesgo
          Color textColor = Colors.white;
          switch (childrenList[index].risk) {
            case "1":
              textColor = Colors.lightGreen.shade900;
              cardColor = Colors.lightGreen.shade400;
              break;
            case "2":
              textColor = Colors.deepOrangeAccent.shade700;
              cardColor = Colors.orange.shade300;
              break;
            case "3":
              textColor = Colors.red.shade900;
              cardColor = Colors.red.shade300;
              break;
          }

          return Card(
            margin: EdgeInsets.all(8.0),
            color: cardColor, // Establecer el color de la tarjeta
            child: ExpansionTile(
              title: Text(
                childrenList[index].name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                childrenList[index].risk == "1"
                    ? "Bajo riesgo"
                    : childrenList[index].risk == "2"
                        ? "Moderado riesgo"
                        : childrenList[index].risk == "3"
                            ? "Alto riesgo"
                            : "",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('Apellidos: ${childrenList[index].lastName}'),
                ),
                ListTile(
                  title: Text(
                      'Número de Identificación: ${childrenList[index].identificationNumber}'),
                ),
                ListTile(
                  title: Text('Edad del Niño: ${childrenList[index].age}'),
                ),
                ListTile(
                  title: Text('Género: ${childrenList[index].sex}'),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Altura: ${childrenList[index].height}'),
                      Text('Peso: ${childrenList[index].weight}'),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                      'Perímetro braquial: ${childrenList[index].measures}'),
                ),
                ListTile(
                  title: Text(
                      'Nombre del Acudiente: ${childrenList[index].guardianName}'),
                ),
                ListTile(
                  title: Text(
                      'Teléfono del Acudiente: ${childrenList[index].guardianPhone}'),
                ),
                ListTile(
                  title: Text(
                      'Fecha y hora del registro: ${childrenList[index].registrationDate}'),
                ),
                ListTile(
                  title: Text(
                      'Ubicación del registro: ${childrenList[index].location}'),
                ),
                ListTile(
                  title: Text(
                      'Riesgo de desnutrición: ${childrenList[index].risk}'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
