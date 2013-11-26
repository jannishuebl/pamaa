library page_controller;

import 'dart:html';
import 'package:web_ui/web_ui.dart';
import 'package:js/js.dart' as js;
import 'package:ams/controller.dart';
import 'package:ams/util/util.dart' as util;
import 'package:ams/aes/uuid.dart';

// all sites.
// remember to put all pages witch shoud be accessable over Url to the getFirstPage methode.
import 'package:ams/views/page/folder-overview.dart';
import 'package:ams/views/page/account-overview.dart';
import 'package:ams/views/page/add-account.dart';
import 'package:ams/views/page/show-account.dart';
import 'package:ams/views/page/show-settings.dart';

/** Die Klasse ist das Model zum Seiteninhalt übergebene Seiten zeigt es an.
 *  Außerdem ist sie für die History verantwortlich.
 *
 * **/
class PageComponent extends WebComponent {

  final String contentPage = '#mainPageRegion';
  final String titel = "password4u";
  // All url that matches pages/blabla are redirectet to /
  final String pathToPages = "pages/";
  bool ini = false;
bool statePushed = false;
  PageComponent() {
    // is needed because there are problem wenn the user logsout and relogin again
    new Controller().pageComp = this;

    js.context.History.Adapter.bind(js.context.window,'statechange', new js.Callback.many((_){ 
          if(!statePushed) {
          var State = js.context.History.getState(); 
          int url = State.data.url;
         var page =  getPage(path:url);
    page..host = new DivElement();
    // erst zum lifecycle hinzufügen dann zum pagestack hinzufügen
    util.addComponent(query(contentPage), page, true);
          }
          statePushed = false;
          }));
  }

  /** Zeigt eine seite an. **/
  void loadePage(WebPage page) {     

    page..host = new DivElement();
    // erst zum lifecycle hinzufügen dann zum pagestack hinzufügen
    util.addComponent(query(contentPage), page, true);
    // prüfen ob keine Url angehängt ist. also ob nur sie nur mit domain/ endet.
    // wenn dem so ist wird der Status erstetzt und nicht ein neuer Hinzugefügt
    statePushed = true;
    var State = js.context.History.getState(); 
    if(State.hash.compareTo('/') != 0) {
      //print('pushState');
      js.context.History.pushState(js.map({"url":pathToPages + page.getPageUrl() }), titel, "https://localhost:8443/"+pathToPages + page.getPageUrl()); 
    } else {
      //print('replaceState');
      js.context.History.replaceState(js.map({"url":pathToPages + page.getPageUrl() }), titel, pathToPages + page.getPageUrl()); 
    }}

  void pageBack() {

    window.history.back();

  }
  void reset() {
    js.context.History.pushState(js.map({"url":'/'}), titel, "/"); 
  }

  WebPage getPage({var path:null}) {
//print(window.location.pathname);

    if(path == null) path = window.location.pathname.trim().split("/");
    else path = path.trim().split("/");
    var page;
    if(path[0].compareTo("") == 0) path.removeAt(0);
    if(path.contains("pages")) {
      //print(path[0]);
      page = path[1];
    }
    if(page != null) {
      if(page.compareTo(AccountOverview.pageUrl) == 0) {
        return new AccountOverview(int.parse(path[2]));
      }
      if(page.compareTo(AddAccountComponent.pageUrl) == 0) {
        return new AddAccountComponent();
      }
      if(page.compareTo(FolderOverview.pageUrl) == 0) {
        return new FolderOverview();
      }
      if(page.compareTo(ShowAccountComponent.pageUrl) == 0) {
      return new ShowAccountComponent()..data= new Controller().data.account.firstWhere((e) { return e.data.id == int.parse(path[2]);}).data;
      }
      if(page.compareTo(ShowSettingsComponent.pageUrl) == 0) {
        return new ShowSettingsComponent();
      }
    }
    return new FolderOverview();
  }
}
