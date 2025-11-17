Arquitectura de ejemplo para SACE App

Estructura creada:
- lib/app_core/
  - screens/
  - widgets/
  - services/
  - models/
  - providers/
  - theme/
  - utils/

Archivos clave:
- `app_routes.dart` - rutas nombradas centralizadas
- `theme/app_theme.dart` - paleta y estilos
- `providers/*` - controladores de estado con `ChangeNotifier`
- `services/*` - `ApiService`, `EmergencyService`, `NotificationService`
- `widgets/*` - botones, inputs y tarjetas reutilizables

Instrucciones rápidas:
1. Abre `lib/main.dart` y registra los providers (o reemplázalo por el `main.dart` de este ejemplo si lo deseas).
2. Ejecuta `flutter pub get`.
3. Corre la app con `flutter run`.

Ejemplos de uso:
- Desde `LoginScreen` se usa `AuthProvider.login(...)` y luego `Navigator.pushReplacementNamed(AppRoutes.home)`.
- Desde `EmergencyScreen` se crea una `Emergency` y se llama `EmergencyProvider.send(e)`.

Puedo integrar estos ficheros al `main.dart` existente o reemplazarlo para usar `app_core` como entrada principal. Dime si prefieres que actualice `lib/main.dart` para usar esta arquitectura.
