library Controller;

import 'dart:html';
import 'dart:convert';
import 'dart:async'; 
import 'package:web_ui/web_ui.dart';
import 'dart:js';

import 'package:crypto/crypto.dart';
import 'package:google_oauth2_client/google_oauth2_browser.dart';
import 'util/util.dart' as util;
import 'dart:math';


// all webcomponentes which are no sites, like menu etc.
// ist für das laden und die verwaltung der Histoy zuständig
import 'views/main/page-controller.dart';

import 'views/main/menu-folder.dart';
import 'views/main/menu-account.dart';
import 'views/main/app-page.dart';
import 'views/main/start-page.dart';
import 'views/main/header.dart';
import 'views/main/menu.dart';

import 'views/page/elements/account-overview-element.dart';
import 'views/page/elements/folder-overview-element.dart';

// all sites.
// remember to put all pages witch shoud be accessable over Url to the getFirstPage methode.
import 'views/page/folder-overview.dart';
import 'views/page/account-overview.dart';
import 'views/page/add-account.dart';
import 'views/page/show-account.dart';
import 'views/page/show-settings.dart';


import 'package:web_ui/observe/observable.dart' as __observe;
part 'package:ams/util/crypt.dart';
part 'model/beans.dart';

// Oberklasse einer Seite von ihr müssen alle Seiten erben.
part 'package:ams/views/page/web-page.dart';

/**
 * Die Klasse Controller ist die Schnittstelle zwischen Model und Gui.
 * 
 * Daten die von überall erreicht werden müssen liegen hier.
 * 
 * Controller ist ein Singelton
 */
class Controller {  

  // Singleton instance 
  static final Controller _singleton = new Controller._internal();

  // Das Bean in dem alle Daten gespeichert sind 
  // accounts, folder, user
  Data data = new Data();
  var firstPage = -1;

  GoogleOAuth2 auth;

  // PageComponent ist für das laden einer Contentseite zuständlich

  PageComponent pageComp;

  factory Controller() {
    return _singleton;
  }

  Controller._internal();

  // Eine neue Seite kann geladen werden indem der showPage methode ein neues PageObjekt übergeben wird.
  // Dieses Ojekt muss von Webcomponent abgeleitet sein.
  void showPage(page) {
    pageComp..loadePage(page);
  }

  // Die Vorhergehende Seite wird wieder geladen
  void pageBack() {
    pageComp..pageBack();

  }



  // wird von der Mainmethode aufgerufen und inizalisiert die Webseite

  void init() {
    print("hallo");
    //    auth = new GoogleOAuth2(
    //        "382698109176.apps.googleusercontent.com", // Client ID
    //        ["openid", "email","https://www.googleapis.com/auth/userinfo.profile"],
    //        tokenLoaded:(token){oauthReady(token);});

    //context['OAuth'].callMethod('callback', ['google', new JsFunction.withThis(oauthReady)]);
    print("hallo2");
  }
  void login() {
    context['OAuth'].redirect('google','https://localhost:8443');

    // new js.Callback.once((error, result) {
    //     js.context.console.debug(result);
    //         }));
  }
  void oauthReady(error, result) {
    util.createCookie('token',result.access_token , 1);
    data.user.token = result.access_token;
    print('oauthReady');
    loginUserAtServer();
  }
  void loginUserAtServer() {
    print('loginUserAtServer');
    util.sendRequest('api/user/login', 'GET', userLoginSuccesfull, fullPathSet:true, requestFailed: signInFailed);
  }
  void signInFailed(HttpRequest request) {
    logout();
  }


  void userLoginSuccesfull(HttpRequest response) {
    if(response.response != "") {
      var parsedData = JSON.parse(response.response);
      if(parsedData != false) {
        data.user.id = parsedData;
        initData();
      }
    }
  }

  void initData() {

    querySelector('.metrouicss .page').children.first.remove();
    util.addComponent(querySelector('.metrouicss .page'), new AppPage()..host=new DivElement());

    util.sendRequest('', 'GET', (response) {

        var parsedData = JSON.parse(response.response);
        String textToCrypt = "dsgfhnjnm3l298djmfsklli0"+data.user.id+"o32dsjkfdn32irdn,cnsd";
        Crypt crypt = new Crypt();

        data.user.familyName = parsedData['firstName'];

        data.user.givenName = parsedData['lastName'];
        data.user.pictureLink = parsedData['photoUrl'];
        data.user.masterPwCryptText = util.hash(textToCrypt);
        if(parsedData['masterPw'].trim() == "") {
        print('setMasterPw');
        crypt.setMasterPw();
        }
        data.user.masterPw = parsedData['masterPw'];
        int i = 1;
        print(parsedData['folders'].length .toString());
        parsedData['folders'].forEach(addFolder);
        parsedData['accounts'].forEach(addAccount);

        showPage(pageComp.getPage());

        // macht jquery die textfelder bekannt damit der clearbutton funktioniert
        context['jQuery']["Input"](new JsObject.fromBrowserObject({'initAll': true}));
    });
  }

