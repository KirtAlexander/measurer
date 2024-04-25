import 'package:flutter/material.dart';
import 'package:measurer/data/growth.data.dart';
import 'package:measurer/model/user.dart';
import '../data/growth.data.dart';

class NextPage extends StatefulWidget {
  final UserModel userModel;
  final Function(UserModel) onChildAdded;

  NextPage({required this.userModel, required this.onChildAdded});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  TextEditingController measure1Controller = TextEditingController();
  TextEditingController measure2Controller = TextEditingController();
  TextEditingController measure3Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Resto de tu lógica para inicializar los controladores...
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar medidas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: measure1Controller,
              decoration: const InputDecoration(labelText: 'Medida 1'),
            ),
            TextField(
              controller: measure2Controller,
              decoration: const InputDecoration(labelText: 'Medida 2'),
            ),
            TextField(
              controller: measure3Controller,
              decoration: const InputDecoration(labelText: 'Medida 3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String measure1 = measure1Controller.text;
                String measure2 = measure2Controller.text;
                String measure3 = measure3Controller.text;

                double m1 = double.parse(measure1);
                double m2 = double.parse(measure2);
                double m3 = double.parse(measure3);

                // Calculamos las diferencias entre las medidas
                double diff1 = (m1 - m2).abs();
                double diff2 = (m1 - m3).abs();
                double diff3 = (m2 - m3).abs();

                double avg;

                if (diff1 <= diff2 && diff1 <= diff3) {
                  // m1 y m2 son las medidas más cercanas
                  avg = (m1 + m2) / 2;
                } else if (diff2 <= diff1 && diff2 <= diff3) {
                  // m1 y m3 son las medidas más cercanas
                  avg = (m1 + m3) / 2;
                } else {
                  // m2 y m3 son las medidas más cercanas
                  avg = (m2 + m3) / 2;
                }

                List<String> measuresT = [measure1, measure2, measure3];

                widget.userModel.measures = measuresT;
                // Llamar a onChildAdded para guardar el usuario completo
                widget.userModel.risk = calculateNutritionRisk(
                    avg, widget.userModel.age, widget.userModel.sex);

                print(widget.userModel.risk);
                widget.onChildAdded(widget.userModel);
                // Navegar hacia atrás
                Navigator.pop(context);
              },
              child: const Text('Guardar medidas'),
            ),
          ],
        ),
      ),
    );
  }
}

String calculateNutritionRisk(
    double armCircumference, int ageInMonths, String gender) {
  // Determinar la lista de límites basados en el género del niño
  List<Map<String, dynamic>> armCircumferenceLimits =
      armCircumferenceLimitsGirls;
  if (gender == 'Femenino') {
    armCircumferenceLimits = armCircumferenceLimitsGirls;
  } else {
    armCircumferenceLimits = armCircumferenceLimitsBoys;
  }

  String risk = "Evaluar riesgo de desnutrición para este mes";

  // Iterar sobre los límites para encontrar el rango correspondiente a la edad
  for (var limit in armCircumferenceLimits) {
    if (limit['age_in_months'] == ageInMonths) {
      // Obtener los límites de alto y bajo riesgo
      double lowerLimit = limit['lower_limit']; // Representa "alto" riesgo
      double upperLimit = limit['upper_limit']; // Representa "bajo" riesgo

      // Calcular la media entre los límites para el riesgo moderado
      double moderateDo = lowerLimit + 1;
      double moderateUp = upperLimit - 1;
      // Determinar el riesgo según el perímetro braquial del niño
      if (armCircumference <= moderateDo) {
        risk = "3";
      } else if (armCircumference >= moderateDo &&
          armCircumference <= moderateUp) {
        risk = "2";
      } else if (armCircumference > moderateUp) {
        risk = "1";
      }
      break; // Terminar el bucle una vez que se encuentra el rango de edad
    }
  }

  return risk;
}
