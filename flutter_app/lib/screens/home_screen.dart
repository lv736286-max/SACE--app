import 'package:flutter/material.dart';
import '../models/models.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<AlertCard> alerts = [
    AlertCard(
      title: 'Alerta N.1',
      description:
          'Incendio en en aula multiple. Por favor, trasladarse a la zona de punto de encuentro del IDEMAG',
    ),
    AlertCard(
      title: 'Alerta N.2',
      description:
          'Persona desmayada en el baño de mujeres. Se solicita personal de enfermeria urgente.',
    ),
    AlertCard(
      title: 'Alerta N.3',
      description:
          'Se reporta sismo en el IDEMAG. Por favor todos los estudiantes y personas que se encuentren dentro, reunirsen en los puntos de encuentro',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: AppDimensions.phoneWidth,
          height: AppDimensions.phoneHeight,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
                  border: Border.all(color: AppColors.border, width: 10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(AppDimensions.cornerRadius),
                          topRight: Radius.circular(AppDimensions.cornerRadius),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Inicio',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: alerts
                              .map((alert) => _buildAlertCard(alert))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBottomNav(context: context, activeItem: 'Home'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard(AlertCard alert) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              alert.title,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              alert.description,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Ver más: ${alert.title}')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  elevation: 0,
                ),
                child: const Text(
                  'Ver Más',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
