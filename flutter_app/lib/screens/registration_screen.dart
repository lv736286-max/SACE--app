import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

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

  void _submit() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona un rol')),
      );
      return;
    }

    final role = _selectedRole ?? 'No seleccionado';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registrando: ${_nameController.text} - $role')),
    );

    // Navigate to home after registration
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, '/');
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
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
                  border: Border.all(color: AppColors.border, width: 10),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Center(child: buildLogo(width: 120)),
                      const SizedBox(height: 8),
                      const Center(
                        child: Text(
                          'Registrate',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildTextField(controller: _nameController, hint: 'Nombre'),
                      const SizedBox(height: 12),
                      buildTextField(controller: _docController, hint: 'Documento'),
                      const SizedBox(height: 12),
                      buildTextField(controller: _emailController, hint: 'Correo'),
                      const SizedBox(height: 12),
                      buildTextField(
                        controller: _passController,
                        hint: 'Contraseña',
                        obscure: true,
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.primary,
                            child: const Text(
                              'A',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Rol en el colegio:',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
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
                          onPressed: _goToLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            '¿Ya tienes cuenta?',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Registrate',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              buildBottomNav(context: context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleChip(String role) {
    final selected = _selectedRole == role;
    return ChoiceChip(
      label: Text(
        role,
        style: TextStyle(color: selected ? Colors.white : Colors.black87),
      ),
      selected: selected,
      onSelected: (_) => setState(() => _selectedRole = role),
      selectedColor: AppColors.primary,
      backgroundColor: Colors.white,
      side: const BorderSide(color: AppColors.primary),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
