import 'package:flutter/material.dart';
import 'package:ig_clone/provider/pageviewer_provider.dart';
import 'package:ig_clone/screens/home_screen.dart';
import 'package:ig_clone/screens/messages_screen.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:provider/provider.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PageviewProvider(), child: const _MainContainer());
  }
}

class _MainContainer extends StatelessWidget {
  const _MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowScroll(),
      child: PageView(
        controller:
            Provider.of<PageviewProvider>(context, listen: false).controller,
        children: const [HomeScreen(), MessagesScreen()],
      ),
    );
  }
}
