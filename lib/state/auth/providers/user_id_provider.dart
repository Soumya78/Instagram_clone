import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/typedef/post/user_id.dart';

final useridprovider = Provider<Userid?>((ref)=> ref.watch(authstateprovider).userid);