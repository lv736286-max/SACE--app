import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outline;

  const ReusableButton({super.key, required this.label, required this.onPressed, this.outline = false});

  @override
  Widget build(BuildContext context) {
    if (outline) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: BorderSide(color: Theme.of(context).primaryColor),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        ),
        child: Text(label, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      ),
      child: Text(label),
    );
  }
}
