import 'package:flutter/material.dart';

class AlertDetailsScreen extends StatelessWidget {
  final Map<String, dynamic>? data;
  const AlertDetailsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detalles de alerta', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text('ID: ${data?['id'] ?? 'N/A'}'),
            const SizedBox(height: 8),
            Expanded(child: Container()),
            ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Volver'))
          ],
        ),
      ),
    );
  }
}
