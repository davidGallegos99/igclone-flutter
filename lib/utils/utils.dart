import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig_clone/provider/main_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DisableGlowScroll extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

Future showCustomDialog(BuildContext context) {
  final ImagePicker _picker = ImagePicker();
  XFile? imagen;
  return showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => CupertinoAlertDialog(
            actions: [
              TextButton(
                  onPressed: () async {
                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    // ignore: use_build_context_synchronously
                    Provider.of<MainProvider>(context, listen: false).imagen =
                        image;
                    // ignore: use_build_context_synchronously
                    final String? res =
                        await Provider.of<MainProvider>(context, listen: false)
                            .uploadImg();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Galeria',
                  )),
              TextButton(
                  onPressed: () async {
                    // Capture a photo
                    final XFile? photo =
                        await _picker.pickImage(source: ImageSource.camera);
                    // ignore: use_build_context_synchronously
                    Provider.of<MainProvider>(context, listen: false).imagen =
                        photo;
                    // ignore: use_build_context_synchronously
                    final String? res =
                        await Provider.of<MainProvider>(context, listen: false)
                            .uploadImg();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Camara',
                  )),
            ],
            content: Column(
              children: const [
                FaIcon(
                  FontAwesomeIcons.camera,
                  size: 30,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Selecciona una opcion para subir un post'),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ));
}
