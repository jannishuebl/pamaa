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
    js.scoped(() {
      query('ul').id = "elToOpen";
      query('i').id = "icontochange";
      js.context.jQuery(new js.Callback.once((jquery) {
        jquery('#elToOpen').show('fast');
        jquery('#icontochange').removeClass('icon-folder');
        jquery('#icontochange').addClass( "icon-folder-2" );
      }));
    });
    query('i').id = "";
    query('ul').id = "";
  }
  
  void toggle() {
    js.scoped(() {
      query('ul').id = "elToOpen";
      query('i').id = "icontochange";
      js.context.jQuery(new js.Callback.once((jquery) {
        jquery('#elToOpen').toggle('fast');
        jquery('#icontochange').toggleClass( "icon-folder icon-folder-2" );
      }));
    });
    query('i').id = "";
    query('ul').id = "";
  }
  
  void addAccount() {
    
    new Controller()..showPage(new AddAccountComponent()..selectedFolder=data.id.toString());
  }
}


