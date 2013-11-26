library accountOverviewElement;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:async';
import 'package:js/js.dart' as js;
import 'package:ams/util/util.dart' as util;
import 'package:ams/controller.dart';
import 'package:ams/views/main/menu-account.dart';
import 'package:ams/views/page/account-overview.dart';

/** Die Klasse ist das Model zu einem FolderItem in der SideBar **/
class AccountOverviewElement extends WebComponent {
  
  bool ini = true;
  
//  @observable
  MenuAccount account;
  
  var folder;
  bool isremove = false;
  bool isSelected = false;
  
  AccountOverviewElement(this.account) {

  }
  
  init() {
    this.host.onClick.listen(open);
  }

  void open(e) {
    if(!isSelected && !isremove) account.show();
    isSelected = false;
    isremove = false;
  }
  void delete() {
    isremove = true;
    
    var dialog = js.map({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the account?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new js.Callback.once(() {
            new Controller()..removeAccount(account, folder);
            new Controller()..showPage(new AccountOverview(folder.id));
          })
        }
      }
    });
    js.context.jQuery.Dialog(dialog);
  }
}


