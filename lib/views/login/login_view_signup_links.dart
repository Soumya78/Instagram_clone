import 'package:flutter/material.dart';

import 'package:instagram_clone/views/components/rich_text.dart/base_text.dart';
import 'package:instagram_clone/views/components/rich_text.dart/rich_text_widgets.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignupLinks extends StatelessWidget {
  const LoginViewSignupLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleforAll:
          Theme.of(context).textTheme.titleSmall?.copyWith(height: 1.5),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
          text: Strings.facebook,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.facebookSignupUrl),
            );
          },),
        BaseText.plain(text: Strings.orCreateAnAccountOn),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.googleSignupUrl),
            );
          }),
      ],
    );
  }
}
