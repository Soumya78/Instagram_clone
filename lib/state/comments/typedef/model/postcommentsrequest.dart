
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/enums/datesorting.dart';
import 'package:instagram_clone/state/image_upload/model/typedef/post_id.dart';


@immutable
class RequestForPostAndComments {
  final PostId postid;
  final bool sortByCreatedAt;
  final Datesorting dateSorting;
  final int? limit;
  const RequestForPostAndComments({
    required this.postid,
    this.sortByCreatedAt = true,
    this.dateSorting = Datesorting.newestontop,
    this.limit,
  });

  @override
  bool operator ==(covariant RequestForPostAndComments other) =>
      postid == other.postid &&
          sortByCreatedAt == other.sortByCreatedAt &&
          dateSorting == other.dateSorting &&
          limit == other.limit;

  @override
  int get hashCode => Object.hashAll(
    [
      postid,
      sortByCreatedAt,
      dateSorting,
      limit,
    ],
  );
}
