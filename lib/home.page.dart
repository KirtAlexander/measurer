import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:measurer/model/user.dart';
import 'package:measurer/pages/add.child.dart';
import 'package:measurer/pages/view.child.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<charts.Series<dynamic, String>> seriesList;
  late List<charts.Series<dynamic, String>> ageRiskSeriesList = [];

  List<UserModel> childrenList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateSeriesList();
    _updateAgeRiskSeriesList();
  }

  void _updateSeriesList() {
    List<charts.Series<dynamic, String>> seriesList = [];

    Map<String, int> riskCounts = {
      'Bajo Riesgo': 0,
      'Moderado Riesgo': 0,
      'Alto Riesgo': 0,
    };

    for (var child in childrenList) {
      if (child.risk == '1') {
        riskCounts['Bajo Riesgo'] = (riskCounts['Bajo Riesgo'] ?? 0) + 1;
      } else if (child.risk == '2') {
        riskCounts['Moderado Riesgo'] =
            (riskCounts['Moderado Riesgo'] ?? 0) + 1;
      } else if (child.risk == '3') {
        riskCounts['Alto Riesgo'] = (riskCounts['Alto Riesgo'] ?? 0) + 1;
      }
    }

    seriesList = [
      charts.Series(
        id: 'Riesgo de Desnutrición',
        data: riskCounts.entries.toList(),
        domainFn: (entry, _) => entry.key,
        measureFn: (entry, _) => entry.value,
        colorFn: (entry, _) {
          if (entry.key == 'Bajo Riesgo') {
            return charts.MaterialPalette.green.shadeDefault;
          } else if (entry.key == 'Moderado Riesgo') {
            return charts.MaterialPalette.yellow.shadeDefault;
          } else if (entry.key == 'Alto Riesgo') {
            return charts.MaterialPalette.red.shadeDefault;
          } else {
            return charts.MaterialPalette.gray.shadeDefault;
          }
        },
        labelAccessorFn: (entry, _) => '${entry.key}: ${entry.value}',
      ),
    ];

    setState(() {
      this.seriesList = seriesList;
    });
  }

  void _updateAgeRiskSeriesList() {
    // Define la estructura de datos para almacenar el conteo de riesgos según la edad en meses
    Map<String, Map<String, int>> ageRiskCounts = {
      '0-1 año': {'1': 0, '2': 0, '3': 0},
      '1-2 año': {'1': 0, '2': 0, '3': 0},
      '2-3 año': {'1': 0, '2': 0, '3': 0},
      '3-4 año': {'1': 0, '2': 0, '3': 0},
      '4-5 año': {'1': 0, '2': 0, '3': 0},
    };

    // Calcula el conteo de riesgo de desnutrición según la edad en meses
    for (var child in childrenList) {
      if (child.age >= 3 && child.age <= 12) {
        ageRiskCounts['0-1 año']![child.risk] =
            (ageRiskCounts['0-1 año']![child.risk] ?? 0) + 1;
      } else if (child.age >= 13 && child.age <= 24) {
        ageRiskCounts['1-2 año']![child.risk] =
            (ageRiskCounts['1-2 año']![child.risk] ?? 0) + 1;
      } else if (child.age >= 25 && child.age <= 36) {
        ageRiskCounts['2-3 año']![child.risk] =
            (ageRiskCounts['2-3 año']![child.risk] ?? 0) + 1;
      } else if (child.age >= 37 && child.age <= 48) {
        ageRiskCounts['3-4 año']![child.risk] =
            (ageRiskCounts['3-4 año']![child.risk] ?? 0) + 1;
      } else if (child.age >= 49 && child.age <= 60) {
        ageRiskCounts['4-5 año']![child.risk] =
            (ageRiskCounts['4-5 año']![child.risk] ?? 0) + 1;
      }
    }

    // Crea la lista de series para el nuevo gráfico
    List<charts.Series<dynamic, String>> ageRiskSeriesList = [];

    // Define los colores para los diferentes riesgos
    List<charts.Color> colorPalette = [
      charts.MaterialPalette.green.shadeDefault,
      charts.MaterialPalette.yellow.shadeDefault,
      charts.MaterialPalette.red.shadeDefault,
    ];

    // Crea una serie para cada riesgo
    ageRiskCounts.forEach((ageRange, riskCounts) {
      riskCounts.forEach((risk, count) {
        ageRiskSeriesList.add(charts.Series<dynamic, String>(
          id: '$ageRange - $risk',
          domainFn: (_, __) => ageRange,
          measureFn: (_, __) => count,
          colorFn: (_, __) {
            if (risk == '1') {
              return colorPalette[0];
            } else if (risk == '2') {
              return colorPalette[1];
            } else {
              return colorPalette[2];
            }
          },
          data: [{}],
        ));
      });
    });

    setState(() {
      this.ageRiskSeriesList = ageRiskSeriesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perimetro braquial'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Listado de niños",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewChildrenPage(
                                childrenList: childrenList,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.view_list),
                        iconSize: 64.0,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text(
                        "Agregar niño",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddChildPage(
                                onChildAdded: _addNewChild,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.add),
                        iconSize: 64.0,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Riesgo de Desnutrición',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            seriesList,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            vertical: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Riesgo de Desnutrición por Edad en Meses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: charts.BarChart(
                            ageRiskSeriesList,
                            animate: true,
                            barGroupingType:
                                charts.BarGroupingType.groupedStacked,
                            vertical: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addNewChild(UserModel newChild) {
    setState(() {
      childrenList.add(newChild);
      _updateSeriesList();
      _updateAgeRiskSeriesList();
    });
  }
}
