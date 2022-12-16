import 'package:flutter/material.dart';
import 'package:ig_clone/provider/main_provider.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:ig_clone/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);
    setImage() {
      showCustomDialog(context);
      mainProvider.imagen;
    }

    final List<dynamic> appbarActions = [
      {'icon': 'assets/frame.png', 'onPress': setImage},
      {'icon': 'assets/heart.png', 'onPress': () {}},
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarIG(
            showMessenger: true, actionsize: 24, actions: appbarActions),
        bottomNavigationBar: const CustomBottomNavigationBar(),
        body: RefreshIndicator(
          onRefresh: () => Future.delayed(
            const Duration(milliseconds: 3000),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: StoriesSlider(
                    isHomePage: true,
                  ),
                ),
                Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.withOpacity(.3)),
                const PostsList()
              ],
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
