import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/input_field.dart';
import '../widgets/reusable_button.dart';
import '../providers/auth_provider.dart';
import '../app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 48),
          child: Column(
            children: [
              // logo is integrated via app_theme in this architecture sample
              const SizedBox(height: 12),
              Text('Iniciar Sesión', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 24),
              InputField(label: 'Correo', hint: 'ejemplo@correo.com', controller: emailCtrl),
              const SizedBox(height: 12),
              InputField(label: 'Contraseña', controller: passCtrl, obscure: true),
              const SizedBox(height: 18),
              ReusableButton(label: 'Iniciar sesión', onPressed: () async {
                final ok = await auth.login(emailCtrl.text.trim(), passCtrl.text.trim());
                if (ok) {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.home);
                }
              }),
              const SizedBox(height: 8),
              ReusableButton(label: '¿No tienes cuenta?', outline: true, onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.register);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
