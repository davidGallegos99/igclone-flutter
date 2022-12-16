import 'package:flutter/material.dart';
import 'package:ig_clone/provider/auth_provider.dart';
import 'package:ig_clone/utils/utils.dart';
import 'package:ig_clone/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final List<dynamic> actions = [
      {
        'icon': 'assets/logout.png',
        'onPress': () async {
          await Provider.of<AuthProvider>(context, listen: false).logout();
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, 'login');
        }
      },
      {'icon': 'assets/notifiations.png', 'onPress': () {}}
    ];
    return Scaffold(
        appBar: AppbarIG(
            showArrowBack: false,
            title: const _LeadingAppbar(),
            actions: actions,
            actionsize: 24,
            showMessenger: false),
        body: ScrollConfiguration(
          behavior: DisableGlowScroll(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const _ProfileStats(),
                const _ProfileBio(),
                _ProfileActions(
                  loggedInUserProfile: arguments['loggedInUserProfile'],
                ),
                const SizedBox(
                  height: 13,
                ),
                const _StorySlider(),
                const PicturesGrid()
              ],
            ),
          ),
        ));
  }
}

class _StorySlider extends StatelessWidget {
  const _StorySlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          const SizedBox(
            width: 7,
          ),
          ...List.generate(
              10,
              (index) => StoryPreview(
                  unseen: false,
                  title: 'historia $index',
                  size: 60,
                  index: index))
        ],
      ),
    );
  }
}

class _ProfileActions extends StatelessWidget {
  const _ProfileActions({
    Key? key,
    required this.loggedInUserProfile,
  }) : super(key: key);
  final bool loggedInUserProfile;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            if (loggedInUserProfile)
              const _ActionProfileBtn(title: 'Edit Profile'),
            if (!loggedInUserProfile)
              const _ActionProfileBtn(title: 'Following'),
            if (!loggedInUserProfile) const _ActionProfileBtn(title: 'Message'),
            if (!loggedInUserProfile)
              const _ActionProfileBtn(
                title: 'Email',
              )
          ],
        ),
      ),
    );
  }
}

class _ActionProfileBtn extends StatelessWidget {
  const _ActionProfileBtn({
    Key? key,
    required this.title,
    this.background = Colors.white,
  }) : super(key: key);
  final String title;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                  side: const BorderSide(color: Color(0xffCBCBCB), width: 0.7)),
              primary: background,
              onPrimary:
                  background == Colors.white ? Colors.black : Colors.white,
              textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SF UI Display')),
          child: Text(title),
        ),
      ),
    );
  }
}

class _ProfileBio extends StatelessWidget {
  const _ProfileBio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle(FontWeight fw) {
      return TextStyle(
          fontFamily: 'SF UI Display', fontSize: 13, fontWeight: fw);
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('alexn_dr_99', style: textStyle(FontWeight.w700)),
          const SizedBox(
            height: 5,
          ),
          Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt #hashtag',
              style: textStyle(FontWeight.w400))
        ],
      ),
    );
  }
}

class _ProfileStats extends StatelessWidget {
  const _ProfileStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stories = [''];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _ProfileAvatar(stories: stories),
          const SizedBox(
            width: 45,
          ),
          const Expanded(
            child: _Followers(),
          )
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    Key? key,
    required this.stories,
  }) : super(key: key);

  final List stories;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return GestureDetector(
      onLongPress: arguments['loggedInUserProfile']
          ? () => _ChangeProfilePic(context)
          : null,
      child: stories.isNotEmpty
          ? const UserStory(
              size: 87, outlinedWidth: 4.4, paddingStory: 2, index: 22)
          : const CircleAvatar(
              radius: 43,
              backgroundImage:
                  NetworkImage('https://random.imagecdn.app/500/150?image=190'),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> _ChangeProfilePic(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        builder: (_) {
          return SizedBox(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 45,
                    height: 4.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: const Color.fromARGB(255, 97, 97, 97)),
                    margin: const EdgeInsets.only(top: 10),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 25),
                  child: Text(
                    'Cambiar foto de perfil',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 15),
                  child: Text(
                    'Nueva foto de perfil',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 15),
                  child: Text(
                    'Importar desde Facebook',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 15),
                  child: Text(
                    'Usar avatar',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.5, vertical: 15),
                  child: Text(
                    'Eliminar foto del perfil',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        });
  }
}

class _Followers extends StatelessWidget {
  const _Followers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _PostsCounter(
          counter: 912,
          label: 'Posts',
        ),
        SizedBox(
          width: 25,
        ),
        _PostsCounter(
          counter: 2781,
          label: 'Followers',
        ),
        SizedBox(
          width: 25,
        ),
        _PostsCounter(counter: 4901, label: 'Following'),
      ],
    );
  }
}

class _PostsCounter extends StatelessWidget {
  const _PostsCounter({
    Key? key,
    required this.counter,
    required this.label,
  }) : super(key: key);

  final int counter;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$counter',
            style: const TextStyle(
                fontFamily: 'SF UI Display',
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        Text(label,
            style: const TextStyle(
                fontFamily: 'SF UI Display',
                fontSize: 13,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}

class _LeadingAppbar extends StatelessWidget {
  const _LeadingAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.58,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 24,
            ),
          ),
          const Text(
            'alexnder_99',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                fontFamily: 'SF UI Display',
                color: Colors.black),
          )
        ],
      ),
    );
  }
}
