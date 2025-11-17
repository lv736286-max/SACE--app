import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/emergency_screen.dart';
import 'screens/alerts_screen.dart';
import 'screens/alert_details_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String emergency = '/emergency';
  static const String alerts = '/alerts';
  static const String alertDetails = '/alert-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case emergency:
        return MaterialPageRoute(builder: (_) => const EmergencyScreen());
      case alerts:
        return MaterialPageRoute(builder: (_) => const AlertsScreen());
      case alertDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(builder: (_) => AlertDetailsScreen(data: args));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(child: Text('Route for ${settings.name} not found')),
                ));
    }
  }
}
