import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/smart_device.dart';

class SmartDeviceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Получение списка устройств пользователя
  Stream<List<SmartDevice>> getUserDevices(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => SmartDevice.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  // Получение сценариев для устройства
  Stream<List<DeviceScenario>> getDeviceScenarios(String userId, String deviceId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(deviceId)
        .collection('scenarios')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => DeviceScenario.fromJson({...doc.data(), 'id': doc.id}))
          .toList();
    });
  }

  // Добавление нового устройства
  Future<void> addDevice(String userId, SmartDevice device) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(device.id)
        .set(device.toJson());
  }

  // Обновление состояния устройства
  Future<void> updateDeviceState(
      String userId, String deviceId, Map<String, dynamic> updates) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(deviceId)
        .update(updates);
  }

  // Добавление нового сценария
  Future<void> addScenario(
      String userId, String deviceId, DeviceScenario scenario) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(deviceId)
        .collection('scenarios')
        .doc(scenario.id)
        .set(scenario.toJson());
  }

  // Обновление сценария
  Future<void> updateScenario(
      String userId, String deviceId, DeviceScenario scenario) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(deviceId)
        .collection('scenarios')
        .doc(scenario.id)
        .update(scenario.toJson());
  }

  // Удаление сценария
  Future<void> deleteScenario(String userId, String deviceId, String scenarioId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('devices')
        .doc(deviceId)
        .collection('scenarios')
        .doc(scenarioId)
        .delete();
  }
} 