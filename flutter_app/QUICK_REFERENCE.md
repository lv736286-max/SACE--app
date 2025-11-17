# 🚀 QUICK REFERENCE - Navegación en Flutter

## Rutas Disponibles

```
/ → LoginPage
/register → RegistrationPage
/home → HomePage
/emergency → EmergencyReportPage
/alerts → AlertHistoryPage
/alert-details → AlertDetailsPage
/help → HelpCenterPage
/menu → MenuProfilePage
```

## Comandos de Navegación

### Navegar Forward
```dart
Navigator.pushNamed(context, '/home');
```

### Navegar con Reemplazo (después de login)
```dart
Navigator.pushReplacementNamed(context, '/home');
```

### Volver Atrás
```dart
Navigator.pop(context);
```

## Ejemplo: Botón Login
```dart
ElevatedButton(
  onPressed: () {
    // Validar
    if (email.isNotEmpty && password.isNotEmpty) {
      // Navegar a Home
      Navigator.pushReplacementNamed(context, '/home');
    }
  },
  child: Text('Iniciar Sesión'),
)
```

## Ejemplo: Formulario con Transición
```dart
void _submitForm() {
  if (_validateInputs()) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('¡Enviado!'))
    );
    
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}
```

## Componentes Reutilizables

```dart
// Logo con fallback
buildLogo(width: 150)

// Campo de texto estándar
buildTextField(
  controller: miController,
  hint: 'Ingresa tu email',
  obscure: false,
)

// Header rojo
buildHeader(
  title: 'Mi Pantalla',
  onBackPressed: () => Navigator.pop(context),
)

// Navegación inferior
buildBottomNav(
  context: context,
  activeItem: 'Home',
)
```

## Agregar Nueva Pantalla (5 pasos)

### 1. Crear archivo
```bash
lib/screens/mi_pantalla.dart
```

### 2. Escribir código
```dart
import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/widgets.dart';

class MiPantalla extends StatefulWidget {
  const MiPantalla({Key? key}) : super(key: key);

  @override
  State<MiPantalla> createState() => _MiPantallaState();
}

class _MiPantallaState extends State<MiPantalla> {
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

### 3. Importar en main.dart
```dart
import 'screens/mi_pantalla.dart';
```

### 4. Agregar ruta en main.dart
```dart
routes: {
  '/mi-ruta': (context) => const MiPantalla(),
  ...
}
```

### 5. Usar la ruta
```dart
Navigator.pushNamed(context, '/mi-ruta');
```

## Bottom Navigation Quick Links

```dart
buildBottomNav(
  context: context,
  activeItem: 'Home', // o 'Citas', 'Notif', 'Perfil'
)

// Automáticamente navega a:
// - Home → /home
// - Citas → /emergency
// - Notif → /alerts
// - Perfil → /menu
```

## Colores Principales

```dart
AppColors.primary     // #B71C1C (Rojo)
AppColors.border      // #EEE7E3 (Gris claro)
AppColors.borderGray  // #BDBDBD (Gris medio)
AppColors.background  // #F5F5F5 (Fondo)
```

## Dimensiones

```dart
AppDimensions.phoneWidth    // 360
AppDimensions.phoneHeight   // 780
AppDimensions.bottomNavHeight // 56
AppDimensions.cornerRadius  // 28
```

---

**Tip:** Abre `NAVIGATION_GUIDE.md` para documentación completa 📖
