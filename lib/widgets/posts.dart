import 'package:flutter/material.dart';
import 'package:ig_clone/widgets/post_card.dart';

class PostsList extends StatelessWidget {
  const PostsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return PostCard(index: index);
      },
    );
  }
}
