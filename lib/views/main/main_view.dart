import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:instagram_clone/state/auth/providers/auth_state_provider.dart';
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/image_upload/model/helpers/image_upload_helper.dart';
import 'package:instagram_clone/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_clone/views/components/dialogs/alert_dialog_model.dart';
import 'package:instagram_clone/views/components/dialogs/log_out_dialog.dart';
import 'package:instagram_clone/views/constants/strings.dart';
import 'package:instagram_clone/views/create_new_posts/create_new_posts_view.dart';
import 'package:instagram_clone/views/tabs/users_posts/user_posts_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              onPressed: () async {
                final vediofile =
                    await Imagepickerhelper.pickimagefromgallery();
                if (vediofile == null) {
                  return;
                } else {
                  ref.refresh(postsettingprovider);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Createnewpostsview(
                          filetopost: vediofile, fileType: FileType.video),
                    ),
                  );
                }
              },
              icon: const FaIcon(FontAwesomeIcons.film),
            ),
            IconButton(
              onPressed: () async {
                final imagefile =
                    await Imagepickerhelper.pickimagefromgallery();
                if (imagefile == null) {
                  return;
                } else {
                  ref.refresh(postsettingprovider);
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Createnewpostsview(
                          filetopost: imagefile, fileType: FileType.image),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add_photo_alternate_outlined),
            ),
            IconButton(
              onPressed: () async {
                final shouldlogout = await const LogOutDialog()
                    .present(context)
                    .then((value) => value ?? false);

                if (shouldlogout) {
                  await ref.read(authstateprovider.notifier).logout();
                }
              },
              icon: const Icon(Icons.logout),
            )
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.home),
            ),
          ]),
        ),
        body: const TabBarView(
            children: [UserPostsView(), UserPostsView(), UserPostsView()]),
      ),
    );
  }
}
