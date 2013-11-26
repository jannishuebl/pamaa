library folderComponent;

import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;
import 'package:ams/controller.dart';
import 'package:ams/views/page/add-account.dart';

/** Die Klasse ist das Model zu einem FolderItem in der SideBar **/
class MenuFolder extends WebComponent {
  bool ini = true;
  @observable
  FolderData data;
  MenuFolder(this.data);
  
  final String hostClasses = "dropdown active opened menuIteam";
  final Map<String, String> hostAttributes = {"data-role":"dropdown", "on-click":"clicked()"};
  
  void init() {
    this.host.classes.add(hostClasses);
    hostAttributes.forEach((k,v){
      this.host.attributes[k] = v;
    });
  }
    
  void open() {
      querySelector('ul').id = "elToOpen";
      querySelector('i').id = "icontochange";
      js.context.jquerySelector(new js.Callback.once((jquery) {
        jquerySelector('#elToOpen').show('fast');
        jquerySelector('#icontochange').removeClass('icon-folder');
        jquerySelector('#icontochange').addClass( "icon-folder-2" );
      }));
    querySelector('i').id = "";
    querySelector('ul').id = "";
  }
  
  void toggle() {
      querySelector('ul').id = "elToOpen";
      querySelector('i').id = "icontochange";
      js.context.jquerySelector(new js.Callback.once((jquery) {
        jquerySelector('#elToOpen').toggle('fast');
        jquerySelector('#icontochange').toggleClass( "icon-folder icon-folder-2" );
      }));
    querySelector('i').id = "";
    querySelector('ul').id = "";
  }
  
  void addAccount() {
    
    new Controller()..showPage(new AddAccountComponent()..selectedFolder=data.id.toString());
  }
}


