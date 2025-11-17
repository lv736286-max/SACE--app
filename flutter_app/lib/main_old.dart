import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SACE Login',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/home',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/register': (context) => const RegistrationPage(),
        '/alerts': (context) => const AlertHistoryPage(),
        '/alert-details': (context) => const AlertDetailsPage(),
        '/emergency': (context) => const EmergencyReportPage(),
        '/menu': (context) => const MenuProfilePage(),
        '/help': (context) => const HelpCenterPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<AlertCard> alerts = [
    AlertCard(
      title: 'Alerta N.1',
      description: 'Incendio en en aula multiple. Por favor, trasladarse a la zona de punto de encuentro del IDEMAG',
    ),
    AlertCard(
      title: 'Alerta N.2',
      description: 'Persona desmayada en el baño de mujeres. Se solicita personal de enfermeria urgente.',
    ),
    AlertCard(
      title: 'Alerta N.3',
      description: 'Se reporta sismo en el IDEMAG. Por favor todos los estudiantes y personas que se encuentren dentro, reunirsen en los puntos de encuentro',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Header with title
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Inicio',
                              style: TextStyle(
                                color: Color(0xFFB71C1C),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Alert cards list
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
              // Bottom navigation bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem('Home', Icons.home, true),
                      _buildNavItem('Appointments', Icons.edit, false),
                      _buildNavItem('Notifications', Icons.notifications, false),
                      _buildNavItem('Profile', Icons.person, false),
                    ],
                  ),
                ),
              ),
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
                color: Color(0xFFB71C1C),
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
                  foregroundColor: const Color(0xFFB71C1C),
                  side: const BorderSide(color: Color(0xFFB71C1C), width: 1.5),
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

  Widget _buildNavItem(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Appointments') {
          Navigator.pushNamed(context, '/emergency');
        } else if (label == 'Notifications') {
          Navigator.pushNamed(context, '/alerts');
        } else if (label == 'Profile') {
          Navigator.pushNamed(context, '/menu');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
            size: 20,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class AlertCard {
  final String title;
  final String description;

  AlertCard({required this.title, required this.description});
}

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _nameController = TextEditingController();
  final _docController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  String? _selectedRole;

  final List<String> _roles = ['Administrativo', 'Docente', 'Restaurante', 'Aseo'];

  @override
  void dispose() {
    _nameController.dispose();
    _docController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Center(child: _buildLogoSmall()),
                      const SizedBox(height: 8),
                      Center(child: Text('Registrate', style: TextStyle(color: const Color(0xFFB71C1C), fontSize: 22, fontWeight: FontWeight.w700))),
                      const SizedBox(height: 12),

                      _buildField(_nameController, 'Nombre'),
                      const SizedBox(height: 12),
                      _buildField(_docController, 'Documento'),
                      const SizedBox(height: 12),
                      _buildField(_emailController, 'Correo'),
                      const SizedBox(height: 12),
                      _buildField(_passController, 'Contraseña', obscure: true),

                      const SizedBox(height: 18),
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: const Color(0xFFB71C1C), child: const Text('A', style: TextStyle(color: Colors.white))),
                          const SizedBox(width: 10),
                          const Text('Rol en el colegio:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        ],
                      ),

                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 18,
                        runSpacing: 12,
                        children: _roles.map((r) => _roleChip(r)).toList(),
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB71C1C), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('¿Ya tienes cuenta?', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB71C1C), padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('Inicia sesion', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              // Bottom navigation
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomNavItem('Home', Icons.home, false),
                      _buildBottomNavItem('Appointments', Icons.edit, false),
                      _buildBottomNavItem('Notifications', Icons.notifications, false),
                      _buildBottomNavItem('Profile', Icons.person, false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushNamed(context, '/home');
        } else if (label == 'Appointments') {
          Navigator.pushNamed(context, '/emergency');
        } else if (label == 'Profile') {
          Navigator.pushNamed(context, '/menu');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600], size: 20),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String hint, {bool obscure = false}) => TextField(
        controller: ctrl,
        obscureText: obscure,
        decoration: InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16), enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFBDBDBD)), borderRadius: BorderRadius.circular(4)), focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFFB71C1C)), borderRadius: BorderRadius.circular(4))),
      );

  Widget _roleChip(String role) {
    final selected = _selectedRole == role;
    return ChoiceChip(
      label: Text(role, style: TextStyle(color: selected ? Colors.white : Colors.black87)),
      selected: selected,
      onSelected: (_) => setState(() => _selectedRole = role),
      selectedColor: const Color(0xFFB71C1C),
      backgroundColor: Colors.white,
      side: const BorderSide(color: Color(0xFFB71C1C)),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  Widget _buildLogoSmall() {
    return Image.asset('assets/logo.png', width: 120, fit: BoxFit.contain, errorBuilder: (c,e,s) => SvgPicture.asset('assets/logo.svg', width:120));
  }

  void _submit() {
    final role = _selectedRole ?? 'No seleccionado';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registrando: ${_nameController.text} - $role')));
  }
}

class EmergencyReportPage extends StatefulWidget {
  const EmergencyReportPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Red header with back button and title
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB71C1C),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('<', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Reportar emergencia',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Emergency Type Section
                            const Text('Tipo de emergencia:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 2.8,
                              children: _emergencies.map((e) => _emergencyButton(e)).toList(),
                            ),
                            const SizedBox(height: 18),

                            // Location Section with icon
                            Row(
                              children: [
                                const Text('Ubicación:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                const SizedBox(width: 8),
                                const Icon(Icons.location_on, color: Color(0xFFB71C1C), size: 28),
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
                              children: _locations.map((l) => _locationButton(l)).toList(),
                            ),
                            const SizedBox(height: 18),

                            // Observations Section
                            const Text('Observaciones:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _observationsController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: '...',
                                hintStyle: TextStyle(color: Colors.grey[400]),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFFB71C1C), width: 2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Submit button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isSubmitted ? null : () => _submitEmergency(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFB71C1C),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                  elevation: 6,
                                ),
                                child: const Text(
                                  'Enviar alerta',
                                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Status message
                            if (_isSubmitted)
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFB71C1C),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    elevation: 4,
                                  ),
                                  child: const Text(
                                    'Pendiente hasta revisión',
                                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
              // Bottom navigation bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem('Home', Icons.home),
                      _navItem('Appointments', Icons.edit),
                      _navItem('Notifications', Icons.notifications),
                      _navItem('Profile', Icons.person),
                    ],
                  ),
                ),
              ),
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
            color: selected ? const Color(0xFFB71C1C) : Colors.black,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
          color: selected ? const Color(0xFFB71C1C) : Colors.white,
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
            color: selected ? const Color(0xFFB71C1C) : Colors.black,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
          color: selected ? const Color(0xFFB71C1C) : Colors.white,
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

  Widget _navItem(String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  void _submitEmergency() {
    if (_selectedEmergency == null || _selectedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona tipo de emergencia y ubicación')),
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
}

class AlertDetailsPage extends StatefulWidget {
  const AlertDetailsPage({super.key});

  @override
  State<AlertDetailsPage> createState() => _AlertDetailsPageState();
}

class _AlertDetailsPageState extends State<AlertDetailsPage> {
  final List<ExpenseRow> tableData = [
    ExpenseRow(quantity: '5', amount: '1200', expense: 'Alquilar'),
    ExpenseRow(quantity: '4', amount: '500', expense: 'Electricidad'),
    ExpenseRow(quantity: '3', amount: '4500', expense: 'Ropa'),
    ExpenseRow(quantity: '2', amount: '3000', expense: 'Entretenimiento'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Red header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB71C1C),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('<', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Historial de alertas',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Table content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            _buildTable(tableData),
                            const SizedBox(height: 24),
                            _buildTable(tableData),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
              ),
              // Bottom navigation
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomNavItem('Home', Icons.home, false),
                      _buildBottomNavItem('Appointments', Icons.edit, false),
                      _buildBottomNavItem('Notifications', Icons.notifications, true),
                      _buildBottomNavItem('Profile', Icons.person, false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTable(List<ExpenseRow> data) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey[300]!, width: 1),
          verticalInside: BorderSide(color: Colors.grey[300]!, width: 1),
          top: BorderSide(color: Colors.grey[300]!, width: 1),
          bottom: BorderSide(color: Colors.grey[300]!, width: 1),
          left: BorderSide(color: Colors.grey[300]!, width: 1),
          right: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1.8),
        },
        children: [
          // Header row
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[200]),
            children: [
              _buildTableCell('Cantidad', isHeader: true),
              _buildTableCell('Gastos', isHeader: true),
              _buildTableCell('', isHeader: true),
            ],
          ),
          // Data rows
          ...data.map((row) => TableRow(
            decoration: BoxDecoration(color: Colors.white),
            children: [
              _buildTableCell(row.quantity),
              _buildTableCell(row.amount),
              _buildTableCell(row.expense),
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 13 : 12,
          fontWeight: isHeader ? FontWeight.w600 : FontWeight.w500,
          color: isHeader ? Colors.grey[700] : Colors.grey[600],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBottomNavItem(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushNamed(context, '/home');
        } else if (label == 'Appointments') {
          Navigator.pushNamed(context, '/emergency');
        } else if (label == 'Profile') {
          Navigator.pushNamed(context, '/menu');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600], size: 20),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseRow {
  final String quantity;
  final String amount;
  final String expense;

  ExpenseRow({required this.quantity, required this.amount, required this.expense});
}

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
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Red header with back button and title
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB71C1C),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(onTap: () => Navigator.pop(context), child: const Text('<', style: TextStyle(color: Colors.white, fontSize: 28))),
                          const SizedBox(width: 12),
                          const Expanded(child: Text('Historial de alertas', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
                        ],
                      ),
                    ),
                    // Scrollable content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Fecha:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Mes', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))))),
                                const SizedBox(width: 12),
                                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Dia', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))))),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Año', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))))),
                                const SizedBox(width: 12),
                                Expanded(child: TextField(decoration: InputDecoration(hintText: 'Hora', border: OutlineInputBorder(borderRadius: BorderRadius.circular(4))))),
                              ],
                            ),
                            const SizedBox(height: 18),
                            const Text('Tipo:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: _types.map((t) => _typeButton(t)).toList(),
                            ),
                            const SizedBox(height: 18),
                            const Text('Estado:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: _statuses.map((s) => _statusPill(s)).toList(),
                            ),
                            const SizedBox(height: 18),
                            const Text('Reportado por:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 14,
                              runSpacing: 10,
                              children: _reporters.map((r) => _reporterPill(r)).toList(),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom nav bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem('Home', Icons.home),
                      _navItem('Appointments', Icons.edit),
                      _navItem('Notifications', Icons.notifications),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),

              // Bottom navigation bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem('Home', Icons.home),
                      _navItem('Appointments', Icons.edit),
                      _navItem('Notifications', Icons.notifications),
                      _navItem('Profile', Icons.person),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }

  Widget _typeButton(String type) {
    final selected = _selectedType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: selected ? const Color(0xFFB71C1C) : Colors.grey[400]!, width: 2),
          borderRadius: BorderRadius.circular(4),
          color: selected ? const Color(0xFFB71C1C) : Colors.white,
        ),
        child: Text(type, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
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
          color: selected ? const Color(0xFFB71C1C) : Colors.grey[200],
        ),
        child: Text(status, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
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
          color: selected ? const Color(0xFFB71C1C) : Colors.grey[200],
        ),
        child: Text(reporter, style: TextStyle(color: selected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              // Background card (phone screen)
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      // Logo (prefer PNG if present, otherwise SVG)
                      SizedBox(
                        height: 140,
                        child: Center(
                          child: _buildLogo(),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text('Iniciar Sesión', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 24, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 18),

                      // Email field
                      _buildTextField(controller: _emailController, hint: 'Correo'),
                      const SizedBox(height: 18),
                      // Password field
                      _buildTextField(controller: _passController, hint: 'Contraseña', obscure: true),

                      const SizedBox(height: 22),

                      // Buttons (stacked)
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to registration
                                    Navigator.pushNamed(context, '/register');
                                  },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB71C1C),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 6,
                              ),
                              child: const Text('¿Ya tienes cuenta?', style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Login action
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Iniciando sesión...')));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB71C1C),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 6,
                              ),
                              child: const Text('Inicia sesion', style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),
                    ],
                  ),
                ),
              ),

              // Bottom navigation bar
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem('Home', Icons.home),
                      _navItem('Appointments', Icons.edit),
                      _navItem('Notifications', Icons.notifications),
                      _navItem('Profile', Icons.person),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    // Prefer PNG in assets; fallback to SVG if PNG missing
    return Image.asset(
      'assets/logo.png',
      width: 150,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => SvgPicture.asset('assets/logo.svg', width: 150, fit: BoxFit.contain),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hint, bool obscure = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFFB71C1C)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
      ],
    );
  }
}

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController subjectController;
  late TextEditingController messageController;

  final List<FAQ> faqs = [
    FAQ(
      question: '¿Como reportar emergencia?',
      answer: 'Accede a la sección de reportar emergencia en el menú principal y completa el formulario con los detalles del incidente.',
    ),
    FAQ(
      question: '¿Que hacer despues de enviar una alerta?',
      answer: 'Después de enviar una alerta, el sistema notificará a los encargados. Puedes consultar el estado en el historial de alertas.',
    ),
    FAQ(
      question: '¿Como cambiar mi contraseña?',
      answer: 'Ve a Menú > Configuración y selecciona "Cambiar contraseña". Ingresa tu contraseña actual y la nueva.',
    ),
    FAQ(
      question: '¿Como contactar a los encargados?',
      answer: 'Puedes contactar a los encargados directamente desde esta sección rellenando el formulario de contacto.',
    ),
  ];

  final List<bool> expandedFaq = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    subjectController = TextEditingController();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Red header with title
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB71C1C),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: Column(
                        children: const [
                          Text(
                            'Centro de ayuda',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'y soporte',
                            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // FAQ Section
                            Row(
                              children: const [
                                Text('★', style: TextStyle(color: Color(0xFFB71C1C), fontSize: 18)),
                                SizedBox(width: 8),
                                Text(
                                  'Preguntas frecuentes',
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...List.generate(
                              faqs.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey[300]!, width: 1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: ExpansionTile(
                                    title: Text(
                                      faqs[index].question,
                                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                    onExpansionChanged: (expanded) {
                                      setState(() {
                                        expandedFaq[index] = expanded;
                                      });
                                    },
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          faqs[index].answer,
                                          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Contact Section
                            const Text(
                              'Nombre del encargado :',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(nameController),
                            const SizedBox(height: 12),
                            const Text(
                              'Correo :',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(emailController),
                            const SizedBox(height: 12),
                            const Text(
                              'Telefono :',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(phoneController),
                            const SizedBox(height: 20),
                            // Help Message Section
                            const Text(
                              'Enviar mensaje de ayuda',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Asunto:',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(subjectController),
                            const SizedBox(height: 12),
                            const Text(
                              'Mensaje:',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 6),
                            _buildTextField(messageController, maxLines: 4),
                            const SizedBox(height: 16),
                            // Buttons
                            ElevatedButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Mensaje enviado')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB71C1C),
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Enviar mensaje',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB71C1C),
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text(
                                'Cancelar',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ),
                            const SizedBox(height: 70),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom navigation
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomNavItem('Home', Icons.home, false),
                      _buildBottomNavItem('Appointments', Icons.edit, false),
                      _buildBottomNavItem('Notifications', Icons.notifications, false),
                      _buildBottomNavItem('Profile', Icons.person, false),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildBottomNavItem(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushNamed(context, '/home');
        } else if (label == 'Appointments') {
          Navigator.pushNamed(context, '/emergency');
        } else if (label == 'Profile') {
          Navigator.pushNamed(context, '/menu');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600], size: 20),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});
}

class MenuProfilePage extends StatefulWidget {
  const MenuProfilePage({super.key});

  @override
  State<MenuProfilePage> createState() => _MenuProfilePageState();
}

class _MenuProfilePageState extends State<MenuProfilePage> {
  bool _expandedMenu = true;
  bool _expandedConfig = false;
  bool _expandedProfile = false;
  bool _expandedNotifications = false;

  bool _fireAlert = true;
  bool _earthquakeAlert = true;
  bool _accidentAlert = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _roleController = TextEditingController();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Juan Pérez';
    _emailController.text = 'juan.perez@institution.edu';
    _roleController.text = 'Estudiante';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _roleController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          height: 780,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFEEE7E3), width: 10),
                  boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
                ),
                child: Column(
                  children: [
                    // Red header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB71C1C),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const Text('<', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'Menú',
                              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            // Menu Section
                            _buildSection(
                              title: 'Menú',
                              isExpanded: _expandedMenu,
                              onTap: () => setState(() => _expandedMenu = !_expandedMenu),
                              children: [
                                _buildMenuItem('🚨 Reportar emergencia', () => Navigator.pushNamed(context, '/emergency')),
                                _buildMenuItem('📋 Ver historial', () => Navigator.pushNamed(context, '/alerts')),
                                _buildMenuItem('⋯ Mas opciones', () {}),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 16),

                            // Configuration Section
                            _buildSection(
                              title: 'Configuración',
                              isExpanded: _expandedConfig,
                              onTap: () => setState(() => _expandedConfig = !_expandedConfig),
                              children: [
                                _buildInputField(_currentPasswordController, 'Contraseña actual'),
                                _buildInputField(_newPasswordController, 'Nueva contraseña', obscure: true),
                                _buildInputField(_confirmPasswordController, 'Confirmar contraseña', obscure: true),
                              ],
                              showNextButton: false,
                            ),
                            const SizedBox(height: 16),

                            // Profile Information Section
                            _buildSection(
                              title: 'Información de perfil',
                              isExpanded: _expandedProfile,
                              onTap: () => setState(() => _expandedProfile = !_expandedProfile),
                              children: [
                                _buildProfileField('Editar información'),
                                _buildInputField(_nameController, 'Nombre'),
                                _buildInputField(_emailController, 'Correo institucional'),
                                _buildInputField(_roleController, 'Rol'),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 16),

                            // Notifications Settings Section
                            _buildSection(
                              title: 'Ajustar notificaciones\n(tipo de alertas a recibir)',
                              isExpanded: _expandedNotifications,
                              onTap: () => setState(() => _expandedNotifications = !_expandedNotifications),
                              children: [
                                _buildNotificationToggle('🔥 Incendio', _fireAlert, (value) {
                                  setState(() => _fireAlert = value);
                                }),
                                _buildNotificationToggle('⛈️ Temblor', _earthquakeAlert, (value) {
                                  setState(() => _earthquakeAlert = value);
                                }),
                                _buildNotificationToggle('🚗 Accidente', _accidentAlert, (value) {
                                  setState(() => _accidentAlert = value);
                                }),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 24),

                            // Bottom Buttons
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('Cambios guardados')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Enviar',
                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(context, '/'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Cerrar sesión',
                                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Bottom navigation
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey[300]!)),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(28), bottomRight: Radius.circular(28)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildBottomNavItem('Home', Icons.home, false),
                      _buildBottomNavItem('Appointments', Icons.edit, false),
                      _buildBottomNavItem('Notifications', Icons.notifications, false),
                      _buildBottomNavItem('Profile', Icons.person, true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
    required bool showNextButton,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    color: Colors.black,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Padding(
              padding: const EdgeInsets.only(left: 32, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ),
            if (showNextButton)
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(left: 32, bottom: 12),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFB71C1C),
                      side: const BorderSide(color: Color(0xFFB71C1C), width: 1.5),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildMenuItem(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.star, color: Color(0xFFB71C1C), size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFB71C1C), size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFFBDBDBD)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: Color(0xFFB71C1C), size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFFB71C1C),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String label, IconData icon, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'Home') {
          Navigator.pushNamed(context, '/home');
        } else if (label == 'Appointments') {
          Navigator.pushNamed(context, '/emergency');
        } else if (label == 'Notifications') {
          Navigator.pushNamed(context, '/alerts');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
            size: 20,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive ? const Color(0xFFB71C1C) : Colors.grey[600],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
