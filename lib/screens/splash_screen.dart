import 'package:flutter/material.dart';
import 'package:ig_clone/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scale;
  late final Animation<double> opacidad;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    scale = Tween(begin: 1.0, end: 8.5)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    opacidad = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: controller,
        curve: const Interval(0.075, 1.0, curve: Curves.easeOut)));

    controller.addListener(() {
      if (controller.isCompleted) {
        Navigator.pushReplacementNamed(context, 'home');
      }
    });

    Future.delayed(
      const Duration(seconds: 3),
      () async {
        final token =
            await Provider.of<AuthProvider>(context, listen: false).getToken();
        if (token != null) {
          controller.forward();
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'login');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: controller,
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: Image.asset('assets/logo.png')),
            builder: (_, child) {
              return Opacity(
                opacity: opacidad.value,
                child: Transform.scale(
                  scale: scale.value,
                  child: child,
                ),
              );
            }),
      ),
    );
  }
}
