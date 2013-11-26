// Auto-generated from add-account.html.
// DO NOT EDIT.

library addaccount;

import 'dart:html' as autogenerated;
import 'dart:svg' as autogenerated_svg;
import 'package:web_ui/web_ui.dart' as autogenerated;
import 'package:web_ui/observe/observable.dart' as __observe;
import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:js';
import 'dart:math';
import '../../controller.dart';
import '../../util/util.dart' as util;
import 'show-account.dart';



/** Die Klasse ist das Model zu der Seite Account hinzufügen. **/
class AddAccountComponent extends WebPage with Observable  {
  /** Autogenerated from the template. */

  autogenerated.ScopedCssMapper _css;

  /** This field is deprecated, use getShadowRoot instead. */
  get _root => getShadowRoot("add-account");
  static final __html1 = new autogenerated.OptionElement(), __shadowTemplate = new autogenerated.DocumentFragment.html('''

  <h2>Add an Account</h2>
  <div style="margin-top: 50px" class="grid">
    <div class="row" style="width: 550px;">
      <div class="span2">Folder</div>
      <div class="span3">
        <div class="input-control select">
          <select></select>
        </div>
      </div>
      <div class="span1">&nbsp;</div>
    </div>
    <div class="row" style="width: 550px;">
      <div class="span2">Accountname</div>
      <div class="span3">
        <div class="input-control text">
          <input maxlength="23" type="text">
          <button class="btn-clear"></button>
        </div>
      </div>
      <div class="span1">&nbsp;</div>
    </div>
    <div class="row" style="width: 550px;">
      <div class="span2">Username</div>
      <div class="span3">
        <div class="input-control text">
          <input type="text">
          <button class="btn-clear"></button>
        </div>
      </div>
      <div class="span1">&nbsp;</div>
    </div>
    <div id="pwRow" class="row" style="width: 550px;">
      <div class="span2">Password</div>
      <div class="span3">
        <div class="input-control text">
          <input id="pwFieldTest" type="text">
          <button class="btn-clear"></button>
        </div>
      </div>
      <div id="generatePwCellWrapper" class="span1" style="width: 120px">
      <div id="generatePwCell" class="toolbar">
        <button id="generatePw" style="width: 80px">Generate</button>
        <button id="togglePwSettings">
          <i class="icon-cog"></i>
        </button>
        <ul id="pwSettings" class="dropdown-menu" style="position: absolute; display: none; padding: 5px;">
          <li>
            <div class="input-control text" id="pwLengthFieldWrapper">
              <button class="btn-clear"></button>
            </div>
          </li>
          <li><label class="input-control checkbox" id="littleWrapper">
        <span class="helper">Lowercase</span>
    </label></li>
    <li><label class="input-control checkbox" id="bigWrapper">
        
        <span class="helper">Uppercase</span>
    </label></li>
    <li><label class="input-control checkbox" id="numWrapper">
        
        <span class="helper">Numbers</span>
    </label></li>
    <li><label class="input-control checkbox" id="spzWrapper">
        
        <span class="helper">Special character</span>
    </label></li>
        </ul>
      </div>
      </div>
    </div>
    <div class="row" style="width: 550px;">
      <div class="span2"></div>
      <div class="span3"></div>
      <button class="span1" style="width: 116px">Save</button>
    </div>
  </div>
  <div id="placeholderElements" style="display: none">
  <input type="checkbox" id="spz"><input type="checkbox" id="num"><input type="checkbox" id="big"><input type="text" id="pwLengthField"><input type="checkbox" id="little">
  </div>
  ''', treeSanitizer: autogenerated.nullTreeSanitizer);
  autogenerated.ButtonElement __e30, __e31;
  autogenerated.InputElement __e27, __e28, __e29, __e32, __e33, __e34, __e35, __e36;
  autogenerated.SelectElement __e26;
  autogenerated.Template __t;

