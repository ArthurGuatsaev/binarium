// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:binarium/trade/ui/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:intl/intl.dart';

class VPost {
  final int id;
  final String title;
  final Image? image;
  final String body;
  final String date;
  final PostAuthor author;
  const VPost({
    required this.id,
    required this.title,
    required this.image,
    required this.body,
    required this.date,
    required this.author,
  });
  const VPost.initial(
      {this.id = 0,
      this.body = '',
      this.date = '',
      this.image,
      this.title = '',
      this.author = const PostAuthor(name: '')});
  VPost copyWith({
    int? id,
    String? title,
    Image? image,
    String? body,
    String? date,
    PostAuthor? author,
  }) {
    return VPost(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      body: body ?? this.body,
      date: date ?? this.date,
      author: author ?? this.author,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resultId': id,
      'resultTitle': title,
      'resultPhoto': image,
      'resultText': body,
      'resultDate': date,
      'author': author.toMap(),
    };
  }

  factory VPost.fromMap(Map<String, dynamic> map) {
    Image? image;
    if (map['resultPhoto'] != null) {
      final str = map['resultPhoto'];
      var avatar = Image(
        image: NetworkImageWithRetry(str),
      );
      image = avatar;
    }
    return VPost(
      id: map['resultId'] as int,
      title: map['resultTitle'] != null ? map['resultTitle'] as String : '',
      image: image,
      body: map['resultText'] != null ? map['resultText'] as String : '',
      date: map['resultDate'] as String,
      author: PostAuthor.fromMap(map['resultAuthor'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'VPost(id: $id, title: $title, image: $image, body: $body, date: $date, author: $author)';
  }

  @override
  bool operator ==(covariant VPost other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.image == image &&
        other.body == body &&
        other.date == date &&
        other.author == author;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        image.hashCode ^
        body.hashCode ^
        date.hashCode ^
        author.hashCode;
  }

  String get weekDay {
    if (DateTime.tryParse(date) != null) {
      return DateFormat('EEEE', 'en').format(DateTime.tryParse(date)!);
    }
    final day = int.tryParse(date.substring(0, 2));
    final month = int.tryParse(date.substring(3, 5));
    final year = int.tryParse(date.substring(6, 10));
    final d = DateTime(year!, month!, day!);
    return DateFormat('EEEE', 'en').format(d);
  }

  String get month {
    if (DateTime.tryParse(date) != null) {
      return DateTime.tryParse(date)!.month.monthString;
    }
    final month = int.tryParse(date.substring(3, 5));
    return month!.monthString;
  }

  String get uiDateFormat {
    if (date.isEmpty) return '01';
    final day = int.tryParse(date.substring(0, 2));
    return '$day.$month.$year';
  }

  String get year {
    if (DateTime.tryParse(date) != null) {
      return '${DateTime.tryParse(date)!.year}';
    }
    final year = date.substring(6, 10);
    return year;
  }

  String get uiDate {
    return 'on $weekDay in $month $year';
  }

  String get postTime {
    if (DateTime.tryParse(date) != null) {
      return '${DateTime.tryParse(date)!.hour}: ${DateTime.now().minute}';
    }
    if (date.isEmpty) return '2023';
    return date.substring(10, 16);
  }
}

class PostAuthor {
  final String name;
  final Image? image;
  const PostAuthor({
    required this.name,
    this.image,
  });

  PostAuthor copyWith({
    String? name,
    Image? image,
  }) {
    return PostAuthor(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'resultUserName': name,
      'resultUserPhoto': image,
    };
  }

  factory PostAuthor.fromMap(Map<String, dynamic> map) {
    Image? image;
    if (map['resultUserPhoto'] != null) {
      final str = map['resultUserPhoto'];
      var avatar = Image(
        image: NetworkImageWithRetry(str),
      );
      image = avatar;
    }
    return PostAuthor(
      name: map['resultUserName'] as String,
      image: image,
    );
  }

  @override
  String toString() => 'PostAuthor(name: $name, image: $image)';

  @override
  bool operator ==(covariant PostAuthor other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode;
}
