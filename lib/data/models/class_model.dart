class ClassModel {
  final String classId;
  final String teacherId;
  final String course;
  final String group;
  final String schoolYear;
  final List<String> students;
  final List<CustomChallenge> customChallenges;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClassModel({
    required this.classId,
    required this.teacherId,
    required this.course,
    required this.group,
    required this.schoolYear,
    List<String>? students,
    List<CustomChallenge>? customChallenges,
    required this.createdAt,
    required this.updatedAt,
  })  : students = students ?? [],
        customChallenges = customChallenges ?? [];

  Map<String, dynamic> toJson() => {
        'id': classId,
        'teacher_id': teacherId,
        'course': course,
        'group': group,
        'school_year': schoolYear,
        'students': students,
        'custom_challenges':
            customChallenges.map((c) => c.toJson()).toList(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  static DateTime _parseDate(dynamic value) {
    if (value == null) return DateTime.now();
    if (value is DateTime) return value;
    return DateTime.parse(value.toString());
  }

  factory ClassModel.fromJson(Map<String, dynamic> data) {
    return ClassModel(
      classId: data['class_id'] ?? data['id'] ?? '',
      teacherId: data['teacher_id'] ?? '',
      course: data['course'] ?? '',
      group: data['group'] ?? '',
      schoolYear: data['school_year'] ?? '',
      students: List<String>.from(data['students'] ?? []),
      customChallenges: (data['custom_challenges'] as List? ?? [])
          .map((c) => CustomChallenge.fromJson(c))
          .toList(),
      createdAt: _parseDate(data['created_at']),
      updatedAt: _parseDate(data['updated_at']),
    );
  }
}

class CustomChallenge {
  final String title;
  final String description;
  final DateTime dueDate;
  final int xpReward;
  final bool isActive;

  CustomChallenge({
    required this.title,
    this.description = '',
    required this.dueDate,
    this.xpReward = 50,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'xpReward': xpReward,
        'isActive': isActive,
      };

  factory CustomChallenge.fromJson(Map<String, dynamic> data) =>
      CustomChallenge(
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        dueDate: data['dueDate'] is DateTime
            ? data['dueDate']
            : DateTime.parse(data['dueDate'] ?? DateTime.now().toIso8601String()),
        xpReward: data['xpReward'] ?? 50,
        isActive: data['isActive'] ?? true,
      );
}