  void created_autogenerated() {
    var __root = createShadowRoot("add-account");
    setScopedCss("add-account", new autogenerated.ScopedCssMapper({"add-account":"[is=\"add-account\"]"}));
    _css = getScopedCss("add-account");
    __t = new autogenerated.Template(__root);
    __root.nodes.add(__shadowTemplate.clone(true));
    __e26 = __root.nodes[3].nodes[1].nodes[3].nodes[1].nodes[1];
    __t.listen(__e26.onChange, ($event) { selectedFolder = __e26.value; });
    __t.oneWayBind(() => selectedFolder, (e) { if (__e26.value != e) __e26.value = e; }, false, false);
    __t.loopIterateAttr(__e26, () => folders, ($list, $index, __t) {
      var folder = $list[$index];
      var __e25;
      __e25 = __html1.clone(true);
      var __binding24 = __t.contentBind(() => folder.data.name, false);
      __e25.nodes.add(__binding24);
      __t.oneWayBind(() => selectedFolder == folder.data.id.toString(), (e) { if (__e25.selected != e) __e25.selected = e; }, false, false);
      __t.oneWayBind(() => folder.data.id.toString(), (e) { if (__e25.value != e) __e25.value = e; }, false, false);
    __t.addAll([new autogenerated.Text('\n            '),
        __e25,
        new autogenerated.Text('\n          ')]);
    });
    __e27 = __root.nodes[3].nodes[3].nodes[3].nodes[1].nodes[1];
    __t.listen(__e27.onInput, ($event) { accName = __e27.value; });
    __t.oneWayBind(() => accName, (e) { if (__e27.value != e) __e27.value = e; }, false, false);
    __e28 = __root.nodes[3].nodes[5].nodes[3].nodes[1].nodes[1];
    __t.listen(__e28.onInput, ($event) { accLogin = __e28.value; });
    __t.oneWayBind(() => accLogin, (e) { if (__e28.value != e) __e28.value = e; }, false, false);
    __e29 = __root.nodes[3].nodes[7].nodes[3].nodes[1].nodes[1];
    __t.listen(__e29.onInput, ($event) { accPw = __e29.value; });
    __t.oneWayBind(() => accPw, (e) { if (__e29.value != e) __e29.value = e; }, false, false);
    __e30 = __root.nodes[3].nodes[7].nodes[5].nodes[1].nodes[3];
    __t.listen(__e30.onClick, ($event) { togglePwMenu(null); });
    __e31 = __root.nodes[3].nodes[9].nodes[5];
    __t.listen(__e31.onClick, ($event) { saveAccount(); });
    __e32 = __root.nodes[5].nodes[1];
    __t.listen(__e32.onChange, ($event) { pwSpz = __e32.checked; });
    __t.oneWayBind(() => pwSpz, (e) { if (__e32.checked != e) __e32.checked = e; }, false, false);
    __e33 = __root.nodes[5].nodes[2];
    __t.listen(__e33.onChange, ($event) { pwNum = __e33.checked; });
    __t.oneWayBind(() => pwNum, (e) { if (__e33.checked != e) __e33.checked = e; }, false, false);
    __e34 = __root.nodes[5].nodes[3];
    __t.listen(__e34.onChange, ($event) { pwBig = __e34.checked; });
    __t.oneWayBind(() => pwBig, (e) { if (__e34.checked != e) __e34.checked = e; }, false, false);
    __e35 = __root.nodes[5].nodes[4];
    __t.listen(__e35.onInput, ($event) { pwLength = __e35.value; });
    __t.oneWayBind(() => pwLength, (e) { if (__e35.value != e) __e35.value = e; }, false, false);
    __e36 = __root.nodes[5].nodes[5];
    __t.listen(__e36.onChange, ($event) { pwLittle = __e36.checked; });
    __t.oneWayBind(() => pwLittle, (e) { if (__e36.checked != e) __e36.checked = e; }, false, false);
    __t.create();
  }

  void inserted_autogenerated() {
    __t.insert();
  }

  void removed_autogenerated() {
    __t.remove();
    __t = __e26 = __e27 = __e28 = __e29 = __e30 = __e31 = __e32 = __e33 = __e34 = __e35 = __e36 = null;
  }

  /** Original code from the component. */


  
  /** Variablen des Interface **/
  bool ini = true;
static  String pageUrl = 'addAccount';

  String getPageUrl() {
    return pageUrl;
  }
  
  String __$selectedFolder = new Controller().data.folder.reversed.first.data.id.toString();
  String get selectedFolder {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'selectedFolder');
    }
    return __$selectedFolder;
  }
  set selectedFolder(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'selectedFolder',
          __$selectedFolder, value);
    }
    __$selectedFolder = value;
  }
  String __$accName;
  String get accName {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'accName');
    }
    return __$accName;
  }
  set accName(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'accName',
          __$accName, value);
    }
    __$accName = value;
  }

  String __$accLogin;
  String get accLogin {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'accLogin');
    }
    return __$accLogin;
  }
  set accLogin(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'accLogin',
          __$accLogin, value);
    }
    __$accLogin = value;
  }

  String __$accPw;
  String get accPw {
    if (__observe.observeReads) {
      __observe.notifyRead(this, __observe.ChangeRecord.FIELD, 'accPw');
    }
    return __$accPw;
  }
  set accPw(String value) {
    if (__observe.hasObservers(this)) {
      __observe.notifyChange(this, __observe.ChangeRecord.FIELD, 'accPw',
          __$accPw, value);
    }
    __$accPw = value;
  }

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

//# sourceMappingURL=add-account.dart.map