  // fügt einen Ordner in die Sidebar ein
  void addFolder(rawFolder) {
    var folderData = new FolderData(rawFolder['folderid'], rawFolder['foldername']);
    UListElement menu = querySelector('#menu');


    var folderLi = new MenuFolder(folderData)
      ..host = new LIElement() 
      ..id=folderData.id.toString()+"Folder";

    data.folder.add(folderLi);
    data.folder.sort((MenuFolder b, a) {
        return a.data.name.toUpperCase().compareTo(b.data.name.toUpperCase());
        });

    int preElementIndex = data.folder.indexOf(folderLi)-1;
    if(preElementIndex < 0) util.addComponent(menu, folderLi);
    else util.addComponent(menu, folderLi, false, data.folder.elementAt(preElementIndex));

    // Maks the Accounts Moveable
    context['jQuery']('#'+folderData.id.toString()+"Folder ul").sortable(new JsObject.fromBrowserObject({
          "connectWith": ".connectedSortable",
          "cancel": ".notSortable",
          "stop": new JsFunction.withThis(handleAccountMoved)
          })).disableSelection();
  }
  // this methode is called wenn the user sorts an account with drag`n`drop
  void handleAccountMoved( event, ui ) {

    int accountId = int.parse(ui.item.context.id.replaceAll(new RegExp('Account'), ''));
    String folderId = ui.item.context.parent.parent.id.replaceAll(new RegExp('Folder'), '');
    MenuAccount account = data.account.firstWhere((e) { return e.data.id == accountId;});
    MenuFolder folder = data.folder.firstWhere((e) { return e.data.id == account.data.folder;});
    moveAccount( account, folderId, folder.data);    

  }
  // füght einen Account der Sidebar hinzu
  AccountData addAccount(rawAccount, [AccountData accdata]) {
    var accountData;
    if(rawAccount != null) accountData = new AccountData(rawAccount['accountid'], 
        rawAccount['accountname'], rawAccount['login'], rawAccount['password'], rawAccount['folder']);
    if(accdata != null) accountData = accdata;
    //Timer.run(() {

    var accountLi = new MenuAccount()
      ..host = new LIElement()
      ..data=accountData ..id=accountData.id.toString()+"Account";


    data.account.add(accountLi);

    var folderUl = data.folder.firstWhere((E) {
        if(E.data.id == accountData.folder){
        E.data.count++;
        return true;
        }
        else return false;
        }).querySelector('ul');

    data.account.sort((MenuAccount b, a) {
        return a.data.name.toUpperCase().compareTo(b.data.name.toUpperCase());
        });

    List<MenuAccount> accountsForFolder = new List();

    data.account.forEach((E) {
        if(E.data.folder == accountData.folder) accountsForFolder.add(E);
        });

    int preElementIndex = accountsForFolder.indexOf(accountLi)-1;

    if(preElementIndex < 0) util.addComponent(folderUl, accountLi);
    else util.addComponent(folderUl, accountLi, false, accountsForFolder.elementAt(preElementIndex));


    //      context['jQuery']('#'+accountData.id.toString()+"Account").draggable();

    //});
    return accountData;
  }

  void removeFolder(MenuFolder folder) {
    util.sendRequest('folder/'+folder.data.id.toString(), 'DELETE', (_) {
        folder.remove();
        data.folder.remove(folder);
        showPage(new FolderOverview());
        });
  }

  void removeAccount(MenuAccount account, var folder) {
    util.sendRequest('account/'+account.data.id.toString(), 'DELETE', (_) {
        account.remove();
        data.account.remove(account);
        folder.count--;
        showPage(new AccountOverview(folder.id));
        });
  }

  moveAccount(MenuAccount account, String selectedFolder, var folder) {
    AccountData accdata = account.data..folder = int.parse(selectedFolder);
    util.sendJson('account', 
        'PUT', account.data.toString() , (HttpRequest request){
        folder.count--;
        account.remove();
        data.account.remove(account);
        addAccount(null, accdata);
        showPage(new AccountOverview(account.data.folder));
        });
  }

  renameFolder(FolderData folderdata) {
    data.folder.firstWhere((e) {return e.data.id == folderdata.id;}).data.name = folderdata.name;
    util.sendJson('folder', 
        'PUT', '{"folderid":'+folderdata.id.toString()+',"foldername":"'+folderdata.name+'"}', (_) {});
  }

  updateAccount(AccountData accountData) {
    var account = data.account.firstWhere((e) {return e.data.id == accountData.id;})..data = accountData;
    util.sendJson('account', 
        'PUT', accountData.toString(), (_){});
  }

  WebComponent getFirstPage() {
    try {
      switch(firstPage) { 
        case 1: 
          return new AddAccountComponent();
        default: return new FolderOverview(); 
      }
    } catch(_) {
      return new FolderOverview();
    }
  }

  void logout() {
    util.eraseCookie('token');
    if(pageComp != null) pageComp.reset();   
    querySelector('.metrouicss .page').children.first.remove();
    util.addComponent(querySelector('.metrouicss .page'), new StartPage()..host=new DivElement());
    data = new Data();
  }
}

//# sourceMappingURL=controller.dart.map