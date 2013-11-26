library addaccount;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:js';
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

  void togglePwMenu(_) {
        //    querySelector('ul').id = "elToOpen";
        //    querySelector('i').id = "icontochange";
        context['jQuery'](new JsFunction.withThis((jquery) {
          context['jQuery']('#pwSettings').toggle('fast');
            }));
    //    context['jQuery'](new JsFunction.withThis((jquery) {
    //      jQuery('#pwSettings').toggle('fast');
    //    }));
  }




  void init() {
    // Keine Reflection bei dart2js kann somit raus
    querySelector('#pwSettings').style.display = 'block';

        var generatePwRow = query ('#generatePwCellWrapper').innerHtml;

        querySelector ('#generatePwCellWrapper').innerHtml="";
        context['jQuery']('#generatePwCellWrapper').html(generatePwRow);

        util.moveParkedElements();

        querySelector('#generatePw').onClick.listen(generatePw);

        var options = new JsObject.fromBrowserObject({'initAll': true});
        context['jQuery']()['Slider'](options);


        context['jQuery']( "#pwSettings" ).position(new JsObject.fromBrowserObject({
            "my": "left top",
            "at": "left bottom",
            "of": "#generatePwCell"
            }));
        context['jQuery']( "#pwSettings" ).hide();
        querySelector('#togglePwSettings').onClick.listen(togglePwMenu);
        // macht jquery die textfelder bekannt damit der clearbutton funktioniert
        context['jQuery']()["Input"](new JsObject.fromBrowserObject({'initAll': true}));
        // Keine Reflection bei dart2js beim ersten klicken auf den button wird diese init() aufgerufen um das context menü auch zu öffnen wird ein klick simuliert
        // kann somit raus
        //    querySelector('#togglePwSettings').click();

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
      var dialog = new JsObject.fromBrowserObject({
          'title'      : 'Warning..!',
          'content'    : 'Please fillout all Datafields.',
          'draggable'  : true,
          'buttonsAlign': 'right',
          'buttons'    : {
          'Ok'    : {
          'action': new JsFunction.withThis(() {})
          }
          }
          });
      context['jQuery'].Dialog(dialog);

    } else {
      Crypt cry = new Crypt();
      cry.cryptPassword(accPw, sendData);
    }
  }

  void sendData(String cryptPw) {
    AccountData account = new AccountData("-1", accName, accLogin, cryptPw, int.parse(selectedFolder));
    util.sendJson('account', 
        'POST', account.toString(), requestCompleded);
  }

  void requestCompleded(HttpRequest request) {
    var parsedData = JSON.parse(request.response);

    var data = new Controller().addAccount(parsedData);
    new Controller()..showPage(new ShowAccountComponent()..data=data);
  }
}
