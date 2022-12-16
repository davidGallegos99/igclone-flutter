import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig_clone/provider/pageviewer_provider.dart';
import 'package:ig_clone/theme/app_theme.dart';
import 'package:ig_clone/widgets/app_bar.dart';
import 'package:ig_clone/widgets/chat_list.dart';
import 'package:ig_clone/widgets/forms/input_search.dart';
import 'package:ig_clone/widgets/stories_slider.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    const txtStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      fontStyle: FontStyle.normal,
    );
    final actions = [
      {'icon': 'assets/Reels.png', 'onPress': () {}},
      {'icon': 'assets/share.png', 'onPress': () {}}
    ];
    return Scaffold(
        appBar: AppbarIG(
            title: const _LeadingAppbar(),
            actions: actions,
            actionsize: 22,
            showMessenger: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SearchInput(),
              ),
              SizedBox(
                height: 20,
              ),
              StoriesSlider(
                isHomePage: false,
                isConnectedSlider: true,
              ),
              Padding(
                padding: EdgeInsets.only(left: 17),
                child: Text(
                  'Mensajes',
                  style: txtStyle,
                ),
              ),
              ChatList()
            ],
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class _LeadingAppbar extends StatelessWidget {
  const _LeadingAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Provider.of<PageviewProvider>(context, listen: false)
                .controller
                .animateToPage(0,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOut);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: FaIcon(
              FontAwesomeIcons.arrowLeftLong,
              size: 23,
            ),
          ),
        ),
        const SizedBox(
          width: 35,
        ),
        Text(
          'alexa_nderx99',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19,
              color: AppTheme.isDark ? Colors.white : Colors.black),
        )
      ],
    );
  }
}
