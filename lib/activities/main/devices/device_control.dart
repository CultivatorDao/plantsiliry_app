import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/smart_device.dart';
import '../../../services/smart_device_service.dart';
import '../../../services/auth.dart';

class DeviceControlPage extends StatefulWidget {
  final SmartDevice device;

  const DeviceControlPage({Key? key, required this.device}) : super(key: key);

  @override
  _DeviceControlPageState createState() => _DeviceControlPageState();
}

class _DeviceControlPageState extends State<DeviceControlPage> {
  final SmartDeviceService _deviceService = SmartDeviceService();
  late String _userId;

  @override
  void initState() {
    super.initState();
    _userId = Provider.of<AuthService>(context, listen: false).currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.device.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddScenarioDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Карточка устройства
            _buildDeviceCard(),
            // Специфичные настройки для умного кашпо
            if (widget.device.isSmartPot) _buildSmartPotSettings(),
            // Список сценариев
            _buildScenariosList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.device.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      widget.device.isOnline ? 'В сети' : 'Не в сети',
                      style: TextStyle(
                        color:
                            widget.device.isOnline ? Colors.green : Colors.grey,
                      ),
                    ),
                  ],
                ),
                Switch(
                  value: widget.device.isOn,
                  onChanged: (value) {
                    _deviceService.updateDeviceState(
                      _userId,
                      widget.device.id,
                      {'isOn': value},
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartPotSettings() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Настройки умного кашпо',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            // Индикатор влажности почвы
            _buildProgressIndicator(
              'Влажность почвы',
              widget.device.soilMoisture,
              Icons.water_drop,
            ),
            const SizedBox(height: 16),
            // Индикатор уровня воды
            _buildProgressIndicator(
              'Уровень воды',
              widget.device.waterLevel,
              Icons.water,
            ),
            const SizedBox(height: 16),
            // Управление освещением
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Освещение'),
                Switch(
                  value: widget.device.isLightOn,
                  onChanged: (value) {
                    _deviceService.updateDeviceState(
                      _userId,
                      widget.device.id,
                      {'settings.is_light_on': value},
                    );
                  },
                ),
              ],
            ),
            // Расписание освещения
            ListTile(
              title: const Text('Расписание освещения'),
              subtitle: Text(
                'С ${widget.device.lightScheduleStart}:00 до ${widget.device.lightScheduleEnd}:00',
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _showLightScheduleDialog(),
            ),
            const Divider(),
            // Автополив
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Автополив'),
                Switch(
                  value: widget.device.isAutoWatering,
                  onChanged: (value) {
                    _deviceService.updateDeviceState(
                      _userId,
                      widget.device.id,
                      {'settings.is_auto_watering': value},
                    );
                  },
                ),
              ],
            ),
            // Порог влажности для автополива
            if (widget.device.isAutoWatering) ...[
              const SizedBox(height: 8),
              Text('Порог влажности: ${widget.device.moistureThreshold}%'),
              Slider(
                value: widget.device.moistureThreshold,
                min: 0,
                max: 100,
                divisions: 100,
                label: '${widget.device.moistureThreshold}%',
                onChanged: (value) {
                  _deviceService.updateDeviceState(
                    _userId,
                    widget.device.id,
                    {'settings.moisture_threshold': value},
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(String label, double value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value / 100,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(
            value < 30 ? Colors.red : Colors.green,
          ),
        ),
        const SizedBox(height: 4),
        Text('${value.toStringAsFixed(1)}%'),
      ],
    );
  }

  Widget _buildScenariosList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Сценарии',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        StreamBuilder<List<DeviceScenario>>(
          stream: _deviceService.getDeviceScenarios(_userId, widget.device.id),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final scenarios = snapshot.data!;
            if (scenarios.isEmpty) {
              return const Center(child: Text('Нет настроенных сценариев'));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: scenarios.length,
              itemBuilder: (context, index) {
                final scenario = scenarios[index];
                return ScenarioCard(
                  scenario: scenario,
                  onEdit: () => _editScenario(scenario),
                  onDelete: () => _deleteScenario(scenario.id),
                );
              },
            );
          },
        ),
      ],
    );
  }

  void _showAddScenarioDialog(BuildContext context) {
    String scenarioName = '';
    String triggerType = widget.device.isSmartPot ? 'moisture' : 'schedule';
    double threshold = 30.0;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Новый сценарий'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Название сценария'),
                  onChanged: (value) => scenarioName = value,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Тип триггера'),
                  value: triggerType,
                  items: [
                    if (widget.device.isSmartPot) ...[
                      const DropdownMenuItem(
                        value: 'moisture',
                        child: Text('По влажности почвы'),
                      ),
                      const DropdownMenuItem(
                        value: 'water_level',
                        child: Text('По уровню воды'),
                      ),
                    ],
                    const DropdownMenuItem(
                      value: 'schedule',
                      child: Text('По расписанию'),
                    ),
                    const DropdownMenuItem(
                      value: 'condition',
                      child: Text('По условию'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() => triggerType = value!);
                  },
                ),
                if (triggerType == 'moisture' || triggerType == 'water_level') ...[
                  const SizedBox(height: 16),
                  Text(
                    'Порог: ${threshold.toStringAsFixed(1)}%',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Slider(
                    value: threshold,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '${threshold.toStringAsFixed(1)}%',
                    onChanged: (value) {
                      setState(() => threshold = value);
                    },
                  ),
                ],
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (scenarioName.isNotEmpty) {
                DeviceScenario newScenario;
                if (triggerType == 'moisture') {
                  newScenario = DeviceScenario.createMoistureTrigger(
                    widget.device.id,
                    scenarioName,
                    threshold,
                    {'action': 'water_plant'},
                  );
                } else if (triggerType == 'water_level') {
                  newScenario = DeviceScenario.createWaterLevelTrigger(
                    widget.device.id,
                    scenarioName,
                    threshold,
                    {'action': 'notify_user'},
                  );
                } else {
                  newScenario = DeviceScenario(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: scenarioName,
                    deviceId: widget.device.id,
                    triggerType: triggerType,
                    trigger: {},
                    actions: {},
                  );
                }
                _deviceService.addScenario(_userId, widget.device.id, newScenario);
                Navigator.pop(context);
              }
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _showLightScheduleDialog() {
    int startHour = widget.device.lightScheduleStart;
    int endHour = widget.device.lightScheduleEnd;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Расписание освещения'),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Время начала
                ListTile(
                  title: const Text('Время начала'),
                  trailing: DropdownButton<int>(
                    value: startHour,
                    items: List.generate(24, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text('${index}:00'),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null && value < endHour) {
                        setState(() => startHour = value);
                      }
                    },
                  ),
                ),
                // Время окончания
                ListTile(
                  title: const Text('Время окончания'),
                  trailing: DropdownButton<int>(
                    value: endHour,
                    items: List.generate(24, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text('${index}:00'),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null && value > startHour) {
                        setState(() => endHour = value);
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              _deviceService.updateDeviceState(
                _userId,
                widget.device.id,
                {
                  'settings.light_schedule_start': startHour,
                  'settings.light_schedule_end': endHour,
                },
              );
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _editScenario(DeviceScenario scenario) {
    // Реализация редактирования сценария
    // TODO: Добавить редактирование существующего сценария
  }

  void _deleteScenario(String scenarioId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Удаление сценария'),
        content: const Text('Вы уверены, что хотите удалить этот сценарий?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              _deviceService.deleteScenario(_userId, widget.device.id, scenarioId);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}

class ScenarioCard extends StatelessWidget {
  final DeviceScenario scenario;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ScenarioCard({
    Key? key,
    required this.scenario,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String triggerDescription;
    IconData triggerIcon;

    switch (scenario.triggerType) {
      case 'moisture':
        triggerDescription =
            'По влажности почвы (${scenario.trigger['threshold']}%)';
        triggerIcon = Icons.water_drop;
        break;
      case 'water_level':
        triggerDescription =
            'По уровню воды (${scenario.trigger['threshold']}%)';
        triggerIcon = Icons.water;
        break;
      case 'schedule':
        triggerDescription = 'По расписанию';
        triggerIcon = Icons.schedule;
        break;
      case 'condition':
        triggerDescription = 'По условию';
        triggerIcon = Icons.rule;
        break;
      default:
        triggerDescription = 'Неизвестный тип';
        triggerIcon = Icons.help_outline;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(triggerIcon),
        title: Text(scenario.name),
        subtitle: Text(triggerDescription),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
} 