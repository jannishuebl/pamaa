library header;
import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'package:ams/controller.dart';


class HeaderComponent extends WebComponent {
  
  bool ini = false;
  @observable
  String webAppHeadline = "PasswordManager";
  @observable
  Controller controller = new Controller();
  @observable
  String givenName = new Controller().data.user.givenName;
  void open() {
    new Controller()..pageBack();
  } 
  
  void logout() {
    new Controller().auth.logout();
  }
}
