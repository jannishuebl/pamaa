library showaccount;

import 'package:web_ui/web_ui.dart';
import 'dart:js';
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
    context['jQuery']("#pw").focus().select();
    context['jQuery']('#showAccountButton').hide();
  }
  
  String getPageUrl() {
    return pageUrl + "/" + data.id.toString();
  }

  void remove() {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the account?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            new Controller()..removeAccount(new Controller().data.account.firstWhere(
                (e) { return e.data.id == data.id;}), new Controller().data.folder.firstWhere( (e) { return e.data.id == data.folder;}).data);
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
    
  }
  
  void move() {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to move the account?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            new Controller()..moveAccount(
                  new Controller().data.account.firstWhere(
                      (e) { return e.data.id == data.id;}), selectedFolder, 
                      new Controller().data.folder.firstWhere( (e) { return e.data.id == data.folder;}).data);
            this.remove();
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
  }
  
  void rename() {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Enter your new Accountname:<br><br><div class="input-control text"><input autofocus="true" id="accountname" type="text" /><button class="btn-clear"></button></div>',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            InputElement accountnameField = querySelector('#accountname');
            String accountname = accountnameField.value;

            new Controller()..updateAccount(data..name=accountname);
            this.remove();
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
  }
}
