import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class EmergencyReportPage extends StatefulWidget {
  const EmergencyReportPage({Key? key}) : super(key: key);

  @override
  State<EmergencyReportPage> createState() => _EmergencyReportPageState();
}

class _EmergencyReportPageState extends State<EmergencyReportPage> {
  String? _selectedEmergency;
  String? _selectedLocation;
  final _observationsController = TextEditingController();
  bool _isSubmitted = false;

  final List<String> _emergencies = ['Incendio', 'Temblor', 'Accidente', 'Otro'];
  final List<String> _locations = ['Baños', 'Cocina', 'Salon', 'Patio', 'Oficina Adm.', 'Otro'];

  @override
  void dispose() {
    _observationsController.dispose();
    super.dispose();
  }

  void _submitEmergency() {
    if (_selectedEmergency == null || _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Por favor selecciona tipo de emergencia y ubicación')),
      );
      return;
    }
    setState(() => _isSubmitted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Alerta reportada: $_selectedEmergency en $_selectedLocation',
        ),
      ),
    );
  }

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
                      title: 'Reportar emergencia',
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Tipo de emergencia:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 2.8,
                              children:
                                  _emergencies.map((e) => _emergencyButton(e)).toList(),
                            ),
                            const SizedBox(height: 18),
                            Row(
                              children: const [
                                Text('Ubicación:',
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.w600)),
                                SizedBox(width: 8),
                                Icon(Icons.location_on,
                                    color: AppColors.primary, size: 28),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 2.8,
                              children:
                                  _locations.map((l) => _locationButton(l)).toList(),
                            ),
                            const SizedBox(height: 18),
                            const Text('Observaciones:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _observationsController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: '...',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.borderGray),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: AppColors.borderGray),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: AppColors.primary, width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isSubmitted ? null : () => _submitEmergency(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  elevation: 6,
                                ),
                                child: const Text(
                                  'Enviar alerta',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            if (_isSubmitted)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    'Pendiente hasta revisión',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              buildBottomNav(context: context, activeItem: 'Citas'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emergencyButton(String emergency) {
    final selected = _selectedEmergency == emergency;
    return GestureDetector(
      onTap: () => setState(() => _selectedEmergency = emergency),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.primary : Colors.black,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
          color: selected ? AppColors.primary : Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          emergency,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _locationButton(String location) {
    final selected = _selectedLocation == location;
    return GestureDetector(
      onTap: () => setState(() => _selectedLocation = location),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppColors.primary : Colors.black,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
          color: selected ? AppColors.primary : Colors.white,
        ),
        alignment: Alignment.center,
        child: Text(
          location,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
