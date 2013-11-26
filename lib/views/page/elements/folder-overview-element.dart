library folderOverviewElement;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:async';
import 'package:js/js.dart' as js;
import 'package:ams/util/util.dart' as util;
import 'package:ams/controller.dart';
import 'package:ams/views/main/menu-folder.dart';
import 'package:ams/views/page/account-overview.dart';
import 'package:ams/views/page/folder-overview.dart';

import 'package:ams/views/page/add-account.dart';

/** Die Klasse ist das Model zu einem FolderItem in der SideBar **/
class FolderOverviewElement extends WebComponent {
  bool ini = true;
  @observable
  MenuFolder folder;

  bool isremove = false;
  bool isSelected = false;
  FolderOverviewElement(this.folder) {

  }
  
  init() {
    this.host.onClick.listen(open);
  }

  void open(e) {
    if(!isSelected && !isremove) {
      folder.open();
      if(folder.data.count == 0)  new Controller()..showPage(new AddAccountComponent()..selectedFolder=folder.data.id.toString());
      else new Controller()..showPage(new AccountOverview(folder.data.id));
    }
    isSelected = false;
    isremove = false;
  }
  void delete() {
    isremove = true;
    
    var dialog = js.map({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the folder and its accounts?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new js.Callback.once(() {
            new Controller()..removeFolder(folder);
            new Controller()..showPage(new FolderOverview());
          })
        }
      }
    });
    js.context.jQuery.Dialog(dialog);
    
    
  }
}


