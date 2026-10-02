class Validators {
  static String? email(String? v) {
    if (v == null || v.isEmpty) return 'Email requerido';
    return v.contains('@') ? null : 'Email inválido';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Contraseña requerida';
    return v.length >= 6 ? null : 'Mínimo 6 caracteres';
  }

  static String? name(String? v) {
    if (v == null || v.isEmpty) return 'Nombre requerido';
    return v.length >= 2 ? null : 'Nombre muy corto';
  }

  static String? notEmpty(String? v, String field) {
    if (v == null || v.trim().isEmpty) return '$field requerido';
    return null;
  }
}
