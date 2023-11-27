// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

abstract class PostEvent {
  const PostEvent();
}

class GetPostsEvent extends PostEvent {}

class StreamNoteEvent extends PostEvent {}

class GetNotesEvent extends PostEvent {}

class UpdateNotesEvent extends PostEvent {}

class PostImageEvent extends PostEvent {}

class InitialPostEvent extends PostEvent {}

class AddPostsEvent extends PostEvent {
  final String title;
  final String userToken;
  final String text;
  final MyUser user;
  const AddPostsEvent({
    required this.title,
    required this.user,
    required this.userToken,
    required this.text,
  });
}

class SaveNoteEvent extends PostEvent {
  final VNotesIssar note;
  SaveNoteEvent({
    required this.note,
  });
}

class DelPostsEvent extends PostEvent {
  final String userToken;
  final int id;
  DelPostsEvent({
    required this.userToken,
    required this.id,
  });
}

class FindCurrentPost extends PostEvent {
  final int index;
  FindCurrentPost({
    required this.index,
  });
}

class DelNoteEvent extends PostEvent {
  final VNotesIssar note;
  DelNoteEvent({
    required this.note,
  });
}
