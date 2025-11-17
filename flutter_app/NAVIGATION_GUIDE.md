# SACE - Sistema de Alertas Escolares

## Estructura del Proyecto

Tu app Flutter ahora está organizada de manera profesional y escalable:

```
flutter_app/
├── lib/
│   ├── main.dart                          # Punto de entrada, configuración de rutas
│   ├── models/
│   │   └── models.dart                    # Modelos de datos (AlertCard, ExpenseRow, FAQ)
│   ├── screens/
│   │   ├── login_screen.dart              # Pantalla de inicio de sesión
│   │   ├── registration_screen.dart       # Pantalla de registro
│   │   ├── home_screen.dart               # Pantalla principal (Inicio)
│   │   ├── emergency_report_screen.dart   # Reporte de emergencias
│   │   ├── alert_history_screen.dart      # Historial de alertas
│   │   ├── alert_details_screen.dart      # Detalles de alertas (tablas)
│   │   ├── help_center_screen.dart        # Centro de ayuda y FAQ
│   │   └── menu_profile_screen.dart       # Menú y perfil de usuario
│   └── utils/
│       ├── theme.dart                     # Colores, dimensiones y constantes
│       └── widgets.dart                   # Widgets reutilizables (logo, header, nav)
├── assets/
│   ├── logo.png                           # Logo PNG
│   ├── logo.svg                           # Logo SVG (fallback)
│   └── icon*.svg                          # Iconos adicionales
└── pubspec.yaml                           # Dependencias del proyecto
```

## Sistema de Navegación

### Rutas Configuradas

| Ruta | Pantalla | Uso |
|------|----------|-----|
| `/` | LoginPage | Inicio de sesión |
| `/register` | RegistrationPage | Registro de nuevo usuario |
| `/home` | HomePage | Pantalla principal |
| `/emergency` | EmergencyReportPage | Reportar emergencia |
| `/alerts` | AlertHistoryPage | Historial de alertas |
| `/alert-details` | AlertDetailsPage | Detalles con tablas |
| `/help` | HelpCenterPage | Centro de ayuda |
| `/menu` | MenuProfilePage | Perfil y configuración |

### Navegación Entre Pantallas

#### Navigator.pushNamed() - Navegar forward
```dart
// Ir a una nueva pantalla
Navigator.pushNamed(context, '/home');
```

#### Navigator.pop() - Volver atrás
```dart
// Volver a la pantalla anterior
Navigator.pop(context);
```

#### Navigator.pushReplacementNamed() - Reemplazar pantalla actual
```dart
// Navegar reemplazando (ej: después de login)
Navigator.pushReplacementNamed(context, '/home');
```

### Ejemplos de Uso en Pantallas

#### Ejemplo 1: Login → Home (después de autenticación)
```dart
void _login() {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Iniciando sesión...')),
  );
  // Simular delay de autenticación
  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.pushReplacementNamed(context, '/home');
  });
}
```

#### Ejemplo 2: Botón en BottomNav → Navegar a otra pantalla
```dart
Widget buildBottomNav({
  required BuildContext context,
  String activeItem = 'Home',
}) {
  return _buildNavItem(context, 'Citas', Icons.edit, activeItem == 'Citas',
      () => Navigator.pushNamed(context, '/emergency'));
}
```

#### Ejemplo 3: Formulario → Siguiente pantalla
```dart
void _submit() {
  if (_selectedRole == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor selecciona un rol')),
    );
    return;
  }
  
  // Mostrar confirmación y navegar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Registrando: ${_nameController.text}')),
  );
  
  Future.delayed(const Duration(milliseconds: 500), () {
    Navigator.pushReplacementNamed(context, '/home');
  });
}
```

#### Ejemplo 4: Botón Back → Pop
```dart
// En el header rojo
buildHeader(
  title: 'Reportar emergencia',
  onBackPressed: () => Navigator.pop(context),
),
```

## Componentes Reutilizables

