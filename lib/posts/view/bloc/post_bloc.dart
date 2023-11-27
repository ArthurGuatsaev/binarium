import 'dart:typed_data';

import 'package:binarium/auth/domain/model/user.dart';
import 'package:binarium/posts/model/note_model.dart';
import 'package:binarium/posts/model/post_model.dart';
import 'package:binarium/posts/repository/post_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final VBasePostRepo postRepo;
  PostBloc({required this.postRepo}) : super(PostState()) {
    on<GetPostsEvent>(onGetPosts);
    on<AddPostsEvent>(onAddPosts);
    on<DelPostsEvent>(onDelPosts);
    on<SaveNoteEvent>(onSaveNote);
    on<GetNotesEvent>(onGetNotes);
    on<FindCurrentPost>(onFindCurrentPost);
    on<DelNoteEvent>(onDelNote);
    on<UpdateNotesEvent>(onUpdateNotes);
    on<PostImageEvent>(onPostImage);
    on<InitialPostEvent>(initialPost);
  }
  onGetPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    final posts = await (postRepo as VPostRepo).getPost();
    emit(state.copyWith(posts: posts));
  }

  onAddPosts(AddPostsEvent event, Emitter<PostState> emit) async {
    await postRepo.addPost(
        text: event.text,
        title: event.title,
        image: state.postImage,
        userToken: event.userToken);
    final posts = [...state.posts];
    posts.insert(
        0,
        VPost(
            id: 1,
            title: event.title,
            body: event.text,
            image: state.convert,
            date: DateTime.now().toString(),
            author: PostAuthor(name: 'name', image: event.user.convert)));
    add(InitialPostEvent());
    emit(state.copyWith(posts: posts));
  }

  onDelPosts(DelPostsEvent event, Emitter<PostState> emit) async {
    await postRepo.delPost(userToken: event.userToken, id: event.id);
    add(GetPostsEvent());
  }

  onSaveNote(SaveNoteEvent event, Emitter<PostState> emit) async {
    await (postRepo as VPostRepo).saveNote(note: event.note);
    await (postRepo as VPostRepo).getNoteUpdata();
    add(GetNotesEvent());
  }

  onGetNotes(GetNotesEvent event, Emitter<PostState> emit) async {
    final notes = [...(postRepo as VPostRepo).notes!];
    emit(state.copyWith(notes: notes));
  }

  onUpdateNotes(UpdateNotesEvent event, Emitter<PostState> emit) async {
    await (postRepo as VPostRepo).getNoteUpdata();
    final notes = (postRepo as VPostRepo).notes;
    emit(state.copyWith(notes: notes));
  }

  onFindCurrentPost(FindCurrentPost event, Emitter<PostState> emit) async {
    emit(state.copyWith(currentPost: state.posts[event.index]));
  }

  onDelNote(DelNoteEvent event, Emitter<PostState> emit) async {
    await (postRepo as VPostRepo).deleteNote(event.note);
    add(UpdateNotesEvent());
  }

  initialPost(InitialPostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(
      postImage: null,
    ));
  }

  onPostImage(PostImageEvent event, Emitter<PostState> emit) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      final postImage = await image!.readAsBytes();
      emit(state.copyWith(postImage: postImage));
    } catch (e) {
      emit(state);
    }
  }
}
