import 'package:flutter/material.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:ig_clone/widgets/connected_users.dart';
import 'package:ig_clone/widgets/storie_widget.dart';

class StoriesSlider extends StatelessWidget {
  const StoriesSlider(
      {Key? key,
      required this.isHomePage,
      this.isStorySlider = true,
      this.isConnectedSlider = false})
      : super(key: key);
  final bool isHomePage;
  final bool isStorySlider;
  final bool isConnectedSlider;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      child: ScrollConfiguration(
        behavior: DisableGlowScroll(),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            if (isHomePage)
              const Padding(
                padding: EdgeInsets.only(left: 13),
                child: _YorStory(),
              ),
            ...List.generate(
                10,
                (index) => isConnectedSlider
                    ? ConnectedUser(size: 60, index: index, title: 'gabyl_r')
                    : isStorySlider
                        ? StoryPreview(
                            index: index,
                            title: 'KarikBary',
                            size: 73,
                          )
                        : Container())
          ],
        ),
      ),
    );
  }
}

class _YorStory extends StatelessWidget {
  const _YorStory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const txtStyle = TextStyle(
      fontFamily: 'SF UI Display',
      fontWeight: FontWeight.w400,
      fontSize: 11.5,
      fontStyle: FontStyle.normal,
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.5, right: 5),
          child: Stack(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://depor.com/resizer/hpXZPawa4p4fbjQiTENb52tdn5g=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/6MHTI4NFI5GCFFQSYCOWJBU2T4.jpg'),
                radius: 30,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.6),
                      color: Colors.blue,
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          'Tu historia',
          style: txtStyle,
        )
      ],
    );
  }
}
