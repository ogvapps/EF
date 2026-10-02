enum AttributeType {
  fuerza,
  resistencia,
  estrategia,
  cooperacion,
  salud,
  liderazgo;

  String get value => name;
  String get displayName => name[0].toUpperCase() + name.substring(1);
  String get icon {
    switch (this) {
      case AttributeType.fuerza:
        return '💪';
      case AttributeType.resistencia:
        return '❤️';
      case AttributeType.estrategia:
        return '🧠';
      case AttributeType.cooperacion:
        return '🤝';
      case AttributeType.salud:
        return '🍎';
      case AttributeType.liderazgo:
        return '⭐';
    }
  }
  String get color {
    switch (this) {
      case AttributeType.fuerza:
        return '#FF4444';
      case AttributeType.resistencia:
        return '#FF6B35';
      case AttributeType.estrategia:
        return '#4A90D9';
      case AttributeType.cooperacion:
        return '#50C878';
      case AttributeType.salud:
        return '#32CD32';
      case AttributeType.liderazgo:
        return '#FFD700';
    }
  }

  static AttributeType fromString(String s) =>
      AttributeType.values.firstWhere((e) => e.name == s);
}
