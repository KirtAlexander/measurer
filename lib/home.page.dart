import 'package:flutter/material.dart';
import 'package:measurer/model/user.dart';
import 'package:measurer/pages/add.child.dart';
import 'package:measurer/pages/view.child.dart';

class HomePage extends StatelessWidget {
  List<UserModel> childrenList = [
    UserModel(
        name: "Juan",
        lastName: "Contreras",
        identificationNumber: "1015186546",
        age: 12,
        guardianName: "Alejandra",
        guardianPhone: "3135921800",
        risk: "1",
        height: "1.45",
        weight: "45",
        location: "Comuna 3 - Manrique - Carrera 23B - Medellín, CO",
        measures: ["1", "2", "3"]),
    UserModel(
        name: "Alex",
        lastName: "Vargas",
        identificationNumber: "1015186019",
        age: 19,
        guardianName: "Alejandro",
        guardianPhone: "3002644175",
        risk: "2",
        location: "Comuna 3 - Manrique - Carrera 23B - Medellín, CO",
        measures: ["1.45", "1.46", "1.45"]),
    UserModel(
        name: "Carlos",
        lastName: "Contreras",
        identificationNumber: "1015186011",
        age: 19,
        guardianName: "Gilberto Abedaños",
        guardianPhone: "3002644175",
        risk: "3",
        location: "Comuna 3 - Manrique - Carrera 23B - Medellín, CO",
        measures: ["1.45", "1.46", "1.45"])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ViewChildrenPage(childrenList: childrenList),
                        ),
                      );
                    },
                    icon: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.view_list), // Icono para ver niños
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'Ver Niños',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ), // Texto debajo del icono
                      ],
                    ),
                    iconSize: 64.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddChildPage()),
                      );
                    },
                    icon: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add), // Icono para agregar niño
                        Padding(
                          padding: EdgeInsets.all(25),
                          child: Text(
                            'Agregar niño',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30),
                          ),
                        ), // Texto debajo del icono
                      ],
                    ),
                    iconSize: 64.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
