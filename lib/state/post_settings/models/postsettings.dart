import 'package:instagram_clone/state/post_settings/constants/constants.dart';

enum Postsettings {
  allowlikes(
      title: Constants.allowLikestitles,
      description: Constants.allowLikestitlesdescription,
      storagekey: Constants.allowlikesStoragekey),
  allowcomments(
      title: Constants.allowCommentsTitle,
      description: Constants.allowCommentsDescription,
      storagekey: Constants.allowCommentsStoragekey);

  final String title;
  final String description;
  final String storagekey;

  const Postsettings(
      {required this.title,
      required this.description,
      required this.storagekey});
}
