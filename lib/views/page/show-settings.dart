library showsettings;

import 'dart:html';
import 'package:js/js.dart' as js;
import 'package:web_ui/web_ui.dart';
import 'package:ams/controller.dart';
import 'package:ams/util/util.dart' as util;

/** Die Klasse ist das Model zu der Seite Account hinzufügen. **/
class ShowSettingsComponent extends WebPage {

  /** Variablen des Interface **/
  bool ini = true;
static  String pageUrl = 'settings';

  String getPageUrl() {
    return pageUrl;
  }

  @observable
    String newMPw='', newMPw2='', oldMPw='';


  void init() {
    // macht jquery die textfelder bekannt damit der clearbutton funktioniert
    js.context.jQuery()["Input"](js.map({'initAll': true}));
  }

  savePw() {

    if(oldMPw.isNotEmpty && newMPw.isNotEmpty ) {
      Crypt crypt = new Crypt();

      String oldHash = util.hash(oldMPw);
      if(crypt.testMasterPw(oldHash) && newMPw.compareTo(newMPw2) == 0 ) {
        String newHash = util.hash(newMPw);
        crypt.sendMasterPw(newHash);
        new Controller().data.account.forEach((MenuAccount account) {
            String oldAccPw = crypt.decrypt(oldHash, account.data.pw);
            account.data.pw = crypt.crypt(newHash, oldAccPw);
            new Controller()..updateAccount(account.data);
            });
        oldMPw = '';
        newMPw = '';
        newMPw2 = '';
        var dialog = js.map({
            'title'      : 'Success..!',
            'content'    : 'Masterpassword changed.!.',
            'draggable'  : true,
            'buttonsAlign': 'right',
            'buttons'    : {
            'Ok'    : {
            'action': new js.Callback.once(() {})
            }
            }
            });
        js.context.jQuery.Dialog(dialog);
      } else {
        var dialog = js.map({
            'title'      : 'Error..!',
            'content'    : 'Input does not match.!.',
            'draggable'  : true,
            'buttonsAlign': 'right',
            'buttons'    : {
            'Ok'    : {
            'action': new js.Callback.once(() {})
            }
            }
            });
        js.context.jQuery.Dialog(dialog);
      }
    } else {
      var dialog = js.map({
          'title'      : 'Error..!',
          'content'    : 'Please fillout all Datafields.',
          'draggable'  : true,
          'buttonsAlign': 'right',
          'buttons'    : {
          'Ok'    : {
          'action': new js.Callback.once(() {})
          }
          }
          });
      js.context.jQuery.Dialog(dialog);
    }
  }
}
