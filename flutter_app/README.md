# SACE Mockup — Flutter

Esta carpeta contiene una app Flutter mínima que reproduce la maqueta (pantalla móvil con logo, botón central y tres íconos inferiores).

Pasos para usarla:

1. Asegúrate de tener Flutter instalado y en tu PATH. Para comprobar:

```powershell
flutter --version
```

2. Copia las imágenes del mockup a la carpeta `flutter_app/assets/` con estos nombres:

- `logo.png` — el escudo SACE (imagen del mockup)
- `icon1.png` — primer ícono inferior (cruz roja)
- `icon2.png` — segundo ícono inferior (teléfono / help)
- `icon3.png` — tercer ícono inferior (botiquín)
- `frame.png` — (opcional) marco del teléfono si quieres usarlo

3. Desde PowerShell, sitúate en `c:\Users\PEDRO\Desktop\App SACE\flutter_app` y corre:

```powershell
flutter pub get
flutter run -d chrome  # o el dispositivo/emulador que prefieras
```

Notas:
- Si me subes las imágenes (o las colocas en la carpeta `flutter_app/assets/`), puedo añadirlas directamente al repo.
- Puedo adaptar los tamaños, sombras y tipografías para que coincidan más exactamente con la maqueta.
