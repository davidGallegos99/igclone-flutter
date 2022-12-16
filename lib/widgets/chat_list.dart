import 'package:flutter/material.dart';
import 'package:ig_clone/widgets/avatar_story.dart';

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: const [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Sophi',
              time: 'Hace 58 minutos',
              index: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Carlos Rivera',
              time: 'Enviado hace 1h',
              index: 3,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Matt',
              time: 'Enviado hace 12h',
              index: 14,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Aya el',
              time: 'Enviado hace 1h',
              index: 15,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'gabyl_r',
              time: 'Hace una semana',
              index: 7,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'krivera',
              time: 'Hace un momento',
              index: 8,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'coreas_90',
              time: 'Hace 58 minutos',
              index: 9,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'aleealvarado_',
              time: 'Hace 2 horas',
              index: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Marcos Lopez',
              time: 'Enviado hace 2 semanas',
              index: 27,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Mancia',
              time: 'Enviado hace 2 semanas',
              index: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: _ChatItem(
              name: 'Antonio Conte',
              time: 'Enviado hace 1 mes',
              index: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  const _ChatItem({
    Key? key,
    required this.name,
    required this.time,
    required this.index,
  }) : super(key: key);
  final String name;
  final String time;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserStory(
            heroEnabled: false,
            unseen: false,
            size: 65,
            outlinedWidth: 4,
            paddingStory: 2.7,
            index: index),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
        const Expanded(child: SizedBox()),
        const Icon(
          Icons.camera_alt_outlined,
          color: Colors.black,
          size: 27,
        ),
      ],
    );
  }
}
