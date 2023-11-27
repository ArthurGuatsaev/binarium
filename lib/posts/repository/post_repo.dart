import 'dart:async';
import 'dart:typed_data';

import 'package:binarium/loading/domain/model/loading_model.dart';
import 'package:binarium/posts/model/note_model.dart';
import 'package:binarium/posts/model/post_model.dart';
import 'package:binarium/posts/repository/api_post.dart';
import 'package:isar/isar.dart';

abstract class VBasePostRepo {
  Future<void> addPost(
      {required String userToken,
      Uint8List? image,
      required String text,
      required String title});
  Future<List<VPost>> getPost();
  Future<void> delPost({required String userToken, required int id});
}

class VPostRepo extends VBasePostRepo {
  final Isar isar;
  final StreamController<String> errorController;
  VPostRepo({required this.errorController, required this.isar});
  @override
  Future<void> addPost(
      {required String userToken,
      required String text,
      Uint8List? image,
      required String title}) async {
    VApiClientPost.addPost(
        userToken: userToken, text: text, title: title, image: image);
  }

  @override
  Future<void> delPost({required String userToken, required int id}) async {
    await VApiClientPost.delPost(userToken: userToken, id: id);
  }

  @override
  Future<List<VPost>> getPost() async {
    return VApiClientPost.getPost();
  }

  List<VNotesIssar>? notes;

  // Stream noteStream() => _isar!.vNotes.watchLazy();
  Future<List<VNotesIssar>> getNote(
      StreamController<VLoading> controller) async {
    final items = await isar.vNotesIssars.where().findAll();
    notes = items;
    controller.add(VLoading.notes);
    return notes ?? [];
  }

  Future<List<VNotesIssar>> getNoteUpdata() async {
    notes = await isar.vNotesIssars.where().findAll();
    return notes ?? [];
  }

  Future<void> saveNote({required VNotesIssar note}) async {
    await isar.writeTxn(() async {
      await isar.vNotesIssars.put(note);
    });
  }

  Future<void> deleteNote(VNotesIssar note) async {
    await isar.writeTxn(() async {
      await isar.vNotesIssars.delete(note.id); // delete
    });
  }
}
