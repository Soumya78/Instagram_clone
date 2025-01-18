import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/auth/auth_state_notifier.dart';
import 'package:instagram_clone/state/auth/model/auth_state.dart';

final authstateprovider = StateNotifierProvider<AuthstateNotifier, AuthState>(
  (_) => AuthstateNotifier(),
);
