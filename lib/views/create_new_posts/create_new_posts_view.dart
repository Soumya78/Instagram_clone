import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/state/auth/providers/user_id_provider.dart';
import 'package:instagram_clone/state/image_upload/model/filetype.dart';
import 'package:instagram_clone/state/image_upload/model/providers/image_upload_provider.dart';
import 'package:instagram_clone/state/image_upload/model/thumbnailrequest.dart';
import 'package:instagram_clone/state/post_settings/models/postsettings.dart';
import 'package:instagram_clone/state/post_settings/providers/post_settings_provider.dart';
import 'package:instagram_clone/views/components/Filethumbnailview.dart';
import 'package:instagram_clone/views/constants/strings.dart';

class Createnewpostsview extends StatefulHookConsumerWidget {
  final File filetopost;

  final FileType fileType;

  const Createnewpostsview(
      {Key? key, required this.filetopost, required this.fileType})
      : super(key: key);

  @override
  ConsumerState<Createnewpostsview> createState() => _CreatenewpostsviewState();
}

class _CreatenewpostsviewState extends ConsumerState<Createnewpostsview> {
  @override
  Widget build(BuildContext context) {
    final thumbanilRequest =
        Thumbnailrequest(file: widget.filetopost, fileType: widget.fileType);
    final postsettings = ref.watch(postsettingprovider);
    final postController = useTextEditingController();
    final ispostbuttonenabled = useState(false);
    useEffect(() {
      void listener() {
        ispostbuttonenabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            onPressed: ispostbuttonenabled.value
                ? () async {
                    final userid = ref.read(useridprovider);
                    if (userid == null) {
                      return;
                    }
                    final message = postController.text;

                    final isuploaded = await ref
                        .read(imageUplaodProvider.notifier)
                        .upload(
                            file: widget.filetopost,
                            filetype: widget.fileType,
                            message: message,
                            postsettings: postsettings,
                            userid: userid);
                    print(isuploaded);

                    if (isuploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Filethumbnailview(thumbnailrequest: thumbanilRequest),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                    labelText: Strings.pleaseWriteYourMessageHere),
                autofocus: true,
                maxLines: null,
                controller: postController,
              ),
            ),
            ...Postsettings.values.map(
              (postsetting) => ListTile(
                title: Text(postsetting.title),
                subtitle: Text(postsetting.description),
                trailing: Switch(
                  value: postsettings[postsetting] ?? false,
                  onChanged: (isOn) {
                    ref
                        .read(postsettingprovider.notifier)
                        .setsettings(postsetting, isOn);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // Use hooks like useState for local state management
  }
}
