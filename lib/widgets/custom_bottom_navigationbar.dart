import 'package:flutter/material.dart';
import 'package:ig_clone/widgets/asset_icon.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1))),
      child: BottomNavigationBar(
          elevation: 0,
          currentIndex: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: AssetAction(
                  img: 'assets/home-icon.png', onPress: () {}, size: 24),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: AssetAction(
                  img: 'assets/Search.png', onPress: () {}, size: 24),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: AssetAction(
                  img: 'assets/Reels.png', onPress: () {}, size: 24),
            ),
            BottomNavigationBarItem(
              label: '',
              icon:
                  AssetAction(img: 'assets/Shop.png', onPress: () {}, size: 24),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'profile',
                      arguments: {'loggedInUserProfile': true});
                },
                child: const CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://depor.com/resizer/hpXZPawa4p4fbjQiTENb52tdn5g=/1200x1200/smart/filters:format(jpeg):quality(75)/cloudfront-us-east-1.images.arcpublishing.com/elcomercio/6MHTI4NFI5GCFFQSYCOWJBU2T4.jpg'),
                    radius: 14),
              ),
            ),
          ]),
    );
  }
}
