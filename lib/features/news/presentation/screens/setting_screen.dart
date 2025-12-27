import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/services/app_settings.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettings>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: settings.darkMode,
              onChanged: settings.toggleTheme,
            ),
            const SizedBox(height: 24),
            Text(
              'Font Size',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: settings.fontScale,
              min: 0.8,
              max: 1.3,
              divisions: 5,
              label: settings.fontScale.toStringAsFixed(1),
              onChanged: settings.updateFont,
            ),
          ],
        ),
      ),
    );
  }
}
