import 'dart:typed_data';

import 'package:binarium/posts/model/post_model.dart';
import 'package:dio/dio.dart';

class VApiClientPost {
  static Future<List<VPost>> getPost() async {
    try {
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      final response = await dio.get(
          'https://jerterop.space/api/v2/posts?perPage=100&page=1&token=$token');
      if (response.statusCode == 200) {
        final itemsDynamyc = response.data['items'] as List<dynamic>;
        final items =
            itemsDynamyc.map((e) => e as Map<String, dynamic>).toList();
        final posts = items.map((e) {
          return VPost.fromMap(e);
        }).toList();
        return posts;
      } else {
        // print('404');
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<void> addPost(
      {required String userToken,
      required String text,
      Uint8List? image,
      required String title}) async {
    try {
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      FormData? formData;
      if (image != null) {
        final multipartFile =
            MultipartFile.fromBytes(image, filename: 'avatar');
        formData = FormData.fromMap({
          'postPhoto': multipartFile,
          'postText': text,
          'postTitle': title,
        });
      } else {
        formData = FormData.fromMap({
          'postText': text,
          'postTitle': title,
        });
      }
      final response = await dio.post(
        'https://jerterop.space/api/v2/posts/create?userToken=$userToken&postText=$text&postTitle=$title&token=$token',
        data: formData,
      );
      if (response.statusCode == 200) {
        response.data != null ? print('addpost: ${response.data}') : null;
      } else {
        print('error post posts');
      }
    } catch (e) {
      print('post add $e');
    }
  }

  static Future<bool> delPost(
      {required String userToken, required int id}) async {
    try {
      const token = 'b557fb0b-fb1c-4d5f-88f0-dd7e8475ae8d';
      final dio = Dio();
      final response = await dio.post(
          'https://jerterop.space/api/v2/posts/delete?userToken=$userToken&postId=$id&token=$token');
      if (response.statusCode == 200) {
        response.data != null ? print('addpost: ${response.data}') : null;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('post add $e');
      return false;
    }
  }
}
