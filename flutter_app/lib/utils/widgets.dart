import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'theme.dart';

/// Builds the logo (prefers PNG, falls back to SVG)
Widget buildLogo({double width = 150}) {
  return Image.asset(
    'assets/logo.png',
    width: width,
    fit: BoxFit.contain,
    errorBuilder: (context, error, stackTrace) =>
        SvgPicture.asset('assets/logo.svg', width: width, fit: BoxFit.contain),
  );
}

/// Builds a text field with standard styling
Widget buildTextField({
  required TextEditingController controller,
  required String hint,
  bool obscure = false,
}) {
  return TextField(
    controller: controller,
    obscureText: obscure,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primary),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );
}

/// Builds phone frame container with all standard styling
Widget buildPhoneFrame({
  required List<Widget> children,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.cornerRadius),
      border: Border.all(color: AppColors.border, width: 10),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))],
    ),
    child: Stack(
      children: children,
    ),
  );
}

/// Builds the red header container
Widget buildHeader({
  required String title,
  VoidCallback? onBackPressed,
  bool showBackButton = true,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    decoration: const BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(AppDimensions.cornerRadius),
        topRight: Radius.circular(AppDimensions.cornerRadius),
      ),
    ),
    child: Row(
      children: [
        if (showBackButton)
          GestureDetector(
            onTap: onBackPressed,
            child: const Text('<',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                )),
          ),
        if (showBackButton) const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds bottom navigation bar with standard styling
Widget buildBottomNav({
  required BuildContext context,
  String activeItem = 'Home',
}) {
  return Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
      height: AppDimensions.bottomNavHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(AppDimensions.cornerRadius),
          bottomRight: Radius.circular(AppDimensions.cornerRadius),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(context, 'Home', Icons.home, activeItem == 'Home',
              () => Navigator.pushNamed(context, '/home')),
          _buildNavItem(context, 'Citas', Icons.edit, activeItem == 'Citas',
              () => Navigator.pushNamed(context, '/emergency')),
          _buildNavItem(context, 'Notif', Icons.notifications, activeItem == 'Notif',
              () => Navigator.pushNamed(context, '/alerts')),
          _buildNavItem(context, 'Perfil', Icons.person, activeItem == 'Perfil',
              () => Navigator.pushNamed(context, '/menu')),
        ],
      ),
    ),
  );
}

Widget _buildNavItem(
  BuildContext context,
  String label,
  IconData icon,
  bool isActive,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isActive ? AppColors.primary : Colors.grey[600],
          size: 20,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? AppColors.primary : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}
