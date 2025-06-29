class SmartDevice {
  final String id;
  final String name;
  final String type;
  bool isOnline;
  bool isOn;
  Map<String, dynamic> settings;

  // Специфичные настройки для умного кашпо
  bool get isSmartPot => type == 'smart_pot';
  
  // Геттеры для настроек умного кашпо
  double get soilMoisture => isSmartPot ? (settings['soil_moisture'] ?? 0.0) : 0.0;
  double get waterLevel => isSmartPot ? (settings['water_level'] ?? 0.0) : 0.0;
  bool get isLightOn => isSmartPot ? (settings['is_light_on'] ?? false) : false;
  bool get isAutoWatering => isSmartPot ? (settings['is_auto_watering'] ?? false) : false;
  double get moistureThreshold => isSmartPot ? (settings['moisture_threshold'] ?? 30.0) : 30.0;
  int get lightScheduleStart => isSmartPot ? (settings['light_schedule_start'] ?? 8) : 8;
  int get lightScheduleEnd => isSmartPot ? (settings['light_schedule_end'] ?? 20) : 20;

  SmartDevice({
    required this.id,
    required this.name,
    required this.type,
    this.isOnline = false,
    this.isOn = false,
    required this.settings,
  });

  factory SmartDevice.fromJson(Map<String, dynamic> json) {
    return SmartDevice(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      isOnline: json['isOnline'] ?? false,
      isOn: json['isOn'] ?? false,
      settings: json['settings'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'isOnline': isOnline,
      'isOn': isOn,
      'settings': settings,
    };
  }

  // Создание умного кашпо с настройками по умолчанию
  factory SmartDevice.createSmartPot(String id, String name) {
    return SmartDevice(
      id: id,
      name: name,
      type: 'smart_pot',
      settings: {
        'soil_moisture': 0.0,
        'water_level': 100.0,
        'is_light_on': false,
        'is_auto_watering': true,
        'moisture_threshold': 30.0,
        'light_schedule_start': 8,
        'light_schedule_end': 20,
      },
    );
  }
}

class DeviceScenario {
  final String id;
  final String name;
  final String deviceId;
  final String triggerType; // 'schedule', 'condition', 'moisture', 'water_level'
  final Map<String, dynamic> trigger;
  final Map<String, dynamic> actions;
  bool isActive;

  DeviceScenario({
    required this.id,
    required this.name,
    required this.deviceId,
    required this.triggerType,
    required this.trigger,
    required this.actions,
    this.isActive = true,
  });

  factory DeviceScenario.fromJson(Map<String, dynamic> json) {
    return DeviceScenario(
      id: json['id'],
      name: json['name'],
      deviceId: json['deviceId'],
      triggerType: json['triggerType'],
      trigger: json['trigger'],
      actions: json['actions'],
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'deviceId': deviceId,
      'triggerType': triggerType,
      'trigger': trigger,
      'actions': actions,
      'isActive': isActive,
    };
  }

  // Создание сценария для умного кашпо по влажности почвы
  factory DeviceScenario.createMoistureTrigger(
      String deviceId, String name, double threshold, Map<String, dynamic> actions) {
    return DeviceScenario(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      deviceId: deviceId,
      triggerType: 'moisture',
      trigger: {'threshold': threshold},
      actions: actions,
    );
  }

  // Создание сценария для умного кашпо по уровню воды
  factory DeviceScenario.createWaterLevelTrigger(
      String deviceId, String name, double threshold, Map<String, dynamic> actions) {
    return DeviceScenario(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      deviceId: deviceId,
      triggerType: 'water_level',
      trigger: {'threshold': threshold},
      actions: actions,
    );
  }
} 