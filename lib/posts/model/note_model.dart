// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:binarium/trade/ui/history_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:isar/isar.dart';

part 'note_model.g.dart';

// class VNote {
//   final int iD;
//   final String title;
//   final String body;
//   final DateTime date;
//   VNote({
//     required this.iD,
//     required this.title,
//     required this.body,
//     required this.date,
//   });

//   VNote copyWith({
//     int? iD,
//     String? title,
//     String? body,
//     DateTime? date,
//   }) {
//     return VNote(
//       iD: iD ?? this.iD,
//       title: title ?? this.title,
//       body: body ?? this.body,
//       date: date ?? this.date,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'iD': iD,
//       'title': title,
//       'body': body,
//       'date': date.millisecondsSinceEpoch,
//     };
//   }

//   // static VNote fromIssar(VNote e) {
//   //   return VNote(
//   //       body: e.body, date: e.date, iD: e.iD, title: e.title, newId: e.id);
//   // }

//   factory VNote.fromMap(Map<String, dynamic> map) {
//     return VNote(
//       iD: map['iD'] as int,
//       title: map['title'] as String,
//       body: map['body'] as String,
//       date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
//     );
//   }

//   @override
//   String toString() {
//     return 'VNote(iD: $iD, title: $title, body: $body, date: $date)';
//   }

//   @override
//   bool operator ==(covariant VNote other) {
//     if (identical(this, other)) return true;

//     return other.iD == iD &&
//         other.title == title &&
//         other.body == body &&
//         other.date == date;
//   }

//   @override
//   int get hashCode {
//     return iD.hashCode ^ title.hashCode ^ body.hashCode ^ date.hashCode;
//   }

//   String toJson() => json.encode(toMap());

//   factory VNote.fromJson(String source) =>
//       VNote.fromMap(json.decode(source) as Map<String, dynamic>);
// }

@collection
class VNotesIssar {
  Id id = Isar.autoIncrement;
  String? title;
  String? body;
  int? iD;
  DateTime? date;
  String get weekDay {
    if (date == null) return '01';
    return DateFormat('EEEE', 'en').format(date!);
  }

  String get month {
    if (date == null) return 'March';
    final month = date!.month.monthString;
    return month;
  }

  int get year {
    if (date == null) return 2023;
    final year = date!.year;
    return year;
  }

  String get uiDate {
    return 'on $weekDay in $month $year';
  }
}
