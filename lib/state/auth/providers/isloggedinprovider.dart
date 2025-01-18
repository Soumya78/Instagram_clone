import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/model/auth_result.dart';

import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';

final isloggedinprovider = Provider<bool>((ref) {
  final authstate = ref.watch(authstateprovider);
  return authstate.authresult == AuthResult.sucess;
});
