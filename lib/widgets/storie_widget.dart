import 'package:flutter/material.dart';
import 'package:ig_clone/widgets/avatar_story.dart';

class StoryPreview extends StatelessWidget {
  const StoryPreview({
    Key? key,
    required this.title,
    required this.size,
    required this.index,
    this.unseen = true,
  }) : super(key: key);

  final String title;
  final double size;
  final int index;
  final bool unseen;

  @override
  Widget build(BuildContext context) {
    const txtStyle = TextStyle(
      fontFamily: 'SF UI Display',
      fontWeight: FontWeight.w400,
      fontSize: 11.5,
      fontStyle: FontStyle.normal,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            UserStory(
              unseen: unseen,
              index: index,
              size: size,
              outlinedWidth: 4.4,
              paddingStory: 3,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(title, overflow: TextOverflow.ellipsis, style: txtStyle)
          ],
        ),
      ),
    );
  }
}
