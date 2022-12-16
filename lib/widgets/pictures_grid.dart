import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig_clone/widgets/asset_icon.dart';

class PicturesGrid extends StatefulWidget {
  const PicturesGrid({Key? key}) : super(key: key);

  @override
  State<PicturesGrid> createState() => _PicturesGridState();
}

class _PicturesGridState extends State<PicturesGrid>
    with TickerProviderStateMixin {
  late TabController controller;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final lista = List.generate(
        15,
        (index) => _GridItem(
              index: index,
            ));
    final lista2 = List.generate(
        0,
        (index) => _GridItem(
              index: index,
            ));
    return DefaultTabController(
      length: 2,
      child: Column(children: [
        TabBar(
            onTap: (value) {
              if (value == 0) {
                tabIndex = 0;
                setState(() {});
              } else {
                tabIndex = 1;
                setState(() {});
              }
            },
            indicatorWeight: 2,
            indicatorColor: Colors.black,
            tabs: [
              Tab(
                  icon: AssetAction(
                      img: 'assets/grid.png', onPress: () {}, size: 17)),
              Tab(
                icon: AssetAction(
                    img: 'assets/mentions.png', onPress: () {}, size: 19),
              ),
            ]),
        TabsView(
            tabIndex: tabIndex,
            firstTab: _PostedMedia(lista: lista),
            secondTab: _PostedMedia(
              lista: [],
            ))
      ]),
    );
  }
}

class _PostedMedia extends StatelessWidget {
  const _PostedMedia({
    Key? key,
    required this.lista,
  }) : super(key: key);
  final List<Widget> lista;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1.5,
      runSpacing: 2,
      children: lista.isNotEmpty ? lista : [_EmptyMsg()],
    );
  }
}

class _EmptyMsg extends StatelessWidget {
  const _EmptyMsg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 130),
            child: const FaIcon(
              FontAwesomeIcons.instagram,
              color: Colors.grey,
              size: 35,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'No hay publicaciones',
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}

class TabsView extends StatelessWidget {
  const TabsView(
      {Key? key,
      required this.tabIndex,
      required this.firstTab,
      required this.secondTab})
      : super(key: key);

  final int tabIndex;
  final Widget firstTab;
  final Widget secondTab;

  @override
  Widget build(BuildContext context) {
    final SizeConfig = MediaQuery.of(context).size.width;
    print(tabIndex);

    return Stack(
      children: <Widget>[
        AnimatedContainer(
          child: firstTab,
          width: SizeConfig,
          transform:
              Matrix4.translationValues(tabIndex == 0 ? 0 : -SizeConfig, 0, 0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        ),
        AnimatedContainer(
          child: secondTab,
          width: SizeConfig,
          transform:
              Matrix4.translationValues(tabIndex == 1 ? 0 : SizeConfig, 0, 0),
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        )
      ],
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.33,
      height: width * 0.47,
      color: Colors.white,
      child: Image.network(
        "https://picsum.photos/id/${index * 5}/300/300",
        fit: BoxFit.cover,
      ),
    );
  }
}
