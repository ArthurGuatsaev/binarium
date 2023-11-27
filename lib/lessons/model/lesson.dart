class Lesson {
  final String title;
  final String image;
  final String description;
  Lesson({
    required this.title,
    required this.image,
    required this.description,
  });

  Lesson copyWith({
    String? title,
    String? image,
    String? description,
  }) {
    return Lesson(
      title: title ?? this.title,
      image: image ?? this.image,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'description': description,
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    try {
      final image = map['resultImage'];
      final segments = map['resultSegments'] as List<dynamic>;
      final items = segments
          .map(
            (e) => e as Map<String, dynamic>,
          )
          .toList();
      final title = items.first['resultSubTitle'] as String;
      final description = items.first['resultText'] as String;
      return Lesson(
        title: title,
        image: image,
        description: description,
      );
    } catch (e) {
      return Lesson(title: '', image: '', description: '');
    }
  }

  @override
  String toString() =>
      'Lesson(title: $title, image: $image, description: $description)';

  @override
  bool operator ==(covariant Lesson other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.image == image &&
        other.description == description;
  }

  @override
  int get hashCode => title.hashCode ^ image.hashCode ^ description.hashCode;

  List<String> get abc {
    String init = description;
    List<String> result = [];
    for (var i = 0; i < 10; i++) {
      int index = init.indexOf('\r\n\r\n');
      if (index < 0) break;
      String first = init.substring(0, index);
      if (init.length > index + 4) index += 4;
      init = init.substring(index);
      if (first.contains('\n')) first.substring(2);
      if (first.length > 20) result.add(first);
    }
    return result;
  }
}
