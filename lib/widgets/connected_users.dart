import 'package:flutter/material.dart';

class ConnectedUser extends StatelessWidget {
  const ConnectedUser(
      {Key? key, required this.size, required this.index, required this.title})
      : super(key: key);
  final double size;
  final int index;
  final String title;
  @override
  Widget build(BuildContext context) {
    const txtStyle = TextStyle(
      fontFamily: 'SF UI Display',
      fontWeight: FontWeight.w400,
      fontSize: 11.5,
      fontStyle: FontStyle.normal,
    );

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 15),
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Stack(
              children: [
                _CirclePreview(size: size, index: index),
                Positioned(
                    bottom: 1.5,
                    right: 1.5,
                    child: Container(
                      height: 16.5,
                      width: 16.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 2),
                          color: const Color.fromRGBO(120, 222, 69, 1),
                          shape: BoxShape.circle),
                    ))
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Text(title, overflow: TextOverflow.ellipsis, style: txtStyle)
          ],
        ),
      ),
    );
  }
}

class _CirclePreview extends StatelessWidget {
  const _CirclePreview({
    Key? key,
    required this.size,
    required this.index,
  }) : super(key: key);

  final double size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          color: Colors.white,
          height: size,
          width: size,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://random.imagecdn.app/500/150?image=${index * 7}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
