import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/state/comments/typedef/model/comment.dart';
import 'package:instagram_clone/state/typedef/post/post.dart';

@immutable
class PostwithcommentModel {
  final Post post;

  final Iterable<Comment> comment;

  const PostwithcommentModel({required this.post, required this.comment});

  @override
  bool operator ==(covariant PostwithcommentModel other) =>
      post == other.post &&
      const IterableEquality().equals(comment, other.comment);

  @override
  // TODO: implement hashCode
  int get hashCode => Object.hashAll([post, comment]);
}
