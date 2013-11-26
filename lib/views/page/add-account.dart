library addaccount;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:json' as json;
import 'dart:async';
import 'package:js/js.dart' as js;
import 'dart:math';

import 'package:ams/controller.dart';
import 'package:ams/util/util.dart' as util;
import 'package:ams/views/page/show-account.dart';

/** Die Klasse ist das Model zu der Seite Account hinzufügen. **/
class AddAccountComponent extends WebPage {

  
  /** Variablen des Interface **/
  bool ini = true;
static  String pageUrl = 'addAccount';

  String getPageUrl() {
    return pageUrl;
  }
  
  @observable
    String selectedFolder = new Controller().data.folder.reversed.first.data.id.toString();
  @observable
    String accName, accLogin, accPw;

  String pwLength ="8";
  bool pwLittle = true;
  bool pwBig = true;
  bool pwNum = true;
  bool pwSpz = false;

  // True wenn eine init() Methode vorhanden ist
  bool isInit = false;

  AddAccountComponent() {
    print(selectedFolder);
  }

  List get folders {
    return new List.from(new Controller().data.folder.reversed);
  }

  void togglePwMenu(e) {
    js.scoped(() {
        //    query('ul').id = "elToOpen";
        //    query('i').id = "icontochange";
        js.context.jQuery(new js.Callback.once((jquery) {
            jquery('#pwSettings').toggle('fast');
            }));
        });
    //    js.context.jQuery(new js.Callback.once((jquery) {
    //      jquery('#pwSettings').toggle('fast');
    //    }));
  }




  void init() {
    // Keine Reflection bei dart2js kann somit raus
    query('#pwSettings').style.display = 'block';

        var generatePwRow = query ('#generatePwCellWrapper').innerHtml;

        query ('#generatePwCellWrapper').innerHtml="";
        js.context.jQuery('#generatePwCellWrapper').html(generatePwRow);

        util.moveParkedElements();

        query('#generatePw').onClick.listen(generatePw);

        var options = js.map({'initAll': true});
        js.context.jQuery()['Slider'](options);


        js.context.jQuery( "#pwSettings" ).position(js.map({
            "my": "left top",
            "at": "left bottom",
            "of": "#generatePwCell"
            }));
        js.context.jQuery( "#pwSettings" ).hide();
        query('#togglePwSettings').onClick.listen(togglePwMenu);
        // macht jquery die textfelder bekannt damit der clearbutton funktioniert
        js.context.jQuery()["Input"](js.map({'initAll': true}));
        // Keine Reflection bei dart2js beim ersten klicken auf den button wird diese init() aufgerufen um das context menü auch zu öffnen wird ein klick simuliert
        // kann somit raus
        //    query('#togglePwSettings').click();

  }

  void generatePw(var e) {

    String pwChars = "";

    if(pwLittle) pwChars += "abcdefghijklmnopqrstuvwxyz";
    if(pwBig) pwChars += "abcdefghijklmnopqrstuvwxyz".toUpperCase();
    if(pwNum) pwChars += "0123456789";
    if(pwSpz) pwChars += "!§\$%&/()=?";
    accPw = "";
    var rng = new Random();
    for (var i = 0; i < int.parse(pwLength); i++) {
      accPw += pwChars[rng.nextInt(pwChars.length)];
    }


  } 

  void saveAccount() {
    if( selectedFolder == null || accPw == null || accLogin == null || accName == null || selectedFolder.isEmpty || accName.isEmpty || accLogin.isEmpty || accPw.isEmpty) {
      var dialog = js.map({
          'title'      : 'Warning..!',
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

    } else {
      Crypt cry = new Crypt();
      var cryptPw = cry.cryptPassword(accPw, sendData);
    }
  }

  void sendData(String cryptPw) {
    AccountData account = new AccountData(-1, accName, accLogin, cryptPw, int.parse(selectedFolder));
    util.sendJson('account', 
        'POST', account.toString(), requestCompleded);
  }

  void requestCompleded(HttpRequest request) {
    var parsedData = json.parse(request.response);

    var data = new Controller().addAccount(parsedData);
    new Controller()..showPage(new ShowAccountComponent()..data=data);
  }
}
