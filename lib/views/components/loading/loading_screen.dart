import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/constants/strings.dart';
import 'package:instagram_clone/views/components/loading/loading_screen_controller.dart';
import 'dart:developer' as devtools show log;
extension Log on Object{
  void log() => devtools.log(toString());
}

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;
  void show({required BuildContext context, String x = Strings.loading}) {
    if(_controller?.updateloadingscreen(x) ?? false){
      return;
      
    }else{
      _controller = showoverlay(context: context, text: x);
    }
  }
  void hide() {
    _controller?.closeloadingscreen();
    _controller = null;
  }

  LoadingScreenController? showoverlay({
    required BuildContext context,
    required String text,
  }) {
    final state = Overlay.of(context);
    final textcontroller = StreamController<String>();
    textcontroller.add(text);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    size.log();

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: size.width * 0.9,
                  maxHeight: size.width * 0.8,
                  ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<String>(
                        stream: textcontroller.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.requireData,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.black),
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    state.insert(overlay);
    return LoadingScreenController(
      closeloadingscreen: () {
        textcontroller.close();
        overlay.remove();
        return true;
      },
      updateloadingscreen: (text) {
        textcontroller.add(text);
        return true;
      },
    );
  }
}
