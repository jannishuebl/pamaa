library folderComponent;

import 'package:web_ui/web_ui.dart';
import 'dart:js';
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
      context['jQuery'](new JsFunction.withThis((jquery) {
        context['jQuery']('#elToOpen').show('fast');
        context['jQuery']('#icontochange').removeClass('icon-folder');
        context['jQuery']('#icontochange').addClass( "icon-folder-2" );
      }));
    querySelector('i').id = "";
    querySelector('ul').id = "";
  }
  
  void toggle() {
      querySelector('ul').id = "elToOpen";
      querySelector('i').id = "icontochange";
      context['jQuery'](new JsFunction.withThis((jquery) {
        context['jQuery']('#elToOpen').toggle('fast');
        context['jQuery']('#icontochange').toggleClass( "icon-folder icon-folder-2" );
      }));
    querySelector('i').id = "";
    querySelector('ul').id = "";
  }
  
  void addAccount() {
    
    new Controller()..showPage(new AddAccountComponent()..selectedFolder=data.id.toString());
  }
}


