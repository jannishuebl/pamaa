library start_page;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'package:ams/controller.dart';


class StartPage extends WebComponent {
  bool ini = false;
  void signin() {
    new Controller().login();
    //new Controller().auth.login(immediate:true);
  }
}
