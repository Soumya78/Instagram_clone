import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';

import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
//import 'package:instagram_clone/views/constants/strings.dart';

@immutable
class LogOutDialog extends AlertDialogModel {
  const LogOutDialog()
      : super(
          title: Strings.logOut,
          message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
          buttons: const {Strings.cancel: false, Strings.logOut: true},
        );
}
