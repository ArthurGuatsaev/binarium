// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'post_bloc.dart';

class PostState {
  final List<VPost> posts;
  final List<VNotesIssar> notes;
  final VPost currentPost;
  final Uint8List? postImage;
  PostState({
    this.currentPost = const VPost.initial(),
    this.posts = const [],
    this.notes = const [],
    this.postImage,
  });

  PostState copyWith({
    List<VPost>? posts,
    List<VNotesIssar>? notes,
    Uint8List? postImage,
    VPost? currentPost,
  }) {
    return PostState(
      currentPost: currentPost ?? this.currentPost,
      posts: posts ?? this.posts,
      postImage: postImage,
      notes: notes ?? this.notes,
    );
  }

  Map<int, List<VNotesIssar>> get currentNotes {
    Map<int, List<VNotesIssar>> currentNotes = {};
    notes.map((e) {
      currentNotes[e.iD!] =
          notes.where((element) => element.iD == e.iD).toList();
    }).toList();
    return currentNotes;
  }

  Image? get convert {
    if (postImage == null) {
      return null;
    }
    return Image(image: Image.memory(postImage!).image);
  }
}
