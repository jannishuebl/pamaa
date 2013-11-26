library menu;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:json' as json;
import 'package:js/js.dart' as js;
import 'package:ams/controller.dart';
import 'package:ams/views/page/add-account.dart';
import 'package:ams/views/page/folder-overview.dart';
import 'package:ams/views/page/show-settings.dart';
import 'dart:async'; 

import 'package:ams/util/util.dart' as util;

/** Die Klasse ist das Model zur SideBar **/
class MenuComponent extends WebComponent {
  
  bool ini = true;
  
  void addAccount() {
    
    new Controller()..showPage(new AddAccountComponent());
  }
  
  void showOverview() {
    
    new Controller().showPage(new FolderOverview());
  }
 

void showSettings() {
    
    new Controller().showPage(new ShowSettingsComponent());
  }

void logout() {
  
  new Controller().logout();
}
  
  void addFolder() {
    
    InputElement textField = document.query("#folderName");
    if(textField.value != '')
    util.sendJson('folder', 
        'POST', '{"foldername":"'+textField.value+'"}', requestCompleded);
  }
  
  void requestCompleded(HttpRequest request) {
    var parsedData = json.parse(request.response);
    
    new Controller()..addFolder(parsedData);
  }
}
