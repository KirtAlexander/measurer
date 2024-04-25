import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:measurer/controller/ble.controller.dart';

class BleDevices extends StatefulWidget {
  const BleDevices({Key? key}) : super(key: key);

  @override
  State<BleDevices> createState() => _BleDevicesState();
}

class _BleDevicesState extends State<BleDevices> {
  final BleController _bleController = BleController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Conectar dispositivo")),
      body: GetBuilder<BleController>(
        init: _bleController,
        builder: (BleController controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder<DiscoveredDevice>(
                  stream: controller.scanResultStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data!;
                      final deviceName = data.name.isNotEmpty
                          ? data.name
                          : "Nombre no disponible";
                      print(data);
                      return Card(
                        elevation: 2,
                        child: ListTile(
                          onTap: () {
                            // Conectar al dispositivo cuando se hace clic en la ListTile
                            _connectToDevice(data, controller);
                          },
                          title: Text(deviceName),
                          subtitle: Text(data.id),
                          trailing: Text(data.rssi.toString()),
                        ),
                      );
                    } else {
                      print('No hay datos disponibles');
                      return const Center(
                          child: Text("No se encontraron dispositivos"));
                    }
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => controller.scanDevices(),
                  child: const Text("Buscar dispositivos"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Función para conectar al dispositivo
void _connectToDevice(DiscoveredDevice device, BleController controller) async {
  print("hola");
  try {
    // Establecer la conexión con el dispositivo
    await controller.connectToDevice(device);
    // Actualizar la UI u mostrar un mensaje de éxito
    Get.snackbar('Conexión establecida',
        'Se ha conectado al dispositivo ${device.name}');
  } catch (error) {
    // Manejar cualquier error que pueda ocurrir durante la conexión
    print('Error al conectar con el dispositivo: $error');
    Get.snackbar('Error', 'No se pudo conectar al dispositivo ${device.name}');
  }
}
