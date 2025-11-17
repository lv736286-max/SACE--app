import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/input_field.dart';
import '../widgets/reusable_button.dart';
import '../providers/auth_provider.dart';
import '../app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String role = 'Docente';

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Registrate')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            InputField(label: 'Nombre', controller: nameCtrl),
            const SizedBox(height: 8),
            InputField(label: 'Correo', controller: emailCtrl),
            const SizedBox(height: 8),
            InputField(label: 'Contraseña', controller: passCtrl, obscure: true),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Rol:'),
                const SizedBox(width: 12),
                DropdownButton<String>(value: role, items: const [
                  DropdownMenuItem(value: 'Administrativo', child: Text('Administrativo')),
                  DropdownMenuItem(value: 'Docente', child: Text('Docente')),
                  DropdownMenuItem(value: 'Restaurante', child: Text('Restaurante')),
                  DropdownMenuItem(value: 'Aseo', child: Text('Aseo')),
                ], onChanged: (v) { if (v!=null) setState(()=>role=v); }),
              ],
            ),
            const SizedBox(height: 12),
            ReusableButton(label: 'Registrarse', onPressed: () async {
              final ok = await auth.register(nameCtrl.text.trim(), emailCtrl.text.trim(), passCtrl.text.trim(), role);
              if (ok) Navigator.of(context).pushReplacementNamed(AppRoutes.home);
            }),
          ],
        ),
      ),
    );
  }
}
