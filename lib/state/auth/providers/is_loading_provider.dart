import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/image_upload/model/providers/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref){
  final authstate = ref.watch(authstateprovider);
  final isuploadingimage = ref.watch(imageUplaodProvider);
  return authstate.isLoading || isuploadingimage;
});