import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class MenuProfilePage extends StatefulWidget {
  const MenuProfilePage({Key? key}) : super(key: key);

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
                      title: 'Menú',
                      onBackPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildSection(
                              title: 'Menú',
                              isExpanded: _expandedMenu,
                              onTap: () =>
                                  setState(() => _expandedMenu = !_expandedMenu),
                              children: [
                                _buildMenuItem('🚨 Reportar emergencia',
                                    () => Navigator.pushNamed(context, '/emergency')),
                                _buildMenuItem('📋 Ver historial',
                                    () => Navigator.pushNamed(context, '/alerts')),
                                _buildMenuItem('⋯ Mas opciones', () {}),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 16),
                            _buildSection(
                              title: 'Configuración',
                              isExpanded: _expandedConfig,
                              onTap: () =>
                                  setState(() => _expandedConfig = !_expandedConfig),
                              children: [
                                _buildInputField(_currentPasswordController,
                                    'Contraseña actual'),
                                _buildInputField(_newPasswordController,
                                    'Nueva contraseña',
                                    obscure: true),
                                _buildInputField(_confirmPasswordController,
                                    'Confirmar contraseña',
                                    obscure: true),
                              ],
                              showNextButton: false,
                            ),
                            const SizedBox(height: 16),
                            _buildSection(
                              title: 'Información de perfil',
                              isExpanded: _expandedProfile,
                              onTap: () =>
                                  setState(() => _expandedProfile = !_expandedProfile),
                              children: [
                                _buildProfileField('Editar información'),
                                _buildInputField(_nameController, 'Nombre'),
                                _buildInputField(_emailController,
                                    'Correo institucional'),
                                _buildInputField(_roleController, 'Rol'),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 16),
                            _buildSection(
                              title:
                                  'Ajustar notificaciones\n(tipo de alertas a recibir)',
                              isExpanded: _expandedNotifications,
                              onTap: () => setState(() =>
                                  _expandedNotifications =
                                      !_expandedNotifications),
                              children: [
                                _buildNotificationToggle('🔥 Incendio', _fireAlert,
                                    (value) {
                                  setState(() => _fireAlert = value);
                                }),
                                _buildNotificationToggle('⛈️ Temblor',
                                    _earthquakeAlert, (value) {
                                  setState(() => _earthquakeAlert = value);
                                }),
                                _buildNotificationToggle(
                                    '🚗 Accidente', _accidentAlert, (value) {
                                  setState(() => _accidentAlert = value);
                                }),
                              ],
                              showNextButton: true,
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Cambios guardados')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Enviar',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () =>
                                        Navigator.pushReplacementNamed(context, '/'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[300],
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Cerrar sesión',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600),
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
              buildBottomNav(context: context, activeItem: 'Perfil'),
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
                      foregroundColor: AppColors.primary,
                      side: const BorderSide(
                          color: AppColors.primary, width: 1.5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Siguiente',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13),
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
          const Icon(Icons.star, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
                fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label,
      {bool obscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            obscureText: obscure,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 8),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderGray),
                borderRadius: BorderRadius.circular(4),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.borderGray),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationToggle(
      String label, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.star, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                    fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
