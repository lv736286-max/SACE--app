import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class AlertHistoryPage extends StatefulWidget {
  const AlertHistoryPage({super.key});

  @override
  State<AlertHistoryPage> createState() => _AlertHistoryPageState();
}

class _AlertHistoryPageState extends State<AlertHistoryPage> {
  String? _selectedType;
  String? _selectedStatus;
  String? _selectedReportedBy;

  final List<String> _types = ['Temblor', 'Persona desamayada', 'Incendio', 'Otro'];
  final List<String> _statuses = ['Atendido', 'En proceso', 'En espera'];
  final List<String> _reporters = ['Docente', 'Personal', 'Administrador', 'Otro'];

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
                    buildHeader(
                      title: 'Historial de alertas',
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fecha:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Mes',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))))),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Dia',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))))),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Año',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))))),
                                const SizedBox(width: 12),
                                Expanded(
                                    child: TextField(
                                        decoration: InputDecoration(
                                            hintText: 'Hora',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4))))),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text('Tipo:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _types.map((t) => _typeButton(t)).toList(),
                            ),
                            const SizedBox(height: 18),
                            const Text('Estado:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children:
                                  _statuses.map((s) => _statusPill(s)).toList(),
                            ),
                            const SizedBox(height: 18),
                            const Text('Reportado por:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children:
                                  _reporters.map((r) => _reporterPill(r)).toList(),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBottomNav(context: context, activeItem: 'Notif'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _typeButton(String type) {
    final selected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(
              color: selected ? AppColors.primary : Colors.grey[400]!,
              width: 2),
          borderRadius: BorderRadius.circular(4),
          color: selected ? AppColors.primary : Colors.white,
        ),
        child: Text(type,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _statusPill(String status) {
    final selected = _selectedStatus == status;
    return GestureDetector(
      onTap: () => setState(() => _selectedStatus = status),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? AppColors.primary : Colors.grey[200],
        ),
        child: Text(status,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _reporterPill(String reporter) {
    final selected = _selectedReportedBy == reporter;
    return GestureDetector(
      onTap: () => setState(() => _selectedReportedBy = reporter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: selected ? AppColors.primary : Colors.grey[200],
        ),
        child: Text(reporter,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
