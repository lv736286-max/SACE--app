import 'package:flutter/material.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Historial de alertas')),
      body: const Center(child: Text('Listado de alertas (filtro y estado)')),
    );
  }
}
