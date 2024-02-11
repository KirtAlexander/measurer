import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:collection/collection.dart'; // Importa el paquete collection

class BluetoothPage extends StatefulWidget {
  final String userName;
  final int userAge;

  BluetoothPage({required this.userName, required this.userAge});

  @override
  _BluetoothPageState createState() => _BluetoothPageState();
}

class _BluetoothPageState extends State<BluetoothPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice? selectedDevice;
  List<BluetoothService>? services;
  BluetoothCharacteristic? characteristic;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  Future<void> _initBluetooth() async {
    await flutterBlue.isOn;
  }

  Future<void> _connectToDevice() async {
    try {
      // Escanear y conectarse al dispositivo seleccionado
      final ScanResult scanResult = await flutterBlue
          .scan(
            timeout: const Duration(seconds: 5),
          )
          .firstWhere(
            (result) => result.device.name == "Nombre del dispositivo",
          ); // Reemplaza "Nombre del dispositivo" con el nombre de tu dispositivo Bluetooth

      final BluetoothDevice device = scanResult.device;

      await device.connect();

      // Descubrir los servicios del dispositivo
      services = await device.discoverServices();

      setState(() {
        selectedDevice = device;
        isConnected = true;
      });
    } catch (e) {
      print("Error al conectar con el dispositivo Bluetooth: $e");
    }
  }

  Future<void> _startMeasurement() async {
    try {
      characteristic = services
          ?.expand((service) => service.characteristics)
          .firstWhereOrNull(
            (char) => char.uuid.toString() == "UUID de la característica",
          );

      if (characteristic != null) {
        // Puedes utilizar characteristic.write([...]) para enviar datos al dispositivo
        // Esperar la respuesta del dispositivo y manejarla
        // ...
      } else {
        print("No se encontró la característica necesaria en el dispositivo.");
      }
    } catch (e) {
      print("Error al iniciar la medición: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conexión Bluetooth'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await _connectToDevice();
                if (isConnected) {
                  await _startMeasurement();
                  // Aquí puedes navegar a la siguiente pantalla o realizar otras acciones
                }
              },
              child: Text('Conectar y Medir'),
            ),
          ],
        ),
      ),
    );
  }
}
