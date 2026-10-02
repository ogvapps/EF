class UnitModel {
  final String unitId;
  final String course;
  final int trimester;
  final int order;
  final String title;
  final String subtitle;
  final String description;
  final int durationWeeks;
  final String narrativeTitle;
  final String? bossName;
  final int totalXP;
  final int requiredXP;
  final int bossXP;
  final Map<String, int> attributeFocus;
  final List<String> saberBasico;
  final List<String> competencias;
  final List<String> criteriosEval;
  final String iconURL;
  final String colorHex;
  final bool isLocked;
  final String? prerequisiteUnit;
  final bool isActive;
  final bool isFinal;
  final DateTime createdAt;
  final DateTime updatedAt;

  UnitModel({
    required this.unitId,
    required this.course,
    required this.trimester,
    required this.order,
    required this.title,
    this.subtitle = '',
    this.description = '',
    this.durationWeeks = 3,
    this.narrativeTitle = '',
    this.bossName,
    this.totalXP = 500,
    this.requiredXP = 300,
    this.bossXP = 200,
    Map<String, int>? attributeFocus,
    List<String>? saberBasico,
    List<String>? competencias,
    List<String>? criteriosEval,
    this.iconURL = '',
    this.colorHex = '#4CAF50',
    this.isLocked = false,
    this.prerequisiteUnit,
    this.isActive = true,
    this.isFinal = false,
    required this.createdAt,
    required this.updatedAt,
  })  : attributeFocus = attributeFocus ??
            {'fuerza': 0, 'resistencia': 0, 'estrategia': 0, 'cooperacion': 0, 'salud': 0, 'liderazgo': 0},
        saberBasico = saberBasico ?? [],
        competencias = competencias ?? [],
        criteriosEval = criteriosEval ?? [];

  Map<String, dynamic> toJson() => {
        'id': unitId,
        'course': course,
        'trimester': trimester,
        'order': order,
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'duration_weeks': durationWeeks,
        'narrative_title': narrativeTitle,
        'boss_name': bossName,
        'total_xp': totalXP,
        'required_xp': requiredXP,
        'boss_xp': bossXP,
        'attribute_focus': attributeFocus,
        'saber_basico': saberBasico,
        'competencias': competencias,
        'criterios_eval': criteriosEval,
        'icon_url': iconURL,
        'color_hex': colorHex,
        'is_locked': isLocked,
        'prerequisite_unit': prerequisiteUnit,
        'is_active': isActive,
        'is_final': isFinal,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory UnitModel.fromJson(Map<String, dynamic> data) {
    return UnitModel(
      unitId: data['unit_id'] ?? data['id'] ?? '',
      course: data['course'] ?? '',
      trimester: data['trimester'] ?? 1,
      order: data['order'] ?? 0,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      description: data['description'] ?? '',
      durationWeeks: data['duration_weeks'] ?? 3,
      narrativeTitle: data['narrative_title'] ?? '',
      bossName: data['boss_name'],
      totalXP: data['total_xp'] ?? 500,
      requiredXP: data['required_xp'] ?? 300,
      bossXP: data['boss_xp'] ?? 200,
      attributeFocus: Map<String, int>.from(data['attribute_focus'] ?? {}),
      saberBasico: List<String>.from(data['saber_basico'] ?? []),
      competencias: List<String>.from(data['competencias'] ?? []),
      criteriosEval: List<String>.from(data['criterios_eval'] ?? []),
      iconURL: data['icon_url'] ?? '',
      colorHex: data['color_hex'] ?? '#4CAF50',
      isLocked: data['is_locked'] ?? false,
      prerequisiteUnit: data['prerequisite_unit'],
      isActive: data['is_active'] ?? true,
      isFinal: data['is_final'] ?? false,
      createdAt: _parseDate(data['created_at']),
      updatedAt: _parseDate(data['updated_at']),
    );
  }
}
