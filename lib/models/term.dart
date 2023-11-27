// ignore_for_file: public_member_api_docs, sort_constructors_first
class Terms {
  final String name;
  final String rightDescription;
  final String wrongDescription;

  const Terms(
      {this.name = '', this.rightDescription = '', this.wrongDescription = ''});

  Terms copyWith({
    String? name,
    String? rightDescription,
    String? wrongDescription,
  }) {
    return Terms(
      name: name ?? this.name,
      rightDescription: rightDescription ?? this.rightDescription,
      wrongDescription: wrongDescription ?? this.wrongDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'rightDescription': rightDescription,
      'wrongDescription': wrongDescription,
    };
  }

  factory Terms.fromMap(Map<String, dynamic> map) {
    return Terms(
      name: map['name'] as String,
      rightDescription: map['rightDescription'] as String,
      wrongDescription: map['wrongDescription'] as String,
    );
  }

  @override
  String toString() =>
      'Terms(name: $name, rightDescription: $rightDescription, wrongDescription: $wrongDescription)';

  @override
  bool operator ==(covariant Terms other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.rightDescription == rightDescription &&
        other.wrongDescription == wrongDescription;
  }

  @override
  int get hashCode =>
      name.hashCode ^ rightDescription.hashCode ^ wrongDescription.hashCode;
}
