import 'package:flutter/material.dart';
import 'package:ig_clone/provider/pageviewer_provider.dart';
import 'package:ig_clone/widgets/asset_icon.dart';
import 'package:provider/provider.dart';

class AppbarIG extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final List<dynamic> actions;
  final double actionsize;
  final bool showMessenger;
  final Widget? title;
  final bool showArrowBack;

  AppbarIG(
      {Key? key,
      required this.actions,
      required this.actionsize,
      required this.showMessenger,
      this.title = const _Logo(),
      this.showArrowBack = true})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PageviewProvider>(context);

    return AppBar(
      title: title,
      automaticallyImplyLeading: showArrowBack,
      actions: [
        _ActionIcons(
          size: actionsize,
          actions: actions,
        ),
        if (showMessenger)
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                prov.controller.nextPage(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.ease);
              },
              child: const MessageInteractiveWidget()),
        if (showMessenger)
          const SizedBox(
            width: 10,
          )
      ],
    );
  }
}

class MessageInteractiveWidget extends StatelessWidget {
  const MessageInteractiveWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AssetAction(img: 'assets/messenger.png', onPress: () {}, size: 24),
            const Positioned(
                top: 7,
                right: 3,
                child: _MessageCounter(
                  counter: 6,
                )),
          ],
        ),
      ),
    );
  }
}

class _MessageCounter extends StatelessWidget {
  const _MessageCounter({
    Key? key,
    required this.counter,
  }) : super(key: key);
  final int counter;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      height: 18,
      width: 18,
      child: Center(
        child: Text(
          '$counter',
          style: const TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _ActionIcons extends StatelessWidget {
  const _ActionIcons({
    Key? key,
    required this.actions,
    required this.size,
  }) : super(key: key);
  final List<dynamic> actions;
  final double size;

  @override
  Widget build(BuildContext context) {
    List<Widget> printAction() {
      final List<Widget> element = [];
      for (var e in actions) {
        element
          ..add(AssetAction(
            size: size,
            img: e['icon'],
            onPress: () {
              e['onPress']();
            },
          ))
          ..add(const SizedBox(
            width: 20,
          ));
      }
      return element;
    }

    return Row(children: [
      ...printAction(),
    ]);
  }
}

class _Logo extends StatelessWidget {
  const _Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo.png',
      width: 100,
      height: 64,
    );
  }
}
