import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:measurer/model/user.dart';
import 'package:measurer/pages/take.measures.dart';

class AddChildPage extends StatefulWidget {
  final Function(UserModel) onChildAdded;

  AddChildPage({required this.onChildAdded});

  @override
  _AddChildPageState createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController identificationNumberController =
      TextEditingController();
  TextEditingController childAgeController = TextEditingController();
  TextEditingController guardianNameController = TextEditingController();
  TextEditingController guardianPhoneController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String location = 'Ubicación no disponible';
  String selectedGender = 'Masculino'; // Valor predeterminado

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      double latitude = position.latitude;
      double longitude = position.longitude;

      final response = await http.get(
        Uri.parse(
            'https://geocode.xyz/$latitude,$longitude?geoit=json&auth=24116813659160848949x65465'),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final tags = json['adminareas']['admin8'];
        print(tags);

        final region = json['region'];
        final name = json['adminareas']['admin8']['name'];

        String staddress = json['staddress'];
        print(staddress);

        String formattedAddress = '$name - $staddress - $region';

        print(formattedAddress);
        setState(() {
          location = formattedAddress;
        });
      } else {
        throw Exception('Failed to load address: ${response.statusCode}');
      }
    } catch (e) {
      print('Error obteniendo la ubicación: $e');
    }
  }

  bool _validateForm() {
    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        identificationNumberController.text.isEmpty ||
        childAgeController.text.isEmpty ||
        guardianNameController.text.isEmpty ||
        guardianPhoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Todos los campos son obligatorios'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Niño'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: Center(
                          child: Text(
                            'Datos del niño:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          hintText: 'Ingrese el nombre del niño',
                        ),
                      ),
                      TextField(
                        controller: lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Apellidos',
                          hintText: 'Ingrese los apellidos del niño',
                        ),
                      ),
                      TextField(
                        controller: childAgeController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Edad del niño',
                          hintText: 'Ingrese la edad del niño',
                        ),
                      ),
                      TextField(
                        controller: identificationNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Número de Identificación',
                          hintText:
                              'Ingrese el número de identificación del niño',
                        ),
                      ),
                      TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Peso (opcional)',
                          hintText: 'Ingrese el peso del niño (opcional)',
                        ),
                      ),
                      TextField(
                        controller: heightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Altura (opcional)',
                          hintText: 'Ingrese la altura del niño (opcional)',
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text('Género: '),
                          SizedBox(width: 10),
                          DropdownButton<String>(
                            value: selectedGender,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: <String>['Masculino', 'Femenino']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 30),
                        child: Center(
                          child: Text(
                            'Datos del Acudiente:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        controller: guardianNameController,
                        decoration: const InputDecoration(
                          labelText: 'Nombres del Acudiente',
                          hintText: 'Ingrese los nombres del acudiente',
                        ),
                      ),
                      TextField(
                        controller: guardianPhoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: 'Teléfono de Contacto',
                          hintText: 'Ingrese el teléfono del acudiente',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 5,
                shadowColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ubicación:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              location,
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validar los campos del formulario
                  if (_validateForm()) {
                    // Crear el UserModel con la información ingresada por el usuario
                    UserModel newUser = UserModel(
                      name: nameController.text,
                      lastName: lastNameController.text,
                      identificationNumber: identificationNumberController.text,
                      age: int.tryParse(childAgeController.text) ?? 0,
                      sex: selectedGender,
                      guardianName: guardianNameController.text,
                      guardianPhone: guardianPhoneController.text,
                      weight: weightController.text.isNotEmpty
                          ? weightController.text
                          : 'No aplica',
                      height: heightController.text.isNotEmpty
                          ? heightController.text
                          : 'No aplica',
                      location: location,
                      measures: [],
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextPage(
                            userModel: newUser,
                            onChildAdded: widget.onChildAdded),
                      ),
                    );
                  }
                },
                child: const Text('Conectar dispositivo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
