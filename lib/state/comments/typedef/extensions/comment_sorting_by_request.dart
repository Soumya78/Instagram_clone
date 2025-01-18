import 'package:instagram_clone/enums/datesorting.dart';
import 'package:instagram_clone/state/comments/typedef/model/comment.dart';
import 'package:instagram_clone/state/comments/typedef/model/postcommentsrequest.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> applysortingfrom(RequestForPostAndComments request) {
    if (request.sortByCreatedAt) {
      final sorteddocuments = toList()
        ..sort((a, b) {
          switch (request.dateSorting) {
            case Datesorting.newestontop:
              return b.createdAt.compareTo(a.createdAt);
            // TODO: Handle this case.
            case Datesorting.oldestontop:
              // TODO: Handle this case.
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sorteddocuments;
    } else {
      return this;
    }
  }
}
