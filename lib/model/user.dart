import 'package:flutter/material.dart';

class UserModel {
  static int _nextId = 1; // Variable estática para el próximo ID
  int id;
  String name;
  String lastName;
  String identificationNumber;
  int age;
  String guardianName;
  String guardianPhone;
  String risk;
  String weight;
  String height;
  List<String>? measures = [] ;
  DateTime registrationDate; // Fecha de registro
  String location; // Ubicación del registro

  UserModel({
    required this.name,
    required this.lastName,
    required this.identificationNumber,
    required this.age,
    required this.guardianName,
    required this.guardianPhone,
    this.risk = "",
    this.weight = "No aplica",
    this.height = "No aplica", 
    this.location = "",
    this.measures
  })   : id = _nextId++, // Asigna el ID y luego incrementa para el próximo niño
        registrationDate = DateTime.now(); // Obtiene la fecha y hora actual

}
