library showaccount;

import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;
import 'dart:html';
import 'package:ams/controller.dart';

/** Die Klasse ist das Model der Seite Account anzeigen**/
class ShowAccountComponent extends WebPage {
  
  /** Variablen des Interface **/
  bool ini = false;
static  String pageUrl = 'showAccount';
  
  @observable
  AccountData data;
  String pw = "*******";
  
  @observable
  String selectedFolder = new Controller().data.folder.reversed.first.data.id.toString();
  
  List get folders {
    return new List.from(new Controller().data.folder.reversed);
  }
  
  
  void decryptPw() {
      Crypt crypt = new Crypt();
      crypt.decryptPassword(data.pw, showDecryptedPw);
  }
  
  void showDecryptedPw(var pwDecrypted) {
    querySelector('#pw').innerHtml =  pwDecrypted.toString();
    js.context.jQuery("#pw").focus().select();
    js.context.jQuery('#showAccountButton').hide();
  }
  
  String getPageUrl() {
    return pageUrl + "/" + data.id.toString();
  }

  void remove() {
    var dialog = js.map({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the account?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new js.Callback.once(() {
            new Controller()..removeAccount(new Controller().data.account.firstWhere(
                (e) { return e.data.id == data.id;}), new Controller().data.folder.firstWhere( (e) { return e.data.id == data.folder;}).data);
          })
        }
      }
    });
    js.context.jQuery.Dialog(dialog);
    
  }
  
  void move() {
    var dialog = js.map({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to move the account?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new js.Callback.once(() {
            new Controller()..moveAccount(
                  new Controller().data.account.firstWhere(
                      (e) { return e.data.id == data.id;}), selectedFolder, 
                      new Controller().data.folder.firstWhere( (e) { return e.data.id == data.folder;}).data);
            this.remove();
          })
        }
      }
    });
    js.context.jQuery.Dialog(dialog);
  }
  
  void rename() {
    var dialog = js.map({
      'title'      : 'Warning..!',
      'content'    : 'Enter your new Accountname:<br><br><div class="input-control text"><input autofocus="true" id="accountname" type="text" /><button class="btn-clear"></button></div>',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new js.Callback.once(() {
            InputElement accountnameField = query('#accountname');
            String accountname = accountnameField.value;

            new Controller()..updateAccount(data..name=accountname);
            this.remove();
          })
        }
      }
    });
    js.context.jQuery.Dialog(dialog);
  }
}
