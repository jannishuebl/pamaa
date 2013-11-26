library accountOverview;

import 'package:web_ui/web_ui.dart';
import 'dart:html';
import 'dart:async';
import 'dart:js';
import 'package:ams/util/util.dart' as util;
import 'package:ams/controller.dart';
import 'package:ams/views/page/elements/account-overview-element.dart';
import 'package:ams/views/main/menu-folder.dart';

/** Die Klasse ist das Model der Seite Accountübersicht anzeigen**/
class AccountOverview extends WebPage {

  /** Variablen des Interface **/
  bool ini = true;
  // Die Url der Seite
  static String pageUrl = 'accountOverview';
  
  String getPageUrl() {
    return pageUrl + "/" +folder.id.toString();
  }

  @observable
  var folder;

  @observable
  String selectedFolder = new Controller().data.folder.reversed.first.data.id.toString();
  
  int id;
  
  AccountOverview(int folderid ){
    
    folder = new Controller().data.folder.firstWhere((MenuFolder e) {return e.data.id == folderid;}).data;
  }
  
  Map accounts = new Map();
  
  List get folders {
    return new List.from(new Controller().data.folder.reversed);
  }
  
  void init() {
    new Controller().data.account.reversed.forEach((e) {
      if(e.data.folder == folder.id)
      {
      var ul = querySelector('.page-region ul');
      LIElement host = new LIElement();
      
      host.id = 'acc'+e.data.id.toString();
      
      host.onMouseOver.listen((e){
        host.querySelector('.listviewSelectButton').style.display="block";
        host.querySelector('.listviewSelectButtonHaken').style.display="block";
      });
      
      host.onMouseOut.listen((e){
        if(!host.classes.contains("selected")) {
          host.querySelector('.listviewSelectButton').style.display="none";
          host.querySelector('.listviewSelectButtonHaken').style.display="none";
        }
      });
      
      AccountOverviewElement accountElement = new AccountOverviewElement(e)..host = host..folder=folder;
      util.addComponent(ul, accountElement);
      
      accounts.putIfAbsent(accountElement.account.data.id.toString(), () { return accountElement;});
      accountElement.querySelector('.listviewSelectButton').onClick.listen(clickSelect);
      accountElement.querySelector('.listviewSelectButtonHaken').onClick.listen(clickSelect);
      
      }
    });
    
    
  }
  
  void clickSelect (e) {
    (e.target.parent as Element).attributes.forEach((k,v) {
      print(k+v);
    });
   var id = (e.target as Element).attributes["account"];
   accounts[id].isSelected = true;
   context['jQuery']('#acc'+id).toggleClass('selected');
   context['jQuery']('#acc'+id+' .listviewSelectButton').toggleClass('blue');
  }
  
  void remove() {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to delete the accounts?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            accounts.forEach((k,AccountOverviewElement v) {
              if(v.classes.contains('selected'))  {
                new Controller()..removeAccount(v.account, folder);
              }
            });
//            new Controller()..showPage(new AccountOverview(folder.id));
            this.remove();
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
    
  }
  
  void move() {
    var dialog = new JsObject.fromBrowserObject({
      'title'      : 'Warning..!',
      'content'    : 'Are you sure to move the accounts?',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            accounts.forEach((k,AccountOverviewElement v) {
              if(v.classes.contains('selected'))  {
                new Controller()..moveAccount(v.account, selectedFolder, folder);
              }
            });
//            new Controller()..showPage(new AccountOverview(folder.id));
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
      'content'    : 'Enter your new Foldername:<br><br><div class="input-control text"><input autofocus="true" id="foldername" type="text" /><button class="btn-clear"></button></div>',
      'draggable'  : true,
      'buttonsAlign': 'right',
      'buttons'    : {
        'No': {},
        'Yes'    : {
          'action': new JsFunction.withThis(() {
            InputElement foldernameField = querySelector('#foldername');
            String foldername = foldernameField.value;

                new Controller()..renameFolder(folder..name=foldername);
                new Controller()..showPage(new AccountOverview(folder.id));
            this.remove();
          })
        }
      }
    });
    context['jQuery'].Dialog(dialog);
    
  }
  
}

