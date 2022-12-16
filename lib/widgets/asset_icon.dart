import 'package:flutter/material.dart';

class AssetAction extends StatelessWidget {
  const AssetAction({
    Key? key,
    required this.img,
    required this.onPress,
    required this.size,
  }) : super(key: key);

  final String img;
  final double size;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Image.asset(
        img,
        height: size,
        width: size,
      ),
    );
  }
}
