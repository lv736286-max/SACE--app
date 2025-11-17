import 'package:flutter/material.dart';
import '../models/emergency.dart';

class AlertCard extends StatelessWidget {
  final Emergency emergency;
  final VoidCallback? onTap;

  const AlertCard({super.key, required this.emergency, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(emergency.type, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(emergency.description),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: onTap, child: const Text('Ver Más'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
