import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/emergency_provider.dart';
import '../widgets/alert_card.dart';
import '../app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmergencyProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: provider.items.isEmpty
                ? const Center(child: Text('No hay alertas'))
                : ListView.builder(
                    itemCount: provider.items.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: AlertCard(
                        emergency: provider.items[index],
                        onTap: () => Navigator.of(context).pushNamed(AppRoutes.alertDetails, arguments: {'id': provider.items[index].id}),
                      ),
                    ),
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.emergency),
        child: const Icon(Icons.add),
      ),
    );
  }
}
