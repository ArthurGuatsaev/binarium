// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyUser {
  FileImage? image;
  final String name;
  final String login;
  final int points;
  final String token;
  final String password;
  MyUser({
    this.image,
    this.password = '',
    this.token = '',
    this.login = '',
    this.name = '',
    this.points = 5000,
  });

  MyUser copyWith(
      {String? name,
      String? token,
      String? login,
      String? password,
      int? points,
      FileImage? image}) {
    return MyUser(
      name: name ?? this.name,
      token: token ?? this.token,
      login: login ?? this.login,
      image: image ?? this.image,
      password: password ?? this.password,
      points: points ?? this.points,
    );
  }

  Image get convert {
    if (image == null) {
      return Image(image: Image.asset('assets/images/boroda.png').image);
    }
    return Image(image: Image.file(image!.file).image);
  }
}
