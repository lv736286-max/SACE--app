import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/input_field.dart';
import '../widgets/reusable_button.dart';
import '../models/emergency.dart';
import '../providers/emergency_provider.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});
  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final typeCtrl = TextEditingController();
  final locCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmergencyProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Reportar emergencia')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            InputField(label: 'Tipo de emergencia', controller: typeCtrl),
            const SizedBox(height: 8),
            InputField(label: 'Ubicación', controller: locCtrl),
            const SizedBox(height: 8),
            InputField(label: 'Observaciones', controller: descCtrl),
            const SizedBox(height: 12),
            ReusableButton(label: provider.sending ? 'Enviando...' : 'Enviar alerta', onPressed: () async {
              final e = Emergency(id: DateTime.now().millisecondsSinceEpoch.toString(), type: typeCtrl.text.trim(), location: locCtrl.text.trim(), description: descCtrl.text.trim());
              final ok = await provider.send(e);
              if (!mounted) return;
              if (ok) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Alerta enviada')));
                Navigator.of(context).pop();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error al enviar')));
              }
            }),
          ],
        ),
      ),
    );
  }
}
