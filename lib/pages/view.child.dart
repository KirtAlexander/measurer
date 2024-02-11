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
    switch (childrenList[index].risk) {
      case "1":
        childrenList[index].risk = "Bajo riesgo";
        cardColor = Colors.green;
        break;
      case "2":
      childrenList[index].risk = "Medio riesgo";
        cardColor = Colors.orange;
        break;
      case "3":
      childrenList[index].risk = "Alto riesgo";
        cardColor = Colors.red;
        break;
      default:
        cardColor = Colors.white;
    }

    return Card(
      margin: EdgeInsets.all(8.0),
      color: cardColor, // Establecer el color de la tarjeta
      child: ExpansionTile(
        title: Text(childrenList[index].name),
        children: [
          ListTile(
            title: Text('Apellidos: ${childrenList[index].lastName}'),
          ),
          ListTile(
            title: Text('Número de Identificación: ${childrenList[index].identificationNumber}'),
          ),
          ListTile(
            title: Text('Edad del Niño: ${childrenList[index].age}'),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 80, 0),
                  child: Text('Altura: ${childrenList[index].height}'),
                ),
                Text('Peso: ${childrenList[index].weight}')
              ],
            ),
          ),
          ListTile(
            title: Text('Nombre del Acudiente: ${childrenList[index].measures}'),
          ),
          ListTile(
            title: Text('Nombre del Acudiente: ${childrenList[index].guardianName}'),
          ),
          ListTile(
            title: Text('Teléfono del Acudiente: ${childrenList[index].guardianPhone}'),
          ),
          ListTile(
            title: Text('Fecha y hora del registro: ${childrenList[index].registrationDate}'),
          ),
          ListTile(
            title: Text('Ubicación del registro: ${childrenList[index].location}'),
          ),
          ListTile(
            title: Text('Riesgo de desnutricion: ${childrenList[index].risk} '),
          ),
        ],
      ),
    );
  },
),

      );
  }
}
