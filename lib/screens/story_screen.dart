import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StoryModel {
  Duration duration;
  String imageUrl;
  bool finished;
  int order;

  StoryModel(this.duration, this.imageUrl, this.finished, this.order);

  static copy(StoryModel copia) =>
      StoryModel(copia.duration, copia.imageUrl, copia.finished, copia.order);
}

class _StoryProvider extends ChangeNotifier {
  StoryModel _storyModel =
      StoryModel(const Duration(milliseconds: 0), '', false, 0);
  StoryModel get story => _storyModel;
  int _current = 0;

  StreamController<double> streamCtrl = StreamController.broadcast();

  Stream<double> get stream => streamCtrl.stream;

  get current => _current;

  set setCurrent(int val) {
    _current = val;
    notifyListeners();
  }

  set setStory(StoryModel val) {
    _storyModel = val;
    notifyListeners();
  }

  set setStoryNoNotify(StoryModel val) {
    _storyModel = val;
  }
}

class StoryScreen extends StatelessWidget {
  const StoryScreen({Key? key, this.color = Colors.black, required this.lista})
      : super(key: key);
  final Color color;
  final List<StoryModel> lista;
  @override
  Widget build(BuildContext context) {
    final Map<String, int> index =
        ModalRoute.of(context)?.settings.arguments as Map<String, int>;
    return Hero(
      tag: index['index']!,
      child: ChangeNotifierProvider(
        create: (context) => _StoryProvider(),
        child: _Storyviewer(lista: lista),
      ),
    );
  }
}

class _Storyviewer extends StatelessWidget {
  const _Storyviewer({
    Key? key,
    required this.lista,
  }) : super(key: key);

  final List<StoryModel> lista;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<_StoryProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: [
              _StoryBody(provider: provider, lista: lista),
              Positioned(
                bottom: 30,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Row(
                    children: const [Expanded(child: _StoryInputReply())],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _StoryInputReply extends StatelessWidget {
  const _StoryInputReply({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stilos = OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide(color: Colors.grey, width: .5));
    return TextFormField(
      decoration: InputDecoration(
          focusedBorder: stilos,
          enabledBorder: stilos,
          border: stilos,
          hintText: 'Enviar mensaje',
          hintStyle: TextStyle(color: Colors.white, height: 3)),
      style: TextStyle(color: Colors.white),
    );
  }
}

class _StoryBody extends StatelessWidget {
  const _StoryBody({
    Key? key,
    required this.provider,
    required this.lista,
  }) : super(key: key);

  final _StoryProvider provider;
  final List<StoryModel> lista;

  @override
  Widget build(BuildContext context) {
    _onTapDown(TapDownDetails details) {
      var x = details.globalPosition.dx;
      Provider.of<_StoryProvider>(context, listen: false)
          .streamCtrl
          .add(x.toDouble());
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(bottom: 100, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            GestureDetector(
              onTapDown: (detatail) {
                _onTapDown(detatail);
              },
              child: _StoryMediaFile(provider: provider),
            ),
            Positioned(child: _StoryTimeline(lista: lista)),
          ],
        ),
      ),
    );
  }
}

class _StoryMediaFile extends StatelessWidget {
  const _StoryMediaFile({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final _StoryProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black.withOpacity(0.8),
      child: provider.story.imageUrl.isNotEmpty
          ? Image.network(
              provider.story.imageUrl,
              fit: BoxFit.cover,
            )
          : null,
    );
  }
}

class _StoryTimeline extends StatelessWidget {
  const _StoryTimeline({
    Key? key,
    required this.lista,
  }) : super(key: key);
  final List<StoryModel> lista;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, left: 15, right: 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...lista
              .map((e) => _StoryTimer(
                    length: lista.length,
                    story: e,
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class _StoryTimer extends StatefulWidget {
  const _StoryTimer({
    Key? key,
    required this.story,
    required this.length,
  }) : super(key: key);

  final StoryModel story;
  final int length;

  @override
  State<_StoryTimer> createState() => _StoryTimerState();
}

class _StoryTimerState extends State<_StoryTimer>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> animacion;
  int _current = 0;
  bool finished = false;

  @override
  void initState() {
    super.initState();
    _StoryProvider provider =
        Provider.of<_StoryProvider>(context, listen: false);
    controller =
        AnimationController(vsync: this, duration: widget.story.duration);
    animacion = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));
    controller.addListener(() {
      if (controller.status == AnimationStatus.forward) {
        if (widget.story.order == _current) {
          provider.setStory = StoryModel.copy(widget.story);
        }
      }
      if (controller.isCompleted) {
        if (widget.story.order == _current) {
          provider.setStory = StoryModel.copy(widget.story);

          widget.story.finished = true;
          finished = true;
        }
        _current += 1;
        if (widget.length != _current && !finished) {
          provider.setCurrent = _current;
          controller.reset();
        }

        setState(() {});
      }
    });
    provider.stream.listen((event) {
      if (event < MediaQuery.of(context).size.width * 0.5 && _current <= 0) {
        _current = 0;
        setState(() {});
        return;
      } else if (event > MediaQuery.of(context).size.width * 0.5 &&
          _current >= widget.length - 1) {
        _current = widget.length - 1;
        setState(() {});
        return;
      }

      if (widget.story.order == _current) {
        provider.setStory = StoryModel.copy(widget.story);
        if (event > MediaQuery.of(context).size.width * 0.5) {
          widget.story.finished = true;
          finished = true;
        }
      } else {
        provider.setStory = StoryModel.copy(widget.story);
        if (event < MediaQuery.of(context).size.width * 0.5) {
          widget.story.finished = false;
          finished = false;
        }
      }
      // finished = true;
      if (event > MediaQuery.of(context).size.width * 0.5) {
        _current++;
      } else {
        _current--;
      }
      setState(() {});
      controller.reset();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return Expanded(
      child: Container(
        height: 1.5,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: widget.story.order == _current && !finished
              ? AnimatedBuilder(
                  animation: controller,
                  builder: (_, child) {
                    return CustomPaint(
                        painter: _StoryPainter(progress: animacion.value));
                  },
                )
              : (widget.story.order != _current) &&
                      ((widget.story.order < _current) || finished)
                  ? CustomPaint(painter: _StoryPainter(progress: 1.0))
                  : CustomPaint(painter: _StoryPainter(progress: 0.0)),
        ),
      ),
    );
  }
}

class _StoryPainter extends CustomPainter {
  final double progress;

  _StoryPainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;

    final paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 1.5;
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.lineTo(width * progress, 0);
    path.lineTo(width * progress, height);
    path.lineTo(0, height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
