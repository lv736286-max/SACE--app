import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import app_core structure
import 'app_core/app_routes.dart';
import 'app_core/theme/app_theme.dart';
import 'app_core/services/api_service.dart';
import 'app_core/services/emergency_service.dart';
import 'app_core/services/notification_service.dart';
import 'app_core/providers/auth_provider.dart';
import 'app_core/providers/emergency_provider.dart';

void main() {
  runApp(const MyApp());
}

/// Main application widget with Provider setup and routing configuration
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize services
    final apiService = ApiService(baseUrl: 'https://api.sace.local');
    final emergencyService = EmergencyService(apiService);
    final notificationService = NotificationService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => EmergencyProvider(
            service: emergencyService,
            notifier: notificationService,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SACE - Sistema de Alertas Escolares',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.login,
        onGenerateRoute: AppRoutes.generateRoute,
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
          );
        },
      ),
    );
  }
}
