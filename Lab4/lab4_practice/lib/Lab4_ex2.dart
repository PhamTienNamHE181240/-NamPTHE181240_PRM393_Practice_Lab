import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: InputControlsDemo()));

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});
  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  double _volume = 50;
  bool _notifications = true;
  String _quality = 'HD';
  DateTime? _date;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || picked == null) return;
    setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercise 2 • Input controls')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Volume: ${_volume.round()}'),
          Slider(
            value: _volume,
            min: 0,
            max: 100,
            divisions: 20,
            label: '${_volume.round()}',
            onChanged: (value) => setState(() => _volume = value),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: Text(_notifications ? 'On' : 'Off'),
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          Text('Quality: $_quality'),
          RadioGroup<String>(
            groupValue: _quality,
            onChanged: (value) {
              if (value != null) setState(() => _quality = value);
            },
            child: const Column(
              children: [
                RadioListTile<String>(value: 'SD', title: Text('SD')),
                RadioListTile<String>(value: 'HD', title: Text('HD')),
                RadioListTile<String>(value: '4K', title: Text('4K')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_month),
            label: const Text('Choose date'),
          ),
          Text(
            _date == null
                ? 'No date selected'
                : 'Date: ${_date!.day}/${_date!.month}/${_date!.year}',
          ),
        ],
      ),
    );
  }
}
