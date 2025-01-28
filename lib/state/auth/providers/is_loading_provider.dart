import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/providers/delete_comments_provider.dart';
import 'package:instagram_clone/state/comments/typedef/notifiers/providers/send_comment_provider.dart';
import 'package:instagram_clone/state/image_upload/model/providers/image_upload_provider.dart';

import '../../posts/providers/delete_post_providers.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authstate = ref.watch(authstateprovider);
  final isuploadingimage = ref.watch(imageUplaodProvider);
  final issendingcomment = ref.watch(sendcommentprovider);
  final isdeleteingcomment = ref.watch(deletecommentprovider);
  final isdeleteingpost = ref.watch(deletepostprovider);
  return authstate.isLoading ||
      isuploadingimage ||
      issendingcomment ||
      isdeleteingpost ||
      isdeleteingcomment;
});
