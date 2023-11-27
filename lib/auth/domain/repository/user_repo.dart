// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:binarium/auth/data/api_client_auth.dart';
import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepo extends BaseAuth {
  UserRepo({required super.errorController});
  MyUser? myUser;
  final String user = 'user';
  final String userKey = 'user_name';
  final String points = 'points';
  final String imagePathKey = 'images_path';
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();

  @override
  Future<void> signUp(
      {required String name,
      required String password,
      required StreamController userController}) async {
    try {
      final userName = (await prefs).getString(name);
      if (userName != null) {
        throw UserRegExp(
            message: 'A user with this name has already been registered');
      }
      if (password.length < 6) {
        throw UserRegExp(message: 'The password is too short');
      }
      final login = name;
      final token = '$login$login-123';
      final regin = await AuthApiClient.reg(
          name: name,
          errorController: errorController,
          login: login,
          password: password,
          userToken: token,
          country: 'USA');
      if (regin) {
        (await prefs).setString(user, login);
        (await prefs).setString(login, password);
        (await prefs).setString(userKey + login, name);
        (await prefs).setInt('$login$points', 5000);
        (await prefs).setString('${login}token', token);
        myUser =
            MyUser(login: login, name: name, password: password, token: token);
        userController.add(myUser);
      } else {}
    } on UserRegExp catch (e) {
      errorController.add(e.message);
    } catch (e) {
      errorController.add(e.toString());
    }
  }

  Future<void> changeUserData({required MyUser userV}) async {
    (await prefs).remove(userKey + myUser!.login);
    (await prefs).remove(myUser!.login);

    (await prefs).setString(myUser!.login, userV.password);
    (await prefs).setString(userKey + myUser!.login, userV.name);

    myUser = userV;
    await AuthApiClient.updateAccount(
        userToken: myUser!.token,
        image: myUser!.image,
        password: myUser!.password,
        name: myUser!.name,
        errorController: errorController);
    print(myUser);
  }

  Future<void> setImage({required XFile image, required String name}) async {
    (await prefs).remove('${myUser!.login}$imagePathKey');
    final path = await getApplicationDocumentsDirectory();
    final String imgpath = path.path;
    final date = DateTime.now();
    await image.saveTo('$imgpath/${date.millisecond}.jpeg');
    (await prefs).setString(
        '${myUser!.login}$imagePathKey', '/${date.millisecond}.jpeg');
    final newImage = await getImage(
        prefs: prefs, imagePathKey: '${myUser!.login}$imagePathKey');
    myUser = myUser!.copyWith(image: newImage);
  }

  Future<void> saveUserPoints({required int point}) async {
    (await prefs).setInt(points, point);
  }

  @override
  Future<void> deleteAccount(
      {required StreamController<MyUser> userController}) async {
    final isA = await AuthApiClient.deleteAccount(
        userToken: myUser!.token, errorController: errorController);
    if (!isA) return;
    (await prefs).remove(myUser!.login);
    (await prefs).remove(userKey + myUser!.login);
    (await prefs).remove('${myUser!.login}$imagePathKey');
    (await prefs).remove('${myUser!.login}$points');
    (await prefs).remove('${myUser!.login}token');
    (await prefs).remove(user);
    userController.add(MyUser(name: ''));
  }

  @override
  Future<void> clearAllData() async {
    (await prefs).clear();
  }

  @override
  Future<void> logOut(StreamController<MyUser> controller) async {
    (await prefs).remove(user);
    controller.add(MyUser(name: ''));
  }

  @override
  Future<void> signIn(
      {required String name,
      required String password,
      required StreamController userController}) async {
    try {
      if (name.isEmpty || password.isEmpty) {
        throw UserRegExp(message: 'Please, enter the correct data');
      }
      final userPassword = (await prefs).getString(name);
      if (userPassword == null) {
        throw UserRegExp(message: 'There is no user with this name');
      }
      if (userPassword != password) {
        throw UserRegExp(message: 'Incorrect password');
      }
      (await prefs).setString(user, name);
      final token = (await prefs).getString('${name}token');
      final userName = (await prefs).getString(userKey + name);
      final point = (await prefs).getInt(points + name);
      final image =
          await getImage(prefs: prefs, imagePathKey: '$name$imagePathKey');
      myUser = MyUser(
          login: name,
          name: userName ?? '',
          image: image,
          points: point ?? 5000,
          password: password,
          token: token ?? 'this is token');
      userController.add(myUser);
    } on UserRegExp catch (e) {
      errorController.add(e.message);
    } catch (e) {
      errorController.add(e.toString());
    }
  }

  @override
  Future<bool> isAuth() async =>
      (await prefs).getString(user) != null ? true : false;

  @override
  Future<MyUser> getUser({StreamController<VLoading>? controller}) async {
    try {
      final login = (await prefs).getString(user);
      final name = (await prefs).getString(userKey + login!);
      final password = (await prefs).getString(login);
      final token = (await prefs).getString('${login}token');
      final image =
          await getImage(prefs: prefs, imagePathKey: '$login$imagePathKey');
      final point = (await prefs).getInt('$login$points');
      myUser = MyUser(
          login: login,
          name: name ?? '',
          token: token!,
          image: image,
          password: password!,
          points: point ?? 10000);

      controller?.add(VLoading.getUser);
      return myUser!;
    } on UserRegExp catch (e) {
      errorController.add(e.message);
      return MyUser();
    } catch (e) {
      errorController.add(e.toString());
      return MyUser();
    }
  }

  Future<FileImage?> getImage(
      {required Future<SharedPreferences> prefs,
      required String imagePathKey}) async {
    try {
      final localPath = (await prefs).getString(imagePathKey);
      if (localPath == null) {
        return null;
      }
      final path = await getApplicationDocumentsDirectory();
      return FileImage(File(path.path + localPath));
    } catch (e) {
      throw ImagePathExc(message: 'image get exeption');
    }
  }
}

abstract class BaseAuth {
  final StreamController<String> errorController;
  BaseAuth({required this.errorController});
  Future<void> signUp({
    required String name,
    required String password,
    required StreamController<MyUser> userController,
  });
  Future<void> signIn({
    required String name,
    required String password,
    required StreamController<MyUser> userController,
  });
  Future<void> deleteAccount(
      {required StreamController<MyUser> userController});
  Future<void> logOut(StreamController<MyUser> controller);
  Future<bool> isAuth();
  Future<MyUser> getUser({StreamController<VLoading>? controller});
  Future<void> clearAllData();
}

class UserRegExp implements Exception {
  final String message;

  UserRegExp({required this.message});
}

mixin MyAuthLocal {
  final StreamController<String> errorController = StreamController();
}

class UserAuthExc implements Exception {
  final String message;
  UserAuthExc({
    required this.message,
  });
}

class ImagePathExc implements Exception {
  final String message;
  ImagePathExc({
    required this.message,
  });
}
