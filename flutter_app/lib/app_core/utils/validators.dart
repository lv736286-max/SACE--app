class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return 'Ingrese un correo válido';
    if (!value.contains('@')) return 'Correo inválido';
    return null;
  }

  static String? requiredField(String? value) {
    if (value == null || value.trim().isEmpty) return 'Campo requerido';
    return null;
  }
}
