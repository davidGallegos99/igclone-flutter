import 'dart:async';

import 'package:flutter/cupertino.dart';

class PageviewProvider extends ChangeNotifier {
  PageController controller = PageController();

  set setController(PageController controlador) {
    controller = controlador;
  }
}
