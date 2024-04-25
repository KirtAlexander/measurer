import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _deviceSubscription;
  late StreamController<DiscoveredDevice> _deviceStreamController;

  @override
  void onInit() {
    super.onInit();
    _deviceStreamController = StreamController<DiscoveredDevice>.broadcast();
  }

  Future<void> scanDevices({
  Duration scanDuration = const Duration(seconds: 10),
}) async {
  final scanPermissionStatus = await Permission.bluetoothScan.request();
  final connectPermissionStatus = await Permission.bluetoothConnect.request();

  if (scanPermissionStatus.isGranted && connectPermissionStatus.isGranted) {
    _deviceSubscription = _ble
        .scanForDevices(
            withServices: [], scanMode: ScanMode.lowLatency)
        .listen((device) async {
      // Procesar información básica del dispositivo
      print(
          'Dispositivo encontrado: ${device.name.isNotEmpty ? device.name : "Nombre no disponible"}, Dirección: ${device.id}, RSSI: ${device.rssi}');

      // Agregar el dispositivo al stream
      _deviceStreamController.add(device);

      // Intentar conectar y obtener información adicional del dispositivo deseado
      if (device.name == 'NombreDeseado') {
        await _connectToDevice(device);
      }
    }, onError: (dynamic error) {
      print('Error durante el escaneo de dispositivos: $error');
    });

    // Detener el escaneo después de la duración especificada
    Future.delayed(scanDuration, () {
      _deviceSubscription.cancel();
    });
  } else {
    Get.snackbar(
      'Permisos insuficientes',
      'No se otorgaron los permisos necesarios para escanear dispositivos Bluetooth.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

  Future<void> _connectToDevice(DiscoveredDevice device) async {
    try {
      final connection = await _ble.connectToDevice(id: device.id).first;
      if (connection.connectionState == DeviceConnectionState.connected) {
        await _discoverServices(device.id);
      }
    } catch (error) {
      print('Error al conectar con el dispositivo: $error');
    }
  }

  Future<void> connectToDevice(DiscoveredDevice device) async {
  try {
    final connection = await _ble.connectToDevice(id: device.id).first;
    if (connection.connectionState == DeviceConnectionState.connected) {
      await _discoverServices(device.id);
    }
  } catch (error) {
    print('Error al conectar con el dispositivo: $error');
    throw Exception('No se pudo establecer la conexión con el dispositivo');
  }
}

  Future<void> _discoverServices(String deviceId) async {
    try {
      final services = await _ble.discoverAllServices(deviceId).toString();
      print('Servicios y Características del Dispositivo: $services');
      // Aquí puedes acceder a los servicios y características del dispositivo y obtener la información deseada
    } catch (error) {
      print('Error al descubrir servicios: $error');
    }
  }

  Stream<DiscoveredDevice> get scanResultStream =>
      _deviceStreamController.stream;

  @override
  void dispose() {
    _deviceSubscription.cancel();
    _deviceStreamController.close();
    super.dispose();
  }
}
