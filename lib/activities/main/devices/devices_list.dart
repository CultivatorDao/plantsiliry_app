import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/smart_device.dart';
import '../../../services/smart_device_service.dart';
import '../../../services/auth.dart';
import 'device_control.dart';
import 'qr_scanner.dart';

class DevicesListPage extends StatefulWidget {
  const DevicesListPage({Key? key}) : super(key: key);

  @override
  _DevicesListPageState createState() => _DevicesListPageState();
}

class _DevicesListPageState extends State<DevicesListPage> {
  final SmartDeviceService _deviceService = SmartDeviceService();
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = Provider.of<AuthService>(context, listen: false).uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои устройства'),
      ),
      body: StreamBuilder<List<SmartDevice>>(
        stream: _deviceService.getUserDevices(_userId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final devices = snapshot.data!;
          if (devices.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.devices,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'У вас пока нет устройств',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _scanQRCode,
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Добавить устройство'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              final device = devices[index];
              return DeviceCard(device: device);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQRCode,
        child: const Icon(Icons.qr_code_scanner),
      ),
    );
  }

  Future<void> _scanQRCode() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QRScannerPage(),
      ),
    );

    if (result != null) {
      try {
        final deviceData = jsonDecode(result);
        final newDevice = SmartDevice(
          id: deviceData['id'],
          name: deviceData['name'],
          type: deviceData['type'],
          settings: deviceData['settings'] ?? {},
        );

        await _deviceService.addDevice(_userId, newDevice);
        
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Устройство успешно добавлено'),
            backgroundColor: Colors.green,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка при добавлении устройства'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

class DeviceCard extends StatelessWidget {
  final SmartDevice device;

  const DeviceCard({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceControlPage(device: device),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    _getDeviceIcon(device.type),
                    size: 32,
                    color: device.isOnline ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          device.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          _getDeviceTypeName(device.type),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: device.isOnline ? Colors.green[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      device.isOnline ? 'В сети' : 'Не в сети',
                      style: TextStyle(
                        color: device.isOnline ? Colors.green[900] : Colors.grey[700],
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              if (device.isSmartPot) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatusIndicator(
                      icon: Icons.water_drop,
                      label: 'Влажность',
                      value: '${device.soilMoisture.toStringAsFixed(1)}%',
                      color: _getMoistureColor(device.soilMoisture),
                    ),
                    _buildStatusIndicator(
                      icon: Icons.water,
                      label: 'Уровень воды',
                      value: '${device.waterLevel.toStringAsFixed(1)}%',
                      color: _getWaterLevelColor(device.waterLevel),
                    ),
                    _buildStatusIndicator(
                      icon: Icons.lightbulb,
                      label: 'Освещение',
                      value: device.isLightOn ? 'Вкл' : 'Выкл',
                      color: device.isLightOn ? Colors.amber : Colors.grey,
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }

  IconData _getDeviceIcon(String type) {
    switch (type) {
      case 'smart_pot':
        return Icons.local_florist;
      case 'light':
        return Icons.lightbulb;
      case 'climate':
        return Icons.thermostat;
      case 'security':
        return Icons.security;
      default:
        return Icons.devices;
    }
  }

  String _getDeviceTypeName(String type) {
    switch (type) {
      case 'smart_pot':
        return 'Умное кашпо';
      case 'light':
        return 'Освещение';
      case 'climate':
        return 'Климат-контроль';
      case 'security':
        return 'Безопасность';
      default:
        return 'Неизвестное устройство';
    }
  }

  Color _getMoistureColor(double value) {
    if (value < 30) return Colors.red;
    if (value < 60) return Colors.orange;
    return Colors.green;
  }

  Color _getWaterLevelColor(double value) {
    if (value < 20) return Colors.red;
    if (value < 40) return Colors.orange;
    return Colors.blue;
  }
} 