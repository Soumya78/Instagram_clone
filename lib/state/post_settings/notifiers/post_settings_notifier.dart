import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';

class PostsettingNotifier extends StateNotifier<Map<Postsettings, bool>> {
  PostsettingNotifier()
      : super(UnmodifiableMapView({
          for (final settings in Postsettings.values) settings: true,
        }));

  void setsettings(Postsettings settings, bool value) {
    final existingvalue = state[settings];
    if(existingvalue == null || existingvalue == value){
      return;
    }else{
      state = Map.unmodifiable(Map.from(state)..[settings] = value);
    }

  }
}
