import 'package:flutter/material.dart';
import 'package:ig_clone/screens/story_screen.dart';
import 'package:ig_clone/widgets/instagram_swiper.dart';

class UserStory extends StatelessWidget {
  const UserStory({
    Key? key,
    required this.size,
    required this.outlinedWidth,
    required this.paddingStory,
    required this.index,
    this.unseen = true,
    this.heroEnabled = true,
  }) : super(key: key);

  final double size;
  final double outlinedWidth;
  final double paddingStory;
  final int index;
  final bool unseen;
  final bool heroEnabled;

  @override
  Widget build(BuildContext context) {
    final List<StoryModel> lista = List.generate(
        5,
        (index) => StoryModel(const Duration(seconds: 4),
            "https://picsum.photos/id/${index * 6}/500/500", false, index));
    return HeroMode(
      enabled: heroEnabled,
      child: Hero(
        tag: index,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print(index);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InstagramSwiper(
                        initialPage: 0,
                        children: [
                          StoryScreen(
                            lista: lista,
                            color: Colors.green,
                          ),
                          StoryScreen(
                            lista: lista,
                            color: Colors.yellow,
                          ),
                          StoryScreen(
                            lista: lista,
                            color: Colors.red,
                          ),
                          StoryScreen(
                            lista: lista,
                            color: Colors.indigo,
                          ),
                        ],
                      ),
                  settings: RouteSettings(arguments: {'index': index})),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              _StorieOutlinedBorder(
                size: size,
                isUnseen: unseen,
              ),
              _CirclePreview(
                index: index,
                size: size,
                outlinedWidth: outlinedWidth,
                paddingStory: paddingStory,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StorieOutlinedBorder extends StatelessWidget {
  const _StorieOutlinedBorder({
    Key? key,
    required this.size,
    this.isUnseen = true,
  }) : super(key: key);

  final double size;
  final bool isUnseen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: !isUnseen ? Colors.grey[300] : null,
          gradient: isUnseen
              ? const LinearGradient(stops: [
                  0.2,
                  0.4,
                  0.7
                ], colors: [
                  Color.fromRGBO(211, 0, 197, 1),
                  Color(0xffDE0046),
                  Color(0xffF7A34B),
                ], begin: Alignment.topRight, end: Alignment.bottomLeft)
              : null),
    );
  }
}

class _CirclePreview extends StatelessWidget {
  const _CirclePreview({
    Key? key,
    required this.size,
    required this.outlinedWidth,
    required this.paddingStory,
    required this.index,
  }) : super(key: key);

  final double size;
  final double outlinedWidth;
  final double paddingStory;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(100),
      child: Container(
        padding: EdgeInsets.all(paddingStory),
        color: Colors.white,
        height: size - outlinedWidth,
        width: size - outlinedWidth,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
            'https://random.imagecdn.app/500/150?image=${index * 7}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
