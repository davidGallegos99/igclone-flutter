import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ig_clone/utils/utils.dart';

class InstagramSwiper extends StatefulWidget {
  final List<Widget> children;
  final int initialPage;

  InstagramSwiper({
    Key? key,
    required this.children,
    this.initialPage = 0,
  }) : super(key: key) {
    assert(children.isNotEmpty);
  }

  @override
  State<InstagramSwiper> createState() => _InstagramSwiperState();
}

class _InstagramSwiperState extends State<InstagramSwiper> {
  late final PageController _pageController;
  double currentPageValue = 0.0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: widget.initialPage);
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowScroll(),
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.children.length,
        itemBuilder: (context, index) {
          double value;
          if (_pageController.position.haveDimensions == false) {
            value = index.toDouble();
          } else {
            value = _pageController.page!;
          }
          return _SwipeWidget(
            index: index,
            pageNotifier: value,
            child: widget.children[index],
          );
        },
      ),
    );
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

class _SwipeWidget extends StatefulWidget {
  final int index;

  final double pageNotifier;

  final Widget child;

  const _SwipeWidget({
    Key? key,
    required this.index,
    required this.pageNotifier,
    required this.child,
  }) : super(key: key);

  @override
  State<_SwipeWidget> createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<_SwipeWidget> {
  double _offset = 0.0;
  @override
  Widget build(BuildContext context) {
    final isLeaving = (widget.index - widget.pageNotifier) <= 0;
    final t = (widget.index - widget.pageNotifier);
    final rotationY = lerpDouble(0, 90, t);
    final opacity = lerpDouble(0, 1, t.abs())!.clamp(0.0, 1.0);
    return Transform(
      alignment: isLeaving ? Alignment.centerRight : Alignment.centerLeft,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(-degToRad(rotationY!).toDouble())
        ..translate(0.0, _offset, 0.0),
      child: GestureDetector(
        onPanUpdate: (details) => setState(() {
          if (_offset + details.delta.dy > 0) {
            _offset += details.delta.dy;
          }
        }),
        onPanEnd: (details) => setState(() {
          if (_offset > 300) {
            Navigator.pop(context);
          }
          _offset = 0.0;
        }),
        child: Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: Opacity(
                opacity: opacity,
                child: const SizedBox.shrink(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
