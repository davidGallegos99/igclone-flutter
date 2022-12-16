import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig_clone/widgets/asset_icon.dart';
import 'package:provider/provider.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.8,
      width: double.infinity,
      child: Builder(builder: (context) {
        return ChangeNotifierProvider(
          create: (context) => _AnimationProvider(),
          child: Column(
            children: [
              const _HeaderPost(),
              _BodyPost(
                index: index,
              ),
              const _BottomItemPost()
            ],
          ),
        );
      }),
    );
  }
}

class _BottomItemPost extends StatelessWidget {
  const _BottomItemPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [_InteractionPanel(), _LikeComents()],
    );
  }
}

class _LikeComents extends StatelessWidget {
  const _LikeComents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '100 Likes',
            style: TextStyle(
                fontFamily: 'SF UI Display',
                fontWeight: FontWeight.w700,
                fontSize: 13),
          ),
          SizedBox(
            height: 7,
          ),
          _PostCaption()
        ],
      ),
    );
  }
}

class _PostCaption extends StatelessWidget {
  const _PostCaption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Username',
          style: TextStyle(
              fontFamily: 'SF UI Display',
              fontWeight: FontWeight.w700,
              fontSize: 13),
        ),
        Text(
          'Ullamco excepteur anim dolore sint consequat ut ut anim reprehenderit officia ipsum tempor. In culpa reprehenderit veniam est velit anim excepteur ut. Labore sit dolore exercitation non. Cupidatat cupidatat laborum incididunt amet ut quis sit tempor quis est fugiat fugiat. Eu occaecat proident est irure consectetur sunt dolore ut eu. Qui eu ut quis sint enim ea nisi esse amet adipisicing. Veniam excepteur exercitation ea excepteur aliqua anim consectetur.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}

class _AnimationProvider extends ChangeNotifier {
  final StreamController<bool> _streamCtrl = StreamController.broadcast();
  StreamController<bool> get streamCtrl {
    return _streamCtrl;
  }

  Stream<bool> get isAnimating => streamCtrl.stream;
}

class _InteractionPanel extends StatefulWidget {
  const _InteractionPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<_InteractionPanel> createState() => _InteractionPanelState();
}

class _InteractionPanelState extends State<_InteractionPanel>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animacion;
  bool changeHeart = false;

  @override
  void initState() {
    super.initState();
    final prov = Provider.of<_AnimationProvider>(context, listen: false);
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700),
        reverseDuration: const Duration(milliseconds: 0));
    animacion = Tween(begin: 1.0, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.elasticIn));

    prov.isAnimating.listen((event) {
      if (event) {
        animacion = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Curves.elasticOut,
            reverseCurve: Curves.elasticIn));
        changeHeart = true;
        setState(() {});
        controller.forward();
      }
    });
    controller.addListener(() {
      if (controller.isCompleted) {
        animacion = Tween(begin: 1.0, end: 1.0).animate(CurvedAnimation(
            parent: controller,
            curve: Curves.elasticOut,
            reverseCurve: Curves.elasticIn));
        controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13, bottom: 8),
          child: AnimatedBuilder(
            animation: controller,
            builder: (_, widget) => Transform.scale(
              scale: animacion.value,
              child: InkWell(
                onTap: () {
                  animacion = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                          parent: controller,
                          curve: Curves.elasticOut,
                          reverseCurve: Curves.elasticIn));

                  changeHeart = !changeHeart;
                  setState(() {});
                  controller.forward();
                },
                child: FaIcon(
                  !changeHeart
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  color: !changeHeart ? null : Colors.red,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13, bottom: 8),
          child:
              AssetAction(img: 'assets/comment.png', onPress: () {}, size: 24),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 13, bottom: 8),
          child: AssetAction(img: 'assets/share.png', onPress: () {}, size: 24),
        ),
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.only(top: 13, right: 13, bottom: 8),
          child:
              AssetAction(img: 'assets/bookmark.png', onPress: () {}, size: 24),
        ),
      ],
    );
  }
}

class _BodyPost extends StatefulWidget {
  const _BodyPost({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<_BodyPost> createState() => _BodyPostState();
}

class _BodyPostState extends State<_BodyPost> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animacion;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 150));

    animacion = Tween(begin: 0.0, end: 3.2).animate(CurvedAnimation(
        parent: controller,
        curve: Curves.elasticOut,
        reverseCurve: Curves.ease));

    controller.addListener(() {
      if (controller.isCompleted) {
        Timer(const Duration(milliseconds: 200), () {
          controller.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stream =
        Provider.of<_AnimationProvider>(context, listen: false).streamCtrl;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onDoubleTap: () {
          controller.forward();
          stream.add(true);
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.indigo,
              child: Image.network(
                'https://picsum.photos/500/450?image=${(widget.index) * 13}',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: AnimatedBuilder(
                animation: controller,
                child: const FaIcon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.white,
                ),
                builder: (_, child) => Transform.scale(
                  scale: animacion.value,
                  child: child,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderPost extends StatelessWidget {
  const _HeaderPost({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 57,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _PostAvatar(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AssetAction(
              img: 'assets/more.png',
              onPress: () {},
              size: 37,
            ),
          )
        ],
      ),
    );
  }
}

class _PostAvatar extends StatelessWidget {
  const _PostAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1628563694622-5a76957fd09c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aW5zdGFncmFtJTIwcHJvZmlsZXxlbnwwfHwwfHw%3D&w=1000&q=80'),
            radius: 17,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'profile',
                arguments: {'loggedInUserProfile': false});
          },
          child: const Text(
            "Peaky Blinders",
            style: TextStyle(
                fontFamily: 'SF UI Display',
                fontWeight: FontWeight.w700,
                fontSize: 12.0),
          ),
        )
      ],
    );
  }
}
