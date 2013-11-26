library accountComponent;
import 'package:web_ui/web_ui.dart';
import 'package:ams/views/page/show-account.dart';
import 'package:ams/controller.dart';

/** Die Klasse ist das Model zu einem Accountitem in der SideBar **/
class MenuAccount extends WebComponent {
  
  bool ini = false;
  @observable
  AccountData data;
  
  final String hostClasses = null;
  final Map<String, String> hostAttributes = {};
  
  void show() {
    new Controller()..showPage(new ShowAccountComponent()..data=data);
  }
}