### En `lib/utils/widgets.dart`

#### buildLogo()
```dart
Widget buildLogo({double width = 150}) {
  return Image.asset(...);
}
```

#### buildTextField()
```dart
Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  bool obscure = false,
})
```

#### buildPhoneFrame()
```dart
Widget buildPhoneFrame({required List<Widget> children})
```

#### buildHeader()
```dart
Widget buildHeader({
  required String title,
  VoidCallback? onBackPressed,
  bool showBackButton = true,
})
```

#### buildBottomNav()
```dart
Widget buildBottomNav({
  required BuildContext context,
  String activeItem = 'Home',
})
```

### Tema en `lib/utils/theme.dart`

```dart
class AppColors {
  static const primary = Color(0xFFB71C1C);           // Rojo
  static const border = Color(0xFFEEE7E3);           // Gris claro
  static const borderGray = Color(0xFFBDBDBD);       // Gris medio
  static const background = Color(0xFFF5F5F5);       // Fondo
}

class AppDimensions {
  static const phoneWidth = 360.0;
  static const phoneHeight = 780.0;
  static const bottomNavHeight = 56.0;
  static const cornerRadius = 28.0;
}
```

## Modelos de Datos

```dart
// lib/models/models.dart

class AlertCard {
  final String title;
  final String description;
}

class ExpenseRow {
  final String quantity;
  final String amount;
  final String expense;
}

class FAQ {
  final String question;
  final String answer;
}
```

## Mejores Prácticas Implementadas

✅ **Separación de Concerns** - Cada pantalla en su propio archivo  
✅ **Reutilización de Código** - Componentes comunes en `utils/`  
✅ **Tema Centralizado** - Colores y dimensiones en un lugar  
✅ **Navegación Limpia** - Rutas nombradas y consistentes  
✅ **TextEditingController** - Proper disposal en `dispose()`  
✅ **SnackBars** - Feedback visual para acciones  
✅ **Transiciones Automáticas** - Formularios navegan tras completarse  

## Cómo Agregar una Nueva Pantalla

1. **Crear archivo** en `lib/screens/mi_pantalla.dart`
2. **Heredar de StatefulWidget** y crear State
3. **Importar en main.dart** en la sección de imports
4. **Agregar ruta** en MaterialApp routes
5. **Usar navegación** con `Navigator.pushNamed(context, '/mi-ruta')`

## Ejemplo Completo - Nueva Pantalla

```dart
// lib/screens/my_new_screen.dart
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class MyNewScreen extends StatefulWidget {
  const MyNewScreen({Key? key}) : super(key: key);

  @override
  State<MyNewScreen> createState() => _MyNewScreenState();
}

class _MyNewScreenState extends State<MyNewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: AppDimensions.phoneWidth,
          height: AppDimensions.phoneHeight,
          child: Stack(
            children: [
              Container(...),
              buildBottomNav(context: context),
            ],
          ),
        ),
      ),
    );
  }
}
```

```dart
// main.dart - agregar import
import 'screens/my_new_screen.dart';

// main.dart - agregar ruta
routes: {
  ...
  '/my-route': (context) => const MyNewScreen(),
},
```

## Compilación y Ejecución

```bash
# Analizar código
flutter analyze

# Obtener dependencias
flutter pub get

# Ejecutar en dispositivo o emulador
flutter run

# Ejecutar en Chrome (web preview)
flutter run -d chrome

# Build release
flutter build apk
flutter build ios
```

## Notas Importantes

- ✅ Todas las pantallas ya tienen navegación integrada
- ✅ El logo PNG está en `assets/logo.png` con fallback a SVG
- ✅ Los colores usan `AppColors.primary` (rojo #B71C1C)
- ✅ Las dimensiones del teléfono son 360×780px
- ✅ El bottom nav está disponible en todas las pantallas
- ✅ Los formularios navegan automáticamente al completarse

¡Tu app está lista para desarrollo profesional! 🚀
