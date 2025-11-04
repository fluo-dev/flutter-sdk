class RegistrationStep {
  const RegistrationStep({
    required this.id,
    required this.fieldKey,
    required this.path,
    required this.selected,
  });

  factory RegistrationStep.fromJson(Map<String, dynamic> json) {
    return RegistrationStep(
      id: json['id'] as String,
      fieldKey: json['fieldKey'] as String,
      path: json['path'] as String,
      selected: json['selected'] as bool,
    );
  }

  final String id;
  final String fieldKey;
  final String path;
  final bool selected;

  RegistrationStep copyWith({
    String? id,
    String? fieldKey,
    String? path,
    bool? selected,
  }) {
    return RegistrationStep(
      id: id ?? this.id,
      fieldKey: fieldKey ?? this.fieldKey,
      path: path ?? this.path,
      selected: selected ?? this.selected,
    );
  }
}
