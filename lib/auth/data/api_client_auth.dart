import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthApiClient {
  static Future<bool> reg(
      {required String name,
      required StreamController<String> errorController,
      required String password,
      required String login,
      required String country,
      required String userToken}) async {
    try {
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      final response = await dio.post(
          'https://jerterop.space/api/v2/new/register?name=$name&login=$login&password=$password&country=$country&userToken=$userToken&token=$token');
      if (response.statusCode == 200) {
        response.data != null ? print('auth: ${response.data}') : null;
        if (response.data['error'] != null) {
          errorController.add('User login exists');
          return false;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      errorController.add('Check your internet connection');
      return false;
    }
  }

  static Future<bool> deleteAccount(
      {required String userToken,
      required StreamController<String> errorController}) async {
    try {
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      final response = await dio.post(
          'https://jerterop.space/api/v2/user/delete?userToken=$userToken&token=$token');
      if (response.statusCode == 200) {
        response.data != null ? print('delete: ${response.data}') : null;
        return true;
      } else {
        return false;
      }
    } catch (_) {
      errorController.add('Check your internet connection');
      return false;
    }
  }

  static Future<bool> updateAccount(
      {required String userToken,
      required FileImage? image,
      required String password,
      required String name,
      required StreamController<String> errorController}) async {
    try {
      if (image == null) return false;
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      final bytes = await image.file.readAsBytes();
      final multipartFile = MultipartFile.fromBytes(bytes, filename: 'avatar');
      final formData = FormData.fromMap({'avatar': multipartFile});
      final response = await dio.post(
        'https://jerterop.space/api/v2/new/update?name=$name&password=$password&country=USA&userToken=$userToken&token=$token',
        data: formData,
      );
      if (response.statusCode == 200) {
        response.data != null ? print('update: ${response.data}') : null;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      errorController.add('Check your internet connection');
      return false;
    }
  }
}
