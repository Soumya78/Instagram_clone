import 'package:flutter/material.dart'show immutable;

import 'package:instagram_clone/views/components/constants/strings.dart';
import 'alert_dialog_model.dart';

@immutable
class DeleteDialog extends AlertDialogModel <bool>{
DeleteDialog({
    required String titleofobjecttodelete,
    
  }) : super(
    title: '${Strings.delete} $titleofobjecttodelete?',
    message: '${Strings.areYouSureYouWantToDeleteThis} $titleofobjecttodelete?',
    buttons: {
     Strings.delete: false,
      Strings.cancel: false,
    },
  );
}