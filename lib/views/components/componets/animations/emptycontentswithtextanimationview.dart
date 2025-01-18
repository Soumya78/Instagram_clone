import 'package:flutter/material.dart';
import 'package:instagram_clone/views/components/componets/animations/emptycontentsanimationview.dart';

class Emptycontentswithtextanimationview extends StatelessWidget {
  final String text;
  const Emptycontentswithtextanimationview({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20,20,0),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const Emptycontentsanimationview()
        ],
      ),
    );
  }
}